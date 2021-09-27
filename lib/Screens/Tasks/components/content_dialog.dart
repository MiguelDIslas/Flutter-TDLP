import 'package:flutter/material.dart';
import '../../../components/input_data.dart';
import '../../../components/description.dart';

class ContentDialog extends StatelessWidget {
  final TextEditingController controllerTask;
  final bool errorTask;
  final TextEditingController controllerDescription;
  final TextEditingController controllerDate;
  final bool errorDate;
  final Function dateFunction;
  final bool editable;

  ContentDialog(
      {Key key,
      this.controllerTask,
      this.errorTask,
      this.controllerDescription,
      this.controllerDate,
      this.errorDate,
      this.dateFunction,
      this.editable})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        InputData(
          label: 'Task',
          hint: 'What is the task?',
          disable: editable,
          controller: controllerTask,
          error: errorTask,
          messageError: 'Task is needed',
        ),
        DescriptionWidget(
          controller: controllerDescription,
          readOnly: editable,
        ),
        InputData(
          label: 'Date',
          hint: 'Pick a date',
          disable: editable,
          controller: controllerDate,
          icon: !editable ? Icons.calendar_today : null,
          error: errorDate,
          messageError: 'Must have a date',
          function: dateFunction,
        ),
      ],
    );
  }
}
