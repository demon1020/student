import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student/new_student/new_student_viewmodel.dart';

class NewStudentView extends StatefulWidget {
  const NewStudentView({super.key});

  @override
  State<NewStudentView> createState() => _NewStudentViewState();
}

class _NewStudentViewState extends State<NewStudentView> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<NewStudentViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Student'),
      ),
      body: Container(
        height: 300,
        width: double.infinity,
        margin: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormField(
              controller: provider.controller,
            ),
            ElevatedButton(
              onPressed: () => provider.addNewStudent(context),
              child: Text('Add'),
            )
          ],
        ),
      ),
    );
  }
}
