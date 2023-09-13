import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student/home/home_viewmodel.dart';
import 'package:student/model/student_model.dart';
import 'package:student/new_student/new_student_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    super.initState();
    var provider = Provider.of<HomeViewModel>(context, listen: false);
    provider.getStudentList();
    setState(() {});
  }

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
                  onTap: () {
                    provider.controller.clear();
                    provider.searchStudent(provider.controller.text);
                  },
                  child: Icon(Icons.clear)),
              filled: true,
            ),
            onChanged: (pattern) {
              provider.searchStudent(pattern.trim());
            },
          ),
        ),
      ),
      body: Container(
        margin: EdgeInsets.all(10),
        // padding: EdgeInsets.all(10),
        child: provider.isLoading
            ? CircularProgressIndicator()
            : provider.filteredStudentList.isEmpty
                ? Center(child: Text('No Students'))
                : ListView.builder(
                    itemCount: provider.filteredStudentList.length,
                    itemBuilder: (context, index) {
                      var item = provider.filteredStudentList[index];
                      return StudentTile(item: item, provider: provider);
                    },
                  ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var result = await Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => NewStudentView()),
          );
          provider.addNewStudent(result);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class StudentTile extends StatelessWidget {
  const StudentTile({
    super.key,
    required this.item,
    required this.provider,
  });

  final Student item;
  final HomeViewModel provider;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(item.name),
        trailing: IconButton(
          onPressed: () {
            provider.deleteStudent(item);
          },
          icon: Icon(Icons.delete),
        ),
      ),
    );
  }
}
