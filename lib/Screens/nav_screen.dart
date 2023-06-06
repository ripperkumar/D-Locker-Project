import "package:d_locker/Screens/file_screen.dart";
import "package:d_locker/Screens/storage_screen.dart";
import "package:d_locker/Widgets/header.dart";
import "package:d_locker/Widgets/zDrawerMenuWidget.dart";
import 'package:d_locker/Controllers/navigation_controller.dart';
import "package:flutter/material.dart";
import 'package:get/get.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
class NavScreen extends StatefulWidget {
  static String idScreen = "NavScreen";

  @override
  State<NavScreen> createState() => _NavScreenState();
}

class _NavScreenState extends State<NavScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.red,
        title: Row(
          children: [
            Spacer(),
            FaIcon(FontAwesomeIcons.fileArrowDown,color: Colors.white,size: 30,),
          ],
        ),
        leading: MenuWidget(isBlack:false),
      ),
      body: Stack(
        children: [
          Obx( ()=> Get.find<NavigationController>().tab.value=="Storage"? Container(
            height:    MediaQuery.of(context).size.width*0.8,
            decoration: new BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.vertical(
                  bottom: Radius.elliptical(
                      MediaQuery.of(context).size.width, 100.0)),
            ),
          ):Container(),
          ),
          Column(
            children: [
              Header(),
             Obx( ()=> Get.find<NavigationController>().tab.value=="Storage"?StorageScreen():FilesScreen()
             ),
            ],
          ),
        ],
      ),

    );
  }
}
// bottomNavigationBar: Theme(
// data: Theme.of(context)
//     .copyWith(iconTheme: IconThemeData(color: Colors.white)),
// child: CurvedNavigationBar(
// animationCurve: Curves.easeInOut,animationDuration: Duration(milliseconds: 300),
// color: Colors.deepOrangeAccent,
// backgroundColor: Colors.transparent,
// height: 60,
// items: items,
// index: index,
// onTap: (i) => setState(() => index = i)),
// ),