import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../../constants.dart';

final _firestore = FirebaseFirestore.instance;

class ToDoItem extends StatelessWidget {
  final String uid;
  final String todoText;
  final String todoPS;
  final DateTime todoDate;
  final int todoStatus;

  ToDoItem(
    this.uid,
    this.todoText,
    this.todoPS,
    this.todoDate,
    this.todoStatus,
  );

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    Future<void> _showMyDialog(
        Function function, String title, String desc, String button) async {
      return showDialog<void>(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: SingleChildScrollView(
              child: ListBody(children: <Widget>[Text(desc)]),
            ),
            actions: <Widget>[
              TextButton(
                child: Text(
                  'Cancel',
                  style: const TextStyle(
                      color: kRedColor, fontWeight: FontWeight.bold),
                ),
                onPressed: () => Navigator.of(context).pop(),
              ),
              TextButton(
                  child: Text(button,
                      style: const TextStyle(
                          color: kPrimaryColor, fontWeight: FontWeight.bold)),
                  onPressed: function),
            ],
          );
        },
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: kDecorationBlue,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Wrap(
              children: <Widget>[
                Container(
                  width: size.width / 2.3,
                  child: Text(
                    '$todoText',
                    maxLines: 5,
                    overflow: TextOverflow.clip,
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                ),
                Container(
                  width: size.width / 3.5,
                  padding: EdgeInsets.only(top: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          _showMyDialog(() {
                            updateData(uid, 2, 0);
                            Navigator.of(context).pop();
                          }, 'Finish', 'Did you finish this task?', 'Done');
                        },
                        child:
                            buildIconItem(icon: Icons.check_circle, color: 1),
                      ),
                      const SizedBox(width: 10),
                      GestureDetector(
                        onTap: () {
                          _showMyDialog(() {
                            updateData(uid, 3, 0);
                            Navigator.of(context).pop();
                          },
                              'Not finish',
                              "Don't you think you will accomplish this task?",
                              'Unfinish');
                        },
                        child: buildIconItem(icon: Icons.cancel, color: 1),
                      ),
                      const SizedBox(width: 10),
                      GestureDetector(
                        onTap: () {
                          _showMyDialog(() {
                            updateData(uid, 0, 1);
                            Navigator.of(context).pop();
                          }, 'Delete', 'You can delete this task', 'Delete');
                        },
                        child: buildIconItem(icon: Icons.delete, color: 1),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text('$todoPS', style: const TextStyle(color: Colors.white))
          ],
        ),
      ),
    );
  }
}

void updateData(String uid, int status, int delete) {
  if (delete == 1) {
    _firestore.collection("Users").doc(uid).delete();
    getElements();
  } else {
    _firestore.collection("Users").doc(uid).update({
      "status": status,
    });
    getElements();
  }
}
