import 'package:d_locker/Controllers/navigation_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Header extends StatelessWidget {
  NavigationController navController = Get.put(NavigationController());
  Widget tabCell(String text, bool selected, BuildContext context) {
    return selected
        ? Padding(
            padding: EdgeInsets.all(5.0),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.45 - 5,
              height: 60,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.orange,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      offset: Offset(-10, 10),
                      blurRadius: 10,
                    ),
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      offset: Offset(-10, 10),
                      blurRadius: 10,
                    ),
                  ]),
              child: Center(
                child: Text(
                  text,
                  style: TextStyle(
                      fontSize: 23,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          )
        : Container(
            width: MediaQuery.of(context).size.width * 0.45 - 10,
            height: 60,
            child: Center(
              child: Text(
                text,
                style: TextStyle(
                    fontSize: 23,
                    color: Colors.blueGrey,
                    fontWeight: FontWeight.bold),
              ),
            ),
          );
  }

  @override
  Widget build(BuildContext context) {
    return Container(

      alignment: Alignment.center,
      child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.only(left: 20, right: 20),
            height: 60,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.grey.shade300,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.4),
                    offset: Offset(5, 5),
                    blurRadius: 10,
                  ),
                ]),
            child: Obx(
              ()=> Row(
                children: [
                  InkWell(
                      onTap: ()=>navController.changeTab("Storage"),
                      child: tabCell("Storage", navController.tab.value=="Storage", context),),
                  InkWell(
                      onTap: ()=>navController.changeTab("Files"),
                      child: tabCell("Files", navController.tab.value=="Files", context))
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
