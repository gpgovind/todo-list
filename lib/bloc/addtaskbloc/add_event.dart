import '../../data/data_model.dart';

abstract class TaskEvent {}

class TaskAddEvent extends TaskEvent {
  NotesModel noteList;
  TaskAddEvent(this.noteList);
}

class TaskShowEvent extends TaskEvent {}

class TaskErrorEvent extends TaskEvent {}

class TaskEditEvent extends TaskEvent {
  NotesModel noteList;
  TaskEditEvent(this.noteList);
}

class TaskDeleteEvent extends TaskEvent {
  dynamic key;
  TaskDeleteEvent(this.key,);
}
