import 'package:bloc_with_todo/util/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../../../bloc/addtaskbloc/add_bloc.dart';
import '../../../bloc/addtaskbloc/add_event.dart';
import '../../../data/data_model.dart';
import '../custom_textfiled.dart';

class EditScreen extends StatefulWidget {
  final String title;
  final String content;
  final dynamic id;

  const EditScreen(
      {super.key,
      required this.content,
      required this.title,
      required this.id});

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();

  @override
  void initState() {
    titleController.text = widget.title;
    contentController.text = widget.content;
    super.initState();
  }

  @override
  void dispose() {
    titleController.dispose();
    contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor().textfiledBackgroundColor,
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          EasyLoading.show();
          Future.delayed(const Duration(seconds: 1)).then((value) {
            BlocProvider.of<TaskAddBloc>(context).add(TaskEditEvent(NotesModel(
                id: widget.id,
                task: contentController.text,
                title: titleController.text)));
            BlocProvider.of<TaskAddBloc>(context).add(TaskShowEvent());
            Navigator.pop(context);
          });
        },
        backgroundColor: Colors.grey.shade300,
        child: const Icon(Icons.save),
      ),
      appBar: AppBar(
        backgroundColor: AppColor().textfiledBackgroundColor,
        leading: Container(
          margin: const EdgeInsets.all(6.0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18), color: Colors.grey[500]),
          child: IconButton(
              color: AppColor().backgroundColor,
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_ios_new_outlined)),
        ),
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 15),
        child: ListView(
          children: [
            CustomNewTextFiled(
              controller: titleController,
              hintText: 'Title',
              fontSize: 25,
              mainFontSize: 24,
            ),
            CustomNewTextFiled(
              controller: contentController,
              hintText: 'Type something here',
              fontSize: 18,
              mainFontSize: 20,
              keyboardType: TextInputType.multiline,
            )
          ],
        ),
      )),
    );
  }
}
