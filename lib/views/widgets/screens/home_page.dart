import 'dart:developer';

import 'package:bloc_with_todo/bloc/addtaskbloc/add_state.dart';
import 'package:bloc_with_todo/util/color.dart';
import 'package:bloc_with_todo/views/widgets/screens/textfiled_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

import '../../../bloc/addtaskbloc/add_bloc.dart';
import '../../../bloc/addtaskbloc/add_event.dart';
import '../../../data/data_model.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController tittleController = TextEditingController();

  @override
  void initState() {
    super.initState();
    BlocProvider.of<TaskAddBloc>(context).add(TaskShowEvent());
  }

  @override
  void dispose() {
    Hive.box<NotesModel>('TodoBox').close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor().backgroundColor,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => BlocProvider(
                        create: (context) => TaskAddBloc(),
                        child: const TextFiledScreen(),
                      )));
        },
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(
                vertical: 30,
                horizontal: 30,
              ),
              child: Text(
                'Notes',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 30),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 10, right: 10, bottom: 5),
                  child: BlocConsumer<TaskAddBloc, TaskState>(
                    listener: (context, state) => TaskShowEvent(),
                    builder: (context, state) {
                      if (state is TaskShowState && state.noteList.isNotEmpty) {
                        log(state.noteList.length.toString());
                        return CupertinoListSection.insetGrouped(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(33)),
                            backgroundColor: AppColor().noteListColor,
                            children: List.generate(
                                state.noteList.length,
                                (index) => CupertinoListTile(
                                    trailing: IconButton(
                                        color: Colors.red,
                                        onPressed: () {
                                          try {
                                            BlocProvider.of<TaskAddBloc>(
                                                    context)
                                                .add(TaskDeleteEvent(
                                              state.noteList[index].key,
                                            ));
                                            BlocProvider.of<TaskAddBloc>(
                                                    context)
                                                .add(TaskShowEvent());
                                          } catch (e) {
                                            log('error while deleting $e');
                                          }
                                        },
                                        icon: const Icon(Icons.delete)),
                                    title: Text(state.noteList[index].title))));
                      } else if (state is TaskErrorState) {
                        return Center(child: Text(state.errorMessage));
                      } else {
                        return Container();
                      }
                    },
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
