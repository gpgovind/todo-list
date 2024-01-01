import 'package:bloc_with_todo/data/data_model.dart';

abstract class TaskState {}

class InitialState extends TaskState {}

class TaskAddState extends TaskState {
  NotesModel noteList;
  TaskAddState(this.noteList);
}

class TaskErrorState extends TaskState {
  String errorMessage;
  TaskErrorState(this.errorMessage);
}

class TaskShowState extends TaskState {
  final List<NotesModel> noteList;
  TaskShowState(this.noteList);
}

class TaskDeleteState extends TaskState {}
