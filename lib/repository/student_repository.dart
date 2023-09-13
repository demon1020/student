import 'package:hive/hive.dart';
import 'package:student/model/student_model.dart';

class StudentRepository{

  String studentBox = 'student';

  Future<List<Student>> fetchStudents() async{
    List<Student> temp = [];
    var box = await Hive.openBox<Student>(studentBox);
    temp = box.values.toList();
    return temp;
  }

  addStudent(Student student) async {
    var box = await Hive.openBox<Student>(studentBox);
    // temp = box.values.toList();

    box.add(student);
  }

  deleteStudent(Student student) async {
    List<Student> temp = [];

    var box = await Hive.openBox<Student>(studentBox);
    temp = box.values.toList();
    int index = temp.indexWhere((element) => element.id == student.id);
    box.deleteAt(index);

    // if(index == -1){
    //   print("Student does not exists");
    // }else{
    //   box.deleteAt(index);
    // }
  }
}