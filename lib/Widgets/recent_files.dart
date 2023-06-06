import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:d_locker/Controllers/file_screen_controller.dart';
class RecentFiles extends StatelessWidget {
  const RecentFiles({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text("Recent Files",style: TextStyle(
            fontSize: 20,color: Colors.grey,fontWeight: FontWeight.bold
          ),),
        ),
        SizedBox(height: 15,),
        GetX<FilesScreenController>(
          builder: (FilesScreenController controller) {
            return Container(
              height: 100,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: controller.recentfilesList.length,
                  itemBuilder: (context,index){
                    return Padding(
                      padding: EdgeInsets.only(left:2,right: 13.0),
                      child: Container(
                        height: 65,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                          controller.recentfilesList[index].fileType=='image'?  ClipRRect(
                              borderRadius: BorderRadius.circular(18),
                              child: Container(
                                width: 75,
                                height: 70,
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey,width: 0.15),
                                      borderRadius: BorderRadius.circular(17),
                                  ),
                                child:Image(
                                  image: NetworkImage(
                                    controller.recentfilesList[index].url
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ):Container(
                            height: 70,
                            width: 70,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey,width: 0.15),
                              borderRadius: BorderRadius.circular(17),
                              color: Colors.orange
                            ),
                            child: Center(
                              child: Image(
                                width: 65,
                                height:70,
                                image:AssetImage("assets/${controller.recentfilesList[index].fileExtension}.png")
                              ),
                            ),
                          ),
                            SizedBox(height: 6,),
                            Container(
                              width: 73,
                              child: Text(controller.recentfilesList[index].name,overflow: TextOverflow.ellipsis,style: TextStyle(
                                fontSize: 13,color: Colors.grey,fontWeight: FontWeight.w500,
                              ),),
                            )
                          ],
                        ),
                      ),
                    );
                  }),
            );
          }
        )
      ],
    );
  }
}
