import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../constants.dart';
import '../../../components/background_app.dart';
import '../../../components/description.dart';
import '../../../components/input_data.dart';
import '../../../components/rounded_button.dart';
import '../../../components/customtoast.dart';

TextEditingController _task;
TextEditingController _description;
TextEditingController _date;
bool errorTask;
bool errorDate;

class Body extends StatefulWidget {
  Body({Key key});

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  DateTime _dateTime;
  bool spinner = false;
  final toast = FToast();

  @override
  void initState() {
    super.initState();
    getCurrentUser();
    initValues();
  }

  void initValues() {
    _task = TextEditingController();
    _description = TextEditingController();
    _date = TextEditingController();
    errorDate = false;
    errorTask = false;
    toast.init(context);
  }

  @override
  Widget build(BuildContext context) {
    final _now = DateTime.now();
    return Background(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  const Text('Add new task ➕',
                      style: const TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 35,
                      )),
                  InputData(
                    label: 'Task',
                    hint: 'What is the task?',
                    disable: false,
                    controller: _task,
                    error: errorTask,
                    messageError: 'Task is necessary',
                  ),
                  DescriptionWidget(controller: _description, readOnly: false),
                  InputData(
                    label: 'Date',
                    hint: 'Pick a date',
                    disable: true,
                    controller: _date,
                    icon: Icons.calendar_today,
                    error: errorDate,
                    messageError: 'Must have a date',
                    function: () {
                      showDatePicker(
                              context: context,
                              initialDate: _now,
                              firstDate: _now,
                              lastDate: DateTime(_now.year + 10))
                          .then((value) {
                        setState(() {
                          _dateTime = value;
                          _date.text = DateFormat("yyyy-MM-dd").format(value);
                        });
                      });
                      FocusScope.of(context).unfocus();
                    },
                  ),
                  RoundedButton(
                    text: 'Register task',
                    press: () async {
                      var result = await Connectivity().checkConnectivity();
                      if (result == ConnectivityResult.none) {
                        showBottomToast(' Needs connection', 2);
                        return false;
                      }

                      errorTask = validate(_task.text);
                      errorDate = validate(_date.text);

                      if (errorDate || errorTask) {
                        setState(() {});
                        return false;
                      }

                      Timestamp myTimeStamp = Timestamp.fromDate(_dateTime
                          .add(const Duration(days: 1))
                          .subtract(const Duration(seconds: 1)));
                      try {
                        FirebaseFirestore.instance.collection("Users").add(
                          {
                            "text": _task.text,
                            "status": 1,
                            "date": myTimeStamp,
                            "ps": _description.text,
                            "user": loggedInUser.uid
                          },
                        );

                        clear();
                        showBottomToast('Successful save', 1);
                      } on FormatException catch (e) {
                        print(e);
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void showBottomToast(String message, int value) => toast.showToast(
      child: buildToast(message: message, value: value),
      gravity: ToastGravity.BOTTOM);

  bool validate(String text) {
    if (text == '' || text == null) return true;
    return false;
  }

  void clear() {
    _task.clear();
    _date.clear();
    _description.clear();
    errorDate = false;
    errorTask = false;
  }
}
