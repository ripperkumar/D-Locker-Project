import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
class MenuWidget extends StatelessWidget {
   MenuWidget({Key? key,this.isBlack=false}) : super(key: key);
 bool isBlack;
  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          ZoomDrawer.of(context)!.toggle();
        },
        icon: FaIcon(FontAwesomeIcons.alignLeft,size: 22,color: isBlack?Colors.black:Colors.white,));
  }
}