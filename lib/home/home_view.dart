import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:student/home/home_viewmodel.dart';
import 'package:student/model/student_model.dart';
import 'package:student/new_student/new_student_view.dart';
import 'package:student/repository/student_repository.dart';

import 'component/student_tile.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<HomeViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          child: TextField(
            controller: provider.controller,
            decoration: InputDecoration(
              hintText: "Search",
              prefix: Icon(Icons.search_rounded),
              suffix: GestureDetector(
                  onTap: () => provider.reset(),
                  child: Icon(Icons.clear)),
              filled: true,
            ),
            onChanged: (pattern) => setState(() {}),
          ),
        ),
      ),
      body: Container(
        margin: EdgeInsets.all(10),
        // padding: EdgeInsets.all(10),
        child: FutureBuilder(
            future: Hive.openBox<Student>(StudentRepository.studentBox),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  provider.studentList = snapshot.data!.values
                      .toList()
                      .where((element) => element.name
                          .toLowerCase()
                          .contains(provider.controller.text.toLowerCase()))
                      .toList();
                  return provider.studentList.isEmpty
                      ? Center(child: Text('No Student'))
                      : ListView.builder(
                          key: UniqueKey(),
                          itemCount: provider.studentList.length,
                          itemBuilder: (context, index) {
                            var item = provider.studentList[index];
                            return StudentTile(item: item,onDelete: ()=> provider.deleteStudent(item));
                          },
                        );
                }
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => NewStudentView()),
          );
          setState(() {});
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
