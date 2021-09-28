import 'package:flutter/material.dart';

class InfoMessage extends StatelessWidget {
  const InfoMessage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            const Icon(Icons.check_circle),
            const Flexible(child: Text('Finish the task')),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            const Icon(Icons.cancel),
            const Flexible(child: Text('Unfinish the task')),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            const Icon(Icons.delete),
            const Flexible(child: Text('Delete the task')),
          ],
        ),
      ],
    );
  }
}
