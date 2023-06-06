import 'package:d_locker/Modals/google_signin.dart';
import 'package:d_locker/Screens/main_screen.dart';
import 'package:d_locker/Screens/menuCard_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUp_page extends StatefulWidget {
  const SignUp_page({Key? key}) : super(key: key);
  static const String idScreen = "SignUp screen";
  @override
  _SignUp_pageState createState() => _SignUp_pageState();
}

class _SignUp_pageState extends State<SignUp_page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasData) {
            return MainScreen();
          } else if (snapshot.hasError) {
            return Center(
              child: Text("Something Went Wrong!"),
            );
          } else {
            return SignUpWidget();
          }
        },
      ),
    );
  }
}

class SignUpWidget extends StatelessWidget {
  const SignUpWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:HexColor("#071330"),
      body: Stack(
        children: [
          Positioned(
            top: -20,
            left: -50,
            child: SvgPicture.asset(
              'assets/blob.svg',
              color: Colors.orange,
              height: 210,
            ),
          ),
          Positioned(
            top: 50,
            left: 12,
            child: Text(
              'Login',
              style:  GoogleFonts.poppins(textStyle:TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                  fontWeight: FontWeight.w700),
            ),),
          ),
          Positioned(
            top: 140,
            right: 20,
            child: SvgPicture.asset(
              'assets/illus4.svg',
              height: 250,
            ),
          ),
          Positioned(
            top: 390,
            right: 65,
            child: Column(
              children: [
                Text(
                  'D-Locker',
                  style:
                  GoogleFonts.neuton(
                    textStyle:  TextStyle(
                        fontSize: 60,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                ),),
              ],
            ),
          ),
          Positioned(
            top: 472,
            right: 61,
            child: Text(
              'All in One app for Your',
              maxLines: 2,
              textAlign: TextAlign.center,
              style:  GoogleFonts.poppins(textStyle:TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                  color: Colors.red),
            ),),
          ),
          Positioned(
            top: 499,
            right: 61,
            child: Text(
              'Document & Wallet',
              maxLines: 2,
              textAlign: TextAlign.center,
              style:  GoogleFonts.poppins(textStyle:TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.red),
            ),),
          ),

          Positioned(
            bottom: 100,
            left: 38,
            child: OutlinedButton(
              onPressed: () {
                final provider = Provider.of<GoogleSignInProvider>(
                    context,
                    listen: false);
                provider.googleLogin(context);
              },
              style: ButtonStyle(
                shape: MaterialStateProperty.all<
                    RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                backgroundColor:
                MaterialStateProperty.all<Color>(Colors.orange),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 14, 0, 14),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:[
                  SvgPicture.asset(
                  'assets/google.svg',
                    height: 25,
                ),
                    Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: Text(
                        'Continue with Google',
                        style: GoogleFonts.poppins(textStyle:TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontFamily: 'Pretendard',
                          fontWeight: FontWeight.bold,
                        ),),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: FaIcon(FontAwesomeIcons.arrowRight,color: Colors.black,),
                    )
                  ],
                ),
              ),
            ),
          ),



        ],
      ),
    );
  }
}

