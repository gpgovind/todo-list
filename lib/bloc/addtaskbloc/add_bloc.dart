import 'dart:developer';

import 'package:bloc_with_todo/bloc/addtaskbloc/add_state.dart';
import 'package:bloc_with_todo/data/data_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'add_event.dart';

class TaskAddBloc extends Bloc<TaskEvent, TaskState> {
  TaskAddBloc() : super(InitialState()) {
    on<TaskAddEvent>((event, emit) async {
      try {
        emit(TaskAddState(event.noteList));
        var box = NotesModel.getdata();
        await box.add(event.noteList);
        log('successful add to hive');
        EasyLoading.dismiss();
      } catch (e) {
        emit(TaskErrorState('error while adding to hive $e'));
        EasyLoading.showError(e.toString(), dismissOnTap: true);
      }
    });

    on<TaskShowEvent>((event, emit) async {
      try {
        var box = NotesModel.getdata();
        // box.flush();
        List<NotesModel> notesList = box.values.toList();
        emit(TaskShowState(notesList));
        log('TaskShowEvent called');
      } catch (e) {
        emit(TaskErrorState('error while fetching data'));
      }
    });

    on<TaskDeleteEvent>((event, emit) async {
      try {
        if (event.key != null) {
          var box = NotesModel.getdata();
          box.delete(event.key);
          emit(TaskDeleteState());
        }
      } catch (e) {
        emit(TaskErrorState('error while deleting data'));
      }
    });
    on<TaskEditEvent>((event, emit) async {
      try {
        var box = NotesModel.getdata();
        await box.putAt(event.noteList.id, event.noteList);
        emit(TaskEditState());
        EasyLoading.dismiss();
        log('edit successful');
      } catch (e) {
        emit(TaskErrorState('error while editing data'));
      }
    });
  }
}
