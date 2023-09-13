import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:student/new_student/new_student_viewmodel.dart';

import 'home/home_view.dart';
import 'home/home_viewmodel.dart';
import 'model/student_model.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  var dir = await getApplicationCacheDirectory();

  Hive.init(dir.path);
  Hive.registerAdapter(StudentAdapter());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (BuildContext context) => HomeViewModel(),),
        ChangeNotifierProvider(create: (BuildContext context) => NewStudentViewModel(),),
      ],
      child: MaterialApp(
        title: 'Student App',
        home: HomeView()
      ),
    );
  }
}
