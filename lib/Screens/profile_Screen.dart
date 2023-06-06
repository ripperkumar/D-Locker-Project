import 'package:d_locker/Modals/google_signin.dart';
import 'package:d_locker/Screens/Signup_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
class ProfileScreen extends StatelessWidget {
  static const String idScreen = "DigiWallet screen";
  final currentUser = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery
        .of(context)
        .size
        .width;
    double height = MediaQuery
        .of(context)
        .size
        .height;
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(
          decoration: BoxDecoration(

              color: Colors.grey[300],

          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 73),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: (){
                          Navigator.pop(context);
                        },
                        child: Container(
                          height: 80,
                          width: 80,
                          decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(50),

                              boxShadow: [
                                const BoxShadow(
                                  color: Colors.grey,
                                  offset: Offset(4, 4),
                                  blurRadius: 15,
                                  spreadRadius: 1,
                                ),
                                const BoxShadow(
                                  color: Colors.white,
                                  offset: Offset(-4, -4),
                                  blurRadius: 15,
                                  spreadRadius: 1,
                                ),
                              ]
                          ),
                          child: Center(
                            child: FaIcon(
                              FontAwesomeIcons.arrowLeft,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),

                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'My Profile',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 44,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Nisebuschgardens',
                    ),
                  ),
                  SizedBox(
                    height: 22,
                  ),
                  Container(
                    height: height * 0.43,

                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        double innerHeight = constraints.maxHeight;
                        double innerWidth = constraints.maxWidth;
                        return Stack(
                          fit: StackFit.expand,
                          children: [
                            Positioned(
                              bottom: 0,
                              left: 0,
                              right: 0,
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.grey[300],
                                    borderRadius: BorderRadius.circular(50),

                                    boxShadow: [
                                      const BoxShadow(
                                        color: Colors.grey,
                                        offset: Offset(4, 4),
                                        blurRadius: 15,
                                        spreadRadius: 1,
                                      ),
                                      const BoxShadow(
                                        color: Colors.white,
                                        offset: Offset(-4, -4),
                                        blurRadius: 15,
                                        spreadRadius: 1,
                                      ),
                                    ]
                                ),
                                height: innerHeight * 0.72,
                                width: innerWidth,

                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 70,
                                    ),
                                    Text(
                                      currentUser!.displayName.toString(),
                                      style: TextStyle(
                                        color: Color.fromRGBO(39, 105, 171, 1),
                                        fontFamily: 'Nunito',
                                        fontSize: 30,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              'Email: ',
                                              style: TextStyle(
                                                color: Colors.grey[700],
                                                fontFamily: 'Nunito',
                                                fontSize: 18,
                                              ),
                                            ),
                                            Text(
                                              '${currentUser!.email}',
                                              style: TextStyle(
                                                color: Color.fromRGBO(
                                                    39, 105, 171, 1),
                                                fontFamily: 'Nunito',
                                                fontSize: 18,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 15,),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              'Secret key: ',
                                              style: TextStyle(
                                                color: Colors.grey[700],
                                                fontFamily: 'Nunito',
                                                fontSize: 18,
                                              ),
                                            ),
                                            Container(
                                              width: width*0.36,
                                              child: SelectableText(
                                                '${currentUser!.uid}',
                                                maxLines: 1,
                                                style: TextStyle(
                                                  color: Color.fromRGBO(
                                                      39, 105, 171, 1),
                                                  fontFamily: 'Nunito',
                                                  fontSize: 18,
                                                ),
                                              ),
                                            ),
                                            IconButton(onPressed: ()async{
                                              await Clipboard.setData(ClipboardData(text:currentUser!.uid.toString() ));
                                            }, icon: FaIcon(FontAwesomeIcons.copy,color: Color.fromRGBO(
                                                39, 105, 171, 1),size: 28,))
                                          ],
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              top: 110,
                              right: 20,
                              child: FaIcon(
                                FontAwesomeIcons.gear,
                                color: Colors.grey[700],
                                size: 30,
                              ),
                            ),
                            Positioned(
                              top: 0,
                              left: 0,
                              right: 0,
                              child: Center(
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.grey[300],
                                      borderRadius: BorderRadius.circular(90),

                                      boxShadow: [
                                        const BoxShadow(
                                          color: Colors.black,
                                          offset: Offset(4, 4),
                                          blurRadius: 15,
                                          spreadRadius: 1,
                                        ),
                                        const BoxShadow(
                                          color: Colors.white,
                                          offset: Offset(-4, -4),
                                          blurRadius: 15,
                                          spreadRadius: 1,
                                        ),
                                      ]
                                  ),
                                  child: CircleAvatar(
                                    radius: 75,
                                    backgroundImage:
                                    NetworkImage(currentUser!.photoURL!),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
              Center(
                child: GestureDetector(
                  onTap: () {

                  },
                  child: GestureDetector(
                    onTap: (){
                      final provider = Provider.of<GoogleSignInProvider>(context,
                          listen: false);
                      provider.logout(context).then((value) =>
                          Navigator.pushNamedAndRemoveUntil(
                              context, SignUp_page.idScreen, (route) => false));
                    },
                    child: AnimatedContainer(
                      duration: const Duration(
                        milliseconds: 200,
                      ),
                      height: height*0.1,
                      width: width*0.8,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(50),
                        boxShadow: [
                          const BoxShadow(
                            color: Colors.grey,
                            offset: Offset(4, 4),
                            blurRadius: 15,
                            spreadRadius: 1,
                          ),
                          const BoxShadow(
                            color: Colors.white,
                            offset: Offset(-4, -4),
                            blurRadius: 15,
                            spreadRadius: 1,
                          ),
                        ]
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FaIcon(FontAwesomeIcons.signOut,size: 35,),
                          SizedBox(width: 25,),
                          Text('Log Out',style: TextStyle(fontSize:25,fontWeight: FontWeight.bold),)
                        ],
                      ),
                    ),
                  ),
                ),
              ),],
              ),
            ),
          ),
        )
      ],
    );
  }}



// Container(
//                     height: height * 0.5,
//                     width: width,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(30),
//                       color: Colors.white,
//                     ),
//                     child: Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 15),
//                       child: Column(
//                         children: [
//                           SizedBox(
//                             height: 20,
//                           ),
//                           Text(
//                             'My Orders',
//                             style: TextStyle(
//                               color: Color.fromRGBO(39, 105, 171, 1),
//                               fontSize: 27,
//                               fontFamily: 'Nunito',
//                             ),
//                           ),
//                           Divider(
//                             thickness: 2.5,
//                           ),
//                           SizedBox(
//                             height: 10,
//                           ),
//                           Container(
//                             height: height * 0.15,
//                             decoration: BoxDecoration(
//                               color: Colors.grey,
//                               borderRadius: BorderRadius.circular(30),
//                             ),
//                           ),
//                           SizedBox(
//                             height: 10,
//                           ),
//                           Container(
//                             height: height * 0.15,
//                             decoration: BoxDecoration(
//                               color: Colors.grey,
//                               borderRadius: BorderRadius.circular(30),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   )