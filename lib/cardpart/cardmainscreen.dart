import 'package:d_locker/cardpart/AddPaymentCardScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_brand.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'AppColors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import "package:d_locker/Widgets/zDrawerMenuWidget.dart";

class CardSave extends StatefulWidget {
  const CardSave({Key? key}) : super(key: key);
  static const String idScreen = "Main screen";
  @override
  State<CardSave> createState() => _CardSaveState();
}

class _CardSaveState extends State<CardSave> {
  RxList userCards = [].obs;
  String cardNumber = '5555 55555 5555 4444';
  String expiryDate = '12/25';
  String cardHolderName = 'Osama Qureshi';
  String cvvCode = '123';
  bool isCvvFocused = false;
  bool useGlassMorphism = false;
  bool useBackgroundImage = false;
  OutlineInputBorder? border;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  getUserCards() {
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('cards')
        .snapshots()
        .listen((event) {
      userCards.value = event.docs;
    });
  }

  @override
  void initState() {
    getUserCards();
    border = OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.grey.withOpacity(0.7),
        width: 2.0,
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.green,
        leading: MenuWidget(isBlack: false),
      ),
      resizeToAvoidBottomInset: false,
      body: Container(
        width: Get.width,
        height: Get.height,
        child: Stack(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(25),
                    bottomLeft: Radius.circular(25)),
                color: Colors.green,
              ),
              height: 175,
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: Text(
                  "My Cards",
                  style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ),
            Positioned(
              top: 120,
              left: 0,
              right: 0,
              bottom: 80,
              child: Obx(() => userCards.length == 0
                  ? Container(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Text(
                      'Nothing here yet, add new card by tapping below button',
                      maxLines: 2,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              )
                  : ListView.builder(
                        shrinkWrap: true,
                        itemBuilder: (ctx, i) {
                          String cardNumber = '';
                          String expiryDate = '';
                          String cardHolderName = '';
                          String cvvCode = '';

                          try {
                            cardNumber = userCards.value[i].get('number');
                          } catch (e) {
                            cardNumber = '';
                          }

                          try {
                            expiryDate = userCards.value[i].get('expiry');
                          } catch (e) {
                            expiryDate = '';
                          }

                          try {
                            cardHolderName = userCards.value[i].get('name');
                          } catch (e) {
                            cardHolderName = '';
                          }

                          try {
                            cvvCode = userCards.value[i].get('cvv');
                          } catch (e) {
                            cvvCode = '';
                          }

                          return CreditCardWidget(
                            cardBgColor: Colors.black,
                            cardNumber: cardNumber,
                            expiryDate: expiryDate,
                            cardHolderName: cardHolderName,
                            cvvCode: cvvCode,
                            bankName: 'heheehehe',
                            showBackView: isCvvFocused,
                            obscureCardNumber: false,
                            obscureCardCvv: false,
                            isHolderNameVisible: true,
                            isSwipeGestureEnabled: true,
                            onCreditCardWidgetChange:
                                (CreditCardBrand creditCardBrand) {},
                          );
                        },
                        itemCount: userCards.length,
                      )),
            ),
            Positioned(
                bottom: 10,
                right: 10,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "Add new card",
                      style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.greenColor),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    FloatingActionButton(
                      onPressed: () {
                        Get.to(() => AddPaymentCardScreen());
                      },
                      child: Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                      ),
                      backgroundColor: AppColors.greenColor,
                    )
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
