import 'package:d_locker/Modals/folder.dart';
import 'package:d_locker/Screens/view_file_screen.dart';
import 'package:d_locker/firbase.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:d_locker/Controllers/files_controller.dart';

class DisplayFileScreen extends StatelessWidget {
  static const String idScreen = "Display file screen";
  final String title;
  final String type;
  DisplayFileScreen(this.title,this.type);
  FilesController filesController = Get.find<FilesController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back,
            color: Colors.grey,
          ),
        ),
        title: Text(
         title,
          style: TextStyle(
              fontSize: 18, color: Colors.grey, fontWeight: FontWeight.bold),
        ),
      ),
      floatingActionButton: InkWell(
        onTap: () => type == 'folder'
            ? FirebaseService().uploadFile(title, context)
            : FirebaseService().uploadFile('', context),
        child: Container(
          width: 85,
          height: 85,
          decoration: BoxDecoration(
            color: Colors.redAccent[200],
            borderRadius: BorderRadius.circular(100),
          ),
          child: Center(
            child: Icon(
              Icons.add,
              color: Colors.white,
              size: 60,
            ),
          ),
        ),
      ),
      body: Obx(
        () => GridView.builder(
            itemCount: filesController.files.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,),
            itemBuilder: (context, index) {
              return InkWell(
                onTap: ()=>Get.to(()=>ViewFileScreen(filesController.files[index])),
                child: Padding(
                  padding: EdgeInsets.only(left: 16, top: 15, right: 10),
                  child: Container(
                    width: MediaQuery.of(context).size.width / 2,
                    child: Column(
                      children: [
                        filesController.files[index].fileType == 'image'?ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image(
                            image: NetworkImage(filesController.files[index].url),
                            width: MediaQuery.of(context).size.width / 2.5,
                            height: 115,
                            fit: BoxFit.cover,
                          ),
                        ):Container(
                          width: MediaQuery.of(context).size.width/2.5,
                          height: 115,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey,width: 0.2),
                            borderRadius: BorderRadius.circular(14),
                              color: Colors.orange
                          ),
                          child: Center(
                            child: Image(
                              width: 110,
                              height: 110,
                              image: AssetImage('assets/${filesController.files[index].fileExtension}.png'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 10, right: 2),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  filesController.files[index].name,
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.bold),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  showModalBottomSheet(
                                      context: context,
                                      builder: (context) {
                                        return Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Align(
                                              alignment: Alignment.center,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(12.0),
                                                child: Text(
                                                  filesController
                                                      .files[index].name,
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w500),maxLines: 2,
                                                  textAlign: TextAlign.center,
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ),
                                            Divider(
                                              color: Colors.grey,
                                              height: 2,
                                            ),
                                            ListTile(
                                              onTap: (){
                                                FirebaseService().downloadFile(
                                                    filesController
                                                        .files[index]
                                                );
                                                Get.back();
                                              },
                                              leading: Icon(
                                                Icons.file_download,
                                                color: Colors.grey,
                                                size: 30,
                                              ),
                                              dense: true,
                                              contentPadding: EdgeInsets.only(
                                                  bottom: 0, left: 16, top: 12),
                                              visualDensity: VisualDensity(
                                                  horizontal: 0, vertical: -4),
                                              title: Text(
                                                "Downlaod",
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w500),
                                              ),
                                            ),
                                            ListTile(
                                              onTap: (){
                                                FirebaseService().deleteFile(
                                                    filesController
                                                        .files[index]
                                                );
                                                Get.back();
                                              },
                                              dense: true,
                                              contentPadding: EdgeInsets.only(
                                                  bottom: 12, left: 16, top: 8),
                                              visualDensity: VisualDensity(
                                                  horizontal: 0, vertical: -4),
                                              leading: Icon(
                                                Icons.delete_forever,
                                                color: Colors.grey,
                                                size: 30,
                                              ),
                                              title: Text(
                                                "Remove",
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w500),
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.vertical(
                                              top: Radius.circular(18))));
                                },
                                icon: Icon(
                                  Icons.more_vert,
                                  color: Colors.black,
                                  size: 30,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
