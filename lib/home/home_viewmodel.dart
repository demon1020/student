import 'package:flutter/material.dart';
import 'package:student/model/student_model.dart';
import 'package:student/repository/student_repository.dart';

class HomeViewModel extends ChangeNotifier {
  bool isLoading = false;
  TextEditingController controller = TextEditingController();
  List<Student> filteredStudentList = [];

  List<Student> studentList = [
    // Student(id: 1, name: "Babu"),
    // Student(id: 2, name: "Baburam"),
    // Student(id: 3, name: "Rajaram"),
    // Student(id: 4, name: "Rameshwar"),
    // Student(id: 5, name: "Kunal"),
  ];

  void getStudentList() async{
    isLoading = true;
    //get data from db
    studentList = await StudentRepository().fetchStudents();
    filteredStudentList = studentList;
    isLoading = false;
    notifyListeners();
  }

  void addNewStudent(String name) async{
    int id = studentList.length + 1;
    var student = Student(id: id, name: name);
    studentList.add(student);
    await StudentRepository().addStudent(student);
    getStudentList();
    notifyListeners();
  }

  void deleteStudent(Student student) async{
    int index = studentList.indexOf(student);
    studentList.removeAt(index);
    await StudentRepository().deleteStudent(student);
    getStudentList();
    notifyListeners();
  }

  void searchStudent(String pattern) {
    if (filteredStudentList.isEmpty && pattern.isEmpty) {
      filteredStudentList = studentList;
    }
    filteredStudentList = filteredStudentList
        .where((element) =>
            element.name.toLowerCase().contains(pattern.toLowerCase()))
        .toList();

    print(filteredStudentList.length);
    notifyListeners();
  }
}
