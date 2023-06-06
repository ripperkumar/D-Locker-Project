import 'package:d_locker/Controllers/storage_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StorageContainer extends StatelessWidget {
  StorageController controller = Get.put(StorageController());
  getSize(int size){
    if(size<1000){
      return "$size KB";
    }
    else if(size<1000000)
      {
        int sizeMB = (size*0.001).round();
        return "$sizeMB MB";
      }
    else{
      int sizeGB = (size*0.000001).round();
      return "$sizeGB GB";
    }
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(left: 15, right: 15),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey.shade100,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              offset: Offset(5, 5),
              blurRadius: 10,
            ),
            BoxShadow(
              color: Colors.grey.withOpacity(0.001),
              offset: Offset(-10, 10),
              blurRadius: 10,
            ),
          ]),
      child: Padding(
        padding: EdgeInsets.only(top: 35.0, bottom: 35),
        child: Obx(
          ()=> Column(
            children: [
              Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(color: Colors.grey.withOpacity(0.5), blurRadius: 10)
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          ((controller.size.value/1000000)*100).round().toString(),
                          style: TextStyle(
                              fontSize: 50,
                              color: Color(0xff635c9b),
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "%",
                          style: TextStyle(
                              fontSize: 18,
                              color: Color(0xff635c9b),
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Text(
                      "Used",
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.black.withOpacity(0.7),
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 18,
                        height: 18,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.deepOrangeAccent),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Column(
                        children: [
                          Text(
                            "Used",
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.black.withOpacity(0.7),
                                fontWeight: FontWeight.w600),
                          ),
                          Text(
                            getSize(controller.size.value),
                            style: TextStyle(
                                fontSize: 20,
                                color: Color(0xff634c9b),
                                fontWeight: FontWeight.w600),
                          )
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        width: 18,
                        height: 18,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.grey.withOpacity(0.25)),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Column(
                        children: [
                          Text(
                            "Free",
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.black.withOpacity(0.7),
                                fontWeight: FontWeight.w600),
                          ),
                          Text(
                            "1 GB",
                            style: TextStyle(
                                fontSize: 20,
                                color: Color(0xff634c9b),
                                fontWeight: FontWeight.w600),
                          )
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
