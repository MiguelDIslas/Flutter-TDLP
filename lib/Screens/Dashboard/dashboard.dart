import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'components/navigation_drawer_widget.dart';
import '../AddTask/add_task.dart';
import '../Home/home.dart';
import '../Tasks/tasks.dart';
import '../../constants.dart';

class DashboardScreen extends StatefulWidget {
  static String routeName = "/dashboard";

  DashboardScreen({Key key});

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  void initState() {
    super.initState();
    getCurrentUser();
    verifyDocuments();
    getElements();
  }

  void verifyDocuments() async {
    final Timestamp myTimeStamp = Timestamp.fromDate(DateTime.now());
    var snapshots = FirebaseFirestore.instance
        .collection('Users')
        .where("date", isLessThan: myTimeStamp)
        .where("user", isEqualTo: loggedInUser.uid)
        .snapshots();
    try {
      await snapshots.forEach((snapshot) async {
        List<DocumentSnapshot> documents = snapshot.docs;

        for (var document in documents) {
          await document.reference.update(<String, dynamic>{
            'status': 3,
          });
        }
      });
    } catch (e) {
      print(e);
    }
  }

  int _currentIndex = 0;
  static final tabs = [Home(), AddTask(), Tasks()];

  List<BottomNavyBarItem> listIcons = [
    BottomNavyBarItem(
      icon: const Icon(Icons.apps),
      title: const Text('Dashboard'),
      activeColor: kRedColor,
    ),
    BottomNavyBarItem(
        icon: const Icon(Icons.add_circle),
        title: const Text('Add task'),
        activeColor: kGreenColor),
    BottomNavyBarItem(
      icon: const Icon(FontAwesomeIcons.tasks),
      title: const Text('Tasks'),
      activeColor: kPrimaryColor,
    )
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: NavigationDrawerWidget(),
        body: tabs[_currentIndex],
        bottomNavigationBar: BottomNavyBar(
          selectedIndex: _currentIndex,
          showElevation: true, // use this to remove appBar's elevation
          onItemSelected: (index) => setState(
            () => _currentIndex = index,
          ),
          items: listIcons,
        ),
      ),
    );
  }
}
