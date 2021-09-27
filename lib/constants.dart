import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
// Global variables Start //

const kFontFamilyPoppins = 'Poppins';
final ThemeData kTheme = ThemeData.light();

// Global variables End //

// Colors and list of colors Start //

const kPrimaryColor = const Color(0xFF29b6f6);
const kLightBlue = const Color(0xFF4fc3f7);
const kRedColor = const Color(0xFFff9e9e);
const kOrangeColor = const Color(0xFFffb288);
const kGreenColor = const Color(0xFFaed581);
const kGrayColor = const Color(0xFFa9a9a9);
const kGraySecondColor = const Color(0xFF808080);

const kUnfinishedColors = const [kOrangeColor, kRedColor];
const kFinishedColors = const [kGreenColor, kGreenColor];
const kProgressColors = const [kLightBlue, kPrimaryColor];
const kDisabledColors = const [kGrayColor, kGraySecondColor];

final kDecorationBlue = BoxDecoration(
  gradient: const LinearGradient(
    colors: kProgressColors,
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  ),
  boxShadow: [
    BoxShadow(
        color: Colors.blue.withOpacity(0.4),
        blurRadius: 8,
        spreadRadius: 1,
        offset: const Offset(4, 4))
  ],
  borderRadius: const BorderRadius.all(Radius.circular(20)),
);

final kDecorationGreen = BoxDecoration(
  gradient: const LinearGradient(
    colors: kFinishedColors,
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  ),
  boxShadow: [
    BoxShadow(
        color: Colors.green.withOpacity(0.4),
        blurRadius: 8,
        spreadRadius: 1,
        offset: const Offset(4, 4))
  ],
  borderRadius: const BorderRadius.all(
    Radius.circular(20),
  ),
);

final kDecorationRed = BoxDecoration(
  gradient: const LinearGradient(
    colors: kUnfinishedColors,
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  ),
  boxShadow: [
    BoxShadow(
        color: Colors.red.withOpacity(0.4),
        blurRadius: 8,
        spreadRadius: 1,
        offset: const Offset(4, 4))
  ],
  borderRadius: const BorderRadius.all(
    Radius.circular(20),
  ),
);

final kDecorationWhite = BoxDecoration(
  color: Colors.white,
  boxShadow: [
    BoxShadow(
        color: Colors.black.withOpacity(0.4),
        blurRadius: 6,
        spreadRadius: 1,
        offset: const Offset(4, 4))
  ],
  borderRadius: const BorderRadius.all(
    Radius.circular(20),
  ),
);

// Colors and list of colors End //

// Styles Start //

const kTextStyleTitle = const TextStyle(fontWeight: FontWeight.bold);

const kLabelStyle = const TextStyle(color: Colors.white);

const kStyleDialog = const TextStyle(color: Colors.white, fontSize: 20);

const kOutlineInput = const OutlineInputBorder(
  borderSide: BorderSide(color: kPrimaryColor),
  borderRadius: const BorderRadius.all(
    Radius.circular(10),
  ),
);
// Styles End //

// Firebase Start //

User loggedInUser;
void getCurrentUser() {
  final _auth = FirebaseAuth.instance;
  try {
    final currentUser = _auth.currentUser;
    if (currentUser != null) {
      loggedInUser = currentUser;
    }
  } catch (e) {
    print(e);
  }
}

int queryFinished;
int queryUnfinished;

void getElements() async {
  queryFinished = await FirebaseFirestore.instance
      .collection('Users')
      .where("user", isEqualTo: loggedInUser.uid)
      .where("status", isEqualTo: 2)
      .get()
      .then((value) {
    return value.size;
  });

  queryUnfinished = await FirebaseFirestore.instance
      .collection('Users')
      .where("user", isEqualTo: loggedInUser.uid)
      .where("status", isEqualTo: 3)
      .get()
      .then((value) {
    return value.size;
  });
}

// Firebase End //

//Widget//
Widget buildIconItem({@required IconData icon, @required int color}) {
  return Icon(icon, color: color == 0 ? kPrimaryColor : Colors.white);
}
