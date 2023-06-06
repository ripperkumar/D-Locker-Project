import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Logo extends StatelessWidget {
  Logo({Key? key, this.width}) : super(key: key);
  final double? width;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.center,
          child: Container(
            width: width ?? 320.0,
            child: Image.asset(
              'assets/crypto_bg.png',
              fit: BoxFit.fill,
            ),
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: Transform.rotate(
            angle: 0,
            child: Text(
              "Crypto Wallet!",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 40.0,
                fontWeight: FontWeight.w800,
                shadows: [
                  Shadow(
                    offset: Offset(0.0, 3.0),
                    blurRadius: 10.0,
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                ],
              ),
               
            ),
          ),
        ),
      ],
    );
  }
}