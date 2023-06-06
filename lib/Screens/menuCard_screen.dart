import 'package:d_locker/Widgets/zDrawerMenuWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MenuCard extends StatefulWidget {
  const MenuCard({Key? key}) : super(key: key);
  static const String idScreen = "MenuCard screen";
  @override
  State<MenuCard> createState() => _MenuCardState();
}

class _MenuCardState extends State<MenuCard> {
  int index = 2;
  final screens = [];
  @override
  Widget build(BuildContext context) {
    final items = <Widget>[
      Icon(
        Icons.home,
        size: 30,
      ),
      Icon(
        Icons.search,
        size: 30,
      ),
      Icon(
        Icons.favorite,
        size: 30,
      ),
      Icon(
        Icons.settings,
        size: 30,
      ),
      Icon(
        Icons.person,
        size: 30,
      ),
    ];
    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text('menu screen'),
        leading: MenuWidget(),
      ),
      body: Center(
        child: Text('$index',style:TextStyle(color: Colors.white),),
      ),
      bottomNavigationBar: Theme(
        data: Theme.of(context)
            .copyWith(iconTheme: IconThemeData(color: Colors.white)),
        child: CurvedNavigationBar(
          animationCurve: Curves.easeInOut,animationDuration: Duration(milliseconds: 300),
            color: Colors.deepPurple,
            backgroundColor: Colors.transparent,
            height: 60,
            items: items,
            index: index,
            onTap: (i) => setState(() => index = i)),
      ),
    );
  }
}

