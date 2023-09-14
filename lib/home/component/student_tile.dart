import 'package:flutter/material.dart';

import '../../model/student_model.dart';

class StudentTile extends StatelessWidget {
  final Student item;
  final VoidCallback onDelete;

  const StudentTile({
    super.key,
    required this.item,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(item.name),
        trailing: IconButton(
          onPressed: onDelete,
          icon: Icon(Icons.delete),
        ),
      ),
    );
  }
}
