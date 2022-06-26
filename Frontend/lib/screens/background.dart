import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_arc_speed_dial/flutter_speed_dial_menu_button.dart';
import 'package:flutter_arc_speed_dial/main_menu_floating_action_button.dart';
import 'package:hackathon/screens/add_trip.dart';
import 'package:hackathon/screens/recomdations.dart';

import 'account_page.dart';
import 'add_event.dart';
import 'homepage.dart';

class Background extends StatefulWidget {
  const Background({Key? key}) : super(key: key);

  @override
  State<Background> createState() => _BackgroundState();
}

class _BackgroundState extends State<Background> with SingleTickerProviderStateMixin {
  late int currentPage;
  late TabController tabController;

  @override
  void initState() {
    currentPage = 0;
    tabController = TabController(length: 2, vsync: this);
    tabController.animation!.addListener(
      () {
        final value = tabController.animation!.value.round();
        if (value != currentPage && mounted) {
          changePage(value);
        }
      },
    );
    super.initState();
  }

  void changePage(int newPage) {
    setState(() {
      currentPage = newPage;
    });
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  List<Widget> children = [
    HomePage(),
    Reccomendations(),
    AccountPage(),

  ];
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: children[_selectedIndex],
        bottomNavigationBar: AnimatedBottomNavigationBar(
          icons: [Icons.home, Icons.list ,Icons.settings],
          backgroundColor: Color(0xff0c5fb3),
          activeColor: Colors.white,
          splashColor: Colors.lightBlue,
          activeIndex: _selectedIndex,
          gapLocation: GapLocation.none,
          notchSmoothness: NotchSmoothness.defaultEdge,
          leftCornerRadius: 32,
          rightCornerRadius: 32,
          onTap: (index) => setState(() => _selectedIndex = index),
          //other params
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: SpeedDialMenuButton(
          isMainFABMini: false,
          mainMenuFloatingActionButton: MainMenuFloatingActionButton(
              mini: false,
              child: Icon(Icons.add),
              onPressed: () {},
              closeMenuChild: Icon(Icons.close),
              closeMenuForegroundColor: Colors.white,
              closeMenuBackgroundColor: Colors.red),
          floatingActionButtonWidgetChildren: <FloatingActionButton>[
            FloatingActionButton(
              mini: true,
              child: Icon(Icons.add_location_alt_rounded),
              onPressed: () {
                showModalBottomSheet(context: context,
                    isScrollControlled: true,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(25.0))), builder: (BuildContext context) => AddTrip());
              },
              backgroundColor: Colors.lightBlue,
            ),
            FloatingActionButton(
              mini: true,
              child: Icon(Icons.event_note),
              onPressed: () {
                showModalBottomSheet(context: context, isScrollControlled: true, shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(25.0))), builder: (BuildContext context) => AddEvent());
              },
              backgroundColor: Colors.lightBlue,
            ),
          ],
          isSpeedDialFABsMini: true,
          paddingBtwSpeedDialButton: 30.0,
        ));
  }
}
