import 'package:d_locker/Modals/drawer_item_modal.dart';
import 'package:d_locker/Modals/google_signin.dart';
import 'package:d_locker/Screens/Signup_page.dart';
import 'package:d_locker/Screens/payment_screen.dart';
import 'package:d_locker/Screens/profile_Screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class MenuItem {
  static final dwallet = DrawerMenuItem(title: 'D-Wallet', icon: Icons.payment);
  static final dataVault =
      DrawerMenuItem(title: 'Data Vault', icon: Icons.file_present_sharp);
  static final addCardDetails =
      DrawerMenuItem(title: 'Add Card Details', icon: Icons.doorbell_outlined);
  static final help = DrawerMenuItem(title: 'help', icon: Icons.help);
  static final aboutUs =
      DrawerMenuItem(title: 'aboutUs', icon: Icons.question_mark_rounded);
  static final viewCards =
      DrawerMenuItem(title: 'View Cards', icon: Icons.rate_review);
  static final logout =
      DrawerMenuItem(title: 'Log Out', icon: FontAwesomeIcons.signOut);
  static final all = <DrawerMenuItem>[
    dataVault,
    viewCards,
    addCardDetails,
    dwallet,

    help,
    aboutUs,

  ];
}

class MenuPage extends StatelessWidget {
  MenuPage({Key? key, required this.currentItem, required this.onSelectedItem})
      : super(key: key);
  final DrawerMenuItem currentItem;
  final currentUser = FirebaseAuth.instance.currentUser;
  final ValueChanged<DrawerMenuItem> onSelectedItem;
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData.dark(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.deepPurpleAccent,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 200,
                width: 150,
                child: GestureDetector(
                  onTap:() {
                Get.to(ProfileScreen());
                  },
                  child: DrawerHeader(
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              radius: 35,
                              backgroundImage:
                                  NetworkImage(currentUser!.photoURL!),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              currentUser!.displayName!,
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.fade,
                              style: TextStyle(
                                fontFamily: "PretendardBold",
                                fontSize: 20.0,
                              ),
                            )
                          ],
                        )),
                  ),
                ),
              ),
              ...MenuItem.all.map(buildMenuItem).toList(),
              Spacer(
                flex: 2,
              ),
              ListTileTheme(
                selectedColor: Colors.white,
                child: ListTile(
                  selectedTileColor: Colors.black26,
                  minLeadingWidth: 20,
                  leading: Icon(MenuItem.logout.icon),
                  title: Text(MenuItem.logout.title),
                  onTap: () {
                    final provider = Provider.of<GoogleSignInProvider>(context,
                        listen: false);
                    provider.logout(context).then((value) =>
                        Navigator.pushNamedAndRemoveUntil(
                            context, SignUp_page.idScreen, (route) => false));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildMenuItem(DrawerMenuItem item) {
    return ListTileTheme(
      selectedColor: Colors.white,
      child: ListTile(
        selectedTileColor: Colors.black26,
        selected: currentItem == item,
        minLeadingWidth: 20,
        leading: Icon(item.icon),
        title: Text(item.title),
        onTap: () {
          onSelectedItem(item);
        },
      ),
    );
  }
}
