import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'to_do_item.dart';

final _firestore = FirebaseFirestore.instance;

final List<Container> nothingToDo = [
  Container(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
    decoration: const BoxDecoration(
      borderRadius: const BorderRadius.all(Radius.circular(10)),
    ),
    child: const Text(
      "You still don't have registered tasks, maybe it's time 🤔",
      textAlign: TextAlign.center,
      style: const TextStyle(fontWeight: FontWeight.bold),
    ),
  )
];

class ToDoListStream extends StatelessWidget {
  final String userID;
  const ToDoListStream({
    Key key,
    this.userID,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore
          .collection('Users')
          .where("user", isEqualTo: userID)
          .orderBy("date", descending: true)
          .orderBy("status", descending: false)
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
            final todoUid = todo.id;
            final todoText = todo['text'];
            final todoPS = todo['ps'];
            final todoDate = todo['date'];
            final todoStatus = todo['status'];
            final todoUser = todo['user'];
            final DateTime date = todoDate.toDate();
            final todoWidget = ToDoItem(
              todoUid,
              todoText,
              todoPS,
              date,
              todoStatus,
              todoUser,
            );
            listToDo.add(todoWidget);
          }
          return Expanded(
            child: Container(
              child: ListView(
                padding: const EdgeInsets.all(20),
                children: listToDo.length >= 1 ? listToDo : nothingToDo,
              ),
            ),
          );
        }
      },
    );
  }
}
