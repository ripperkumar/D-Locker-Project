import 'package:d_locker/Modals/drawer_item_modal.dart';
import 'package:d_locker/Screens/Signup_page.dart';
import 'package:d_locker/Screens/addCard_screen.dart';
import 'package:d_locker/Screens/digiWallet.dart';
import 'package:d_locker/Screens/drawerMenuPage.dart';
import 'package:d_locker/Screens/menuCard_screen.dart';
import 'package:d_locker/Screens/nav_screen.dart';
import 'package:d_locker/cardpart/AddPaymentCardScreen.dart';
import 'package:d_locker/cardpart/cardmainscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

class ZDrawer extends StatefulWidget {
  static const String idScreen = "ZDrawer screen";
  ZDrawer(this.cItem);
  DrawerMenuItem cItem ;

  @override
  State<ZDrawer> createState() => _ZDrawerState();
}

class _ZDrawerState extends State<ZDrawer> {

  @override
  Widget build(BuildContext context) {
    DrawerMenuItem currentItem = widget.cItem ;
    return ZoomDrawer(
      style: DrawerStyle.Style1,
      borderRadius: 40,
      angle: -10,
      slideWidth: MediaQuery.of(context).size.width*0.6,
      showShadow: true,
      backgroundColor: Colors.white60,
      mainScreen: getScreen(widget.cItem),
      menuScreen: Builder(
        builder: (context) {
          return MenuPage(
            currentItem:widget.cItem,
            onSelectedItem:(item){
            setState(() {
              widget.cItem = item;
            });
            ZoomDrawer.of(context)!.close();
            }
          );
        }
      ),
    );

  }

  getScreen(currentItem) {
    if(currentItem==MenuItem.dwallet)
      {
   return DigiWallet();
      }
    if(currentItem == MenuItem.dataVault){
      return NavScreen();
    }
    if(currentItem == MenuItem.viewCards){
      return CardSave();
    }
    else{
      return AddPaymentCardScreenState();
    }
  }


}


