import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:intl/intl.dart';

import 'content_dialog.dart';
import '../../../constants.dart';
import '../../../maps.dart';

class ToDoItem extends StatelessWidget {
  final String uid;
  final String todoText;
  final String todoPS;
  final DateTime todoDate;
  final int todoStatus;
  final String useruid;

  ToDoItem(
    this.uid,
    this.todoText,
    this.todoPS,
    this.todoDate,
    this.todoStatus,
    this.useruid,
  );

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final _now = DateTime.now();
    TextEditingController controllerTask = TextEditingController(),
        controllerDescription = TextEditingController(),
        controllerDate = TextEditingController();
    bool errorTask = false, errorDate = false;
    controllerTask.text = todoText;
    controllerDescription.text = todoPS;
    controllerDate.text = DateFormat("yyyy-MM-dd").format(todoDate);
    DateTime _dateTime = todoDate;

    void datePicker() {
      showDatePicker(
              context: context,
              initialDate: _now,
              firstDate: _now,
              lastDate: DateTime(_now.year + 10))
          .then((value) {
        _dateTime = value;
        controllerDate.text = DateFormat("yyyy-MM-dd").format(value);
      });
    }

    final String dateFinal = months[todoDate.month] +
        " / " +
        todoDate.day.toString() +
        " / " +
        todoDate.year.toString();

    final statusData = todoStatus == 1
        ? [kDecorationBlue, FontAwesomeIcons.spinner]
        : todoStatus == 2
            ? [kDecorationGreen, Icons.check_circle]
            : [kDecorationRed, Icons.cancel];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: statusData[0],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Wrap(
                  children: [
                    Container(
                      width: size.width / 8,
                      child: GestureDetector(
                        onTap: () {
                          Alert(
                            context: context,
                            style: AlertStyle(
                              descStyle: const TextStyle(fontSize: 14),
                            ),
                            type: AlertType.none,
                            title: "Edit task",
                            desc: todoStatus == 1
                                ? ''
                                : 'If the task are finished or not finished you can close this message or delete it',
                            content: ContentDialog(
                              controllerTask: controllerTask,
                              errorTask: errorTask,
                              controllerDescription: controllerDescription,
                              controllerDate: controllerDate,
                              errorDate: errorDate,
                              editable: todoStatus == 1 ? false : true,
                              dateFunction: () => datePicker(),
                            ),
                            buttons: [
                              DialogButton(
                                  child: Text("Delete", style: kStyleDialog),
                                  onPressed: () {
                                    FirebaseFirestore.instance
                                        .collection("Users")
                                        .doc(uid)
                                        .delete();
                                    Navigator.pop(context);
                                    getElements();
                                  },
                                  gradient: LinearGradient(
                                      colors: kUnfinishedColors)),
                              DialogButton(
                                child: Text("Edit", style: kStyleDialog),
                                onPressed: () {
                                  if (todoStatus != 1) return false;

                                  Timestamp myTimeStamp =
                                      Timestamp.fromDate(_dateTime);
                                  FirebaseFirestore.instance
                                      .collection("Users")
                                      .doc(uid)
                                      .update({
                                    "text": controllerTask.text,
                                    "ps": controllerDescription.text,
                                    "date": myTimeStamp,
                                  });
                                  getElements();
                                  Navigator.pop(context);
                                },
                                gradient: LinearGradient(
                                    colors: todoStatus == 1
                                        ? kFinishedColors
                                        : kDisabledColors),
                              ),
                            ],
                          ).show();
                        },
                        child: const Icon(FontAwesomeIcons.solidEdit,
                            color: Colors.white),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Container(
                      width: size.width / 2.2,
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
                  ],
                ),
                Container(
                  width: size.width / 10,
                  child: GestureDetector(
                    child: Icon(statusData[1], color: Colors.white),
                  ),
                )
              ],
            ),
            const SizedBox(height: 15),
            Text(
              dateFinal,
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.white),
            ),
            const SizedBox(height: 8),
            Text('$todoPS', style: const TextStyle(color: Colors.white))
          ],
        ),
      ),
    );
  }
}
