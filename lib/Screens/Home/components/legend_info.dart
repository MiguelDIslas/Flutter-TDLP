import 'package:flutter/material.dart';
import '../../../constants.dart';

class LegendInfo extends StatelessWidget {
  const LegendInfo({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 55),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          buildRowItem(icon: Icons.check_circle, text: 'Finish this task'),
          buildRowItem(icon: Icons.cancel, text: 'Set unfinish this task'),
          buildRowItem(icon: Icons.delete, text: 'Delete this task'),
        ],
      ),
    );
  }
}

Widget buildRowItem({@required String text, @required IconData icon}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: <Widget>[Icon(icon, color: kPrimaryColor), Text(text)],
  );
}
