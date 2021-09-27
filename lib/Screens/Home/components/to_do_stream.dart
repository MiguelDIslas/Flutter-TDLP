import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo_list_project/constants.dart';
import 'to_do_item.dart';

final _firestore = FirebaseFirestore.instance;

final List<Container> nothingToDo = [
  Container(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        colors: kFinishedColors,
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
      borderRadius: const BorderRadius.all(Radius.circular(10)),
    ),
    child: const Text(
      'Nothing to do today\nIt seems you can relax 😴',
      textAlign: TextAlign.center,
      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
    ),
  )
];

class ToDoStream extends StatelessWidget {
  final String userId;
  const ToDoStream({
    Key key,
    this.userId,
  });

  @override
  Widget build(BuildContext context) {
    final _now = DateTime.now();
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore
          .collection('Users')
          .where("user", isEqualTo: userId)
          .where("status", isEqualTo: 1)
          .where("date",
              isGreaterThan: _now.subtract(const Duration(days: 1)),
              isLessThan: _now.add(const Duration(days: 1)))
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Column(
            children: <Widget>[
              Center(child: const CircularProgressIndicator()),
            ],
          );
        } else {
          final todos = snapshot.data.docs;
          List<ToDoItem> listToDo = [];
          for (var todo in todos) {
            final todoDate = todo['date'];
            final DateTime date = todoDate.toDate();
            final todoWidget = ToDoItem(
              todo.id,
              todo['text'],
              todo['ps'],
              date,
              todo['status'],
            );
            listToDo.add(todoWidget);
          }
          return Expanded(
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(20))),
              child: ListView(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 10),
                  children: listToDo.length >= 1 ? listToDo : nothingToDo),
            ),
          );
        }
      },
    );
  }
}
