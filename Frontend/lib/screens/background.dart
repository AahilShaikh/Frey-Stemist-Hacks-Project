import 'package:flutter/material.dart';

import 'account_page.dart';
import 'homepage.dart';

class Background extends StatefulWidget {
  const Background({Key? key}) : super(key: key);

  @override
  State<Background> createState() => _BackgroundState();
}

class _BackgroundState extends State<Background> {
  List<Widget> children = [
    HomePage(),
    AccountPage(),
  ];
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: children[_selectedIndex],
      
    );
  }
}
