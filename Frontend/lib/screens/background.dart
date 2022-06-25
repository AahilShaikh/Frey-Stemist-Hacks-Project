import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:floating_frosted_bottom_bar/app/frosted_bottom_bar.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:translucent_navigation_bar/translucent_navigation_bar.dart';

import '../models/tabs_icon.dart';
import 'account_page.dart';
import 'homepage.dart';

class Background extends StatefulWidget {
  const Background({Key? key}) : super(key: key);

  @override
  State<Background> createState() => _BackgroundState();
}

class _BackgroundState extends State<Background>
    with SingleTickerProviderStateMixin {
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
    AccountPage(),
  ];
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FrostedBottomBar(
        opacity: 0.6,
        sigmaX: 5,
        sigmaY: 5,
        child: TabBar(
          indicatorPadding: const EdgeInsets.fromLTRB(6, 0, 6, 0),
          controller: tabController,
          indicator: const UnderlineTabIndicator(
            borderSide: BorderSide(color: Colors.blue, width: 4),
            insets: EdgeInsets.fromLTRB(16, 0, 16, 8),
          ),
          tabs: [
            TabsIcon(
                icons: Icons.home,
                color: currentPage == 0 ? Colors.grey : Colors.white),
            TabsIcon(
                icons: Icons.settings,
                color: currentPage == 1 ? Colors.grey : Colors.white),
          ],
        ),
        borderRadius: BorderRadius.circular(500),
        duration: const Duration(milliseconds: 800),
        hideOnScroll: true,
        body: (context, controller) => TabBarView(
          // shrinkWrap: false,
          controller: tabController,
          dragStartBehavior: DragStartBehavior.down,
          physics: const BouncingScrollPhysics(),
          children: [
            HomePage(),
            AccountPage(),
          ],
        ),
      ),
      floatingActionButton: FabCircularMenu(children: <Widget>[
        IconButton(
          icon: Icon(Icons.travel_explore),
          tooltip: "Create a new trip",
          onPressed: () {},
        ),
        IconButton(
            icon: Icon(Icons.add_location_alt),
            tooltip: "Add a new activity",
            onPressed: () {})
      ]),
    );
  }
}
