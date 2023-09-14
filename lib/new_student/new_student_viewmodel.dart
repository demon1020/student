import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../model/student_model.dart';
import '../repository/student_repository.dart';

class NewStudentViewModel extends ChangeNotifier {
  TextEditingController controller = TextEditingController();

  void addNewStudent(context) async{
    var student = Student(id: Uuid().v4(), name: controller.text);
    await StudentRepository().addStudent(student);
    controller.clear();
    notifyListeners();
    Navigator.pop(context);
  }

}
