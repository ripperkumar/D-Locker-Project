import 'dart:ui';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import "package:d_locker/Widgets/zDrawerMenuWidget.dart";
import 'package:d_locker/Screens/main_screen.dart';
import 'package:d_locker/Screens/payment_screen.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:get/get.dart';

class DigiWallet extends StatefulWidget {
  const DigiWallet({Key? key}) : super(key: key);
  static const String idScreen = "DigiWallet screen";

  @override
  State<DigiWallet> createState() => _DigiWalletState();
}

class _DigiWalletState extends State<DigiWallet> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        elevation: 0,
        leading: MenuWidget(isBlack: true),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                decoration: BoxDecoration(
                    color: Colors.teal,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(35),
                        bottomRight: Radius.circular(35))),
                height: MediaQuery.of(context).size.height * 0.35,
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Digital ',
                        style: TextStyle(color:HexColor('2C3333'),fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      Text(
                        'Payment ',
                        style: TextStyle(color:HexColor('2C3333'),fontSize: 26, fontWeight: FontWeight.w400),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        width:MediaQuery.of(context).size.width*0.75 ,
                          child: Text(
                        'Reliable Payments Made Simple: Experience Hassle-free Transactions with our App. ',
                        maxLines: 3,
                        style: TextStyle(color:HexColor('2C3333'),fontSize: 17,fontWeight: FontWeight.w500,height: 1.2),
                      )),
                      Expanded(child: Container()),
                      Row(
                        children: [
                          Container(
                              width:MediaQuery.of(context).size.width*0.75 ,
                              child: Text(
                                '1-Click Pay ',
                                maxLines: 3,
                                style: TextStyle(color:HexColor('CBE4DE'),fontSize: 30,fontWeight: FontWeight.bold,height: 1.2),
                              )),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              Container(
                child: Image.asset(
                  'assets/paymentPage.jpg',
                  height: MediaQuery.of(context).size.height * 0.525,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.fitHeight,
                ),
              )
            ],
          ),
          Positioned(
            top: 210,
            right: 25,
              child: Container(
                height: 90,
                width: 90,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(100))),

                child: GestureDetector(
                  onTap: () {
                    Get.to(PaymentScreen());
                  },
                  child: AnimatedContainer(
                    child: Center(
                      child: FaIcon(
                        FontAwesomeIcons.arrowRight,
                        size: 30,
                        color:
                        Color.fromARGB(255, 83, 220, 230),
                      ),
                    ),
                    // Providing duration parameter
                    // to create animation
                    duration: const Duration(
                      milliseconds: 200,
                    ),
                    height: 70,
                    width: 70,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      shape: BoxShape.circle,
                      // when _isElevated is false, value
                      // of inset parameter will be true
                      // that will create depth effect.
                      boxShadow:
                      [

                        const BoxShadow(
                          color: Color(0xFFBEBEBE),
                          // Shadow for bottom right corner
                          offset: Offset(10, 10),
                          blurRadius: 30,
                          spreadRadius: 1,
                        ),
                        const BoxShadow(
                          color: Colors.white,
                          // Shadow for top left corner
                          offset: Offset(-10, -10),
                          blurRadius: 30,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
          ),
        ],
      ),
    );
  }
}


