import 'package:flutter/material.dart';
import 'package:student/model/student_model.dart';
import 'package:student/repository/student_repository.dart';

class HomeViewModel extends ChangeNotifier {
  TextEditingController controller = TextEditingController();
  List<Student> studentList = [];

  deleteStudent(Student student) async{
    await StudentRepository().deleteStudent(student);
    notifyListeners();
  }

  void reset(){
    controller.clear();
    notifyListeners();
  }
}
