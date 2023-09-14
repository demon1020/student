import 'package:hive/hive.dart';
import 'package:student/model/student_model.dart';

class StudentRepository{
  static const String studentBox = 'student';

  addStudent(Student student) async {
    var box = await Hive.openBox<Student>(studentBox);
    box.add(student);
  }

  deleteStudent(Student student) async {
    var box = await Hive.openBox<Student>(studentBox);
    List<Student> temp = box.values.toList();
    int index = temp.indexWhere((element) => element.id == student.id);
    box.deleteAt(index);
  }
}