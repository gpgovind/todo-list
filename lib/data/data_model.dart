import 'package:hive/hive.dart';
part 'data_model.g.dart';

@HiveType(typeId: 0)
class NotesModel extends HiveObject {
  @HiveField(0)
  String title;
  @HiveField(1)
  String task;
  @HiveField(2)
  int id;

  NotesModel({required this.id, required this.task, required this.title});
}
