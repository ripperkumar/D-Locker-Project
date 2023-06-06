import 'package:d_locker/Screens/digiWallet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../Widgets/zDrawerMenuWidget.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  var _razorpay = Razorpay();
  var amountController = TextEditingController();
  final currentUser = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    // TODO: implement initState
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    super.initState();
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // Do something when payment succeeds
    print("Payment successfull");
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Do something when payment fails
    print("Payment Fail");
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet is selected
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: size.height,
            width: size.width,
            color: Colors.white,
          ),
          Positioned.fill(
            top: -80.0,
            child: Image(
              image: AssetImage('assets/shapes.png'),
              fit: BoxFit.contain,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 30, left: 10),
            child: IconButton(
              iconSize: 40,
              color: Colors.white,
              icon: Icon(Icons.arrow_back_ios_sharp),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DigiWallet()),
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 110, left: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '1 Click',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    color: Colors.white,
                    fontSize: 43,
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(
                        offset: Offset(0, 3),
                        blurRadius: 4,
                        color: Color.fromRGBO(0, 0, 0, 0.3),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'Smart',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 43,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(
                        offset: Offset(0, 3),
                        blurRadius: 4,
                        color: Color.fromRGBO(0, 0, 0, 0.3),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'Payment',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 43,
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(
                        offset: Offset(0, 3),
                        blurRadius: 4,
                        color: Color.fromRGBO(0, 0, 0, 0.3),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Column(
            children: [
              SizedBox(
                height: 500,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 100,
                ),
                child: TextField(
                  style: TextStyle(
                    color: Color.fromARGB(255, 0, 0, 0),
                    fontSize: 30,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Enter Amount',
                    hintStyle: TextStyle(
                      fontFamily: 'Montserrat',
                      color: Color.fromARGB(255, 128, 224, 255),
                      fontSize: 26,
                    ),
                    contentPadding: EdgeInsets.symmetric(vertical: 5),
                  ),
                  keyboardType: TextInputType.number,
                  controller: amountController,
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: GestureDetector(
                    onTap: () {
                      var options = {
                        'key': " ",
                        'name': currentUser!.displayName,

                        'description': "1 Click SmartPayment",
                        'amount':
                            (int.parse(amountController.text) * 100).toString(),

                        'timeout': 300, // in seconds
                        'prefill': {'contact': '', 'email': ''}
                      };

                      _razorpay.open(options);
                    },
                    child: Container(
                      width: 250,
                      height: 70.0,
                      margin: EdgeInsets.only(bottom: 20.0),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0xff03F9F2), Color(0xff632BFF)],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Center(
                        child: Text(
                          'Pay Now',
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 32.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 40,
              )
            ],
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _razorpay.clear(); // Removes all listeners
    super.dispose();
  }
}
