import 'package:hive/hive.dart';
part 'student_model.g.dart';
@HiveType(typeId: 0)
class Student{
  @HiveField(0)
  int id;
  @HiveField(1)
  String name;
  Student({required this.id, required this.name});
}