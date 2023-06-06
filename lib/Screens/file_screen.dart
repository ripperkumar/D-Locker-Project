

import 'package:d_locker/Controllers/file_screen_controller.dart';
import 'package:d_locker/Widgets/folder_section.dart';
import 'package:d_locker/Widgets/recent_files.dart';
import 'package:d_locker/firbase.dart';
import 'package:d_locker/utils.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class FilesScreen extends StatelessWidget {
  TextEditingController folderController = TextEditingController();
  FilesScreenController filesScreenController = Get.put(FilesScreenController());
  openAddFolderDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            // actionsPadding: EdgeInsets.only(right: 10,bottom: 10),
            title: Text(
              "New folder",
              style: TextStyle(
                  fontSize: 22,
                  color: Colors.black,
                  fontWeight: FontWeight.w600),
            ),
            content: TextFormField(
              controller: folderController,
              autofocus: true,
              style: TextStyle(
                  fontSize: 17,
                  color: Colors.black,
                  fontWeight: FontWeight.w600),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[250],
                hintText: "Untitled Folder",
                hintStyle: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                    fontWeight: FontWeight.w500),
              ),
            ),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 18.0),
                    child: InkWell(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Text(
                            "Cancel",
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 18.0),
                    child: InkWell(
                      onTap: () {
                        userCollection
                            .doc(FirebaseAuth.instance.currentUser!.uid)
                            .collection('folders')
                            .add({
                          "name": folderController.text,
                          "time": DateTime.now()
                        });
                        var count = 0;
                        Navigator.popUntil(context, (route) {
                          return count++ == 2;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.deepOrangeAccent,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Text(
                            "Create",
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20, top: 30),
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RecentFiles(),
                  FolderSection(),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: InkWell(
                  onTap: () {
                    showModalBottomSheet(
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(20))),
                      context: context,
                      builder: (context) {
                        return Container(
                          child: Padding(
                            padding: const EdgeInsets.only(
                                right: 8.0, left: 8, top: 28, bottom: 28),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  onTap: () => openAddFolderDialog(context),
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 18.0),
                                    child: Row(
                                      children: [
                                        Icon(
                                          FontAwesomeIcons.folderOpen,
                                          color: Colors.grey,
                                          size: 32,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          "Folder",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black,
                                              fontSize: 25),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 18.0),
                                  child: InkWell(
                                    onTap: ()=>FirebaseService().uploadFile("",context),
                                    child: Row(
                                      children: [
                                        Text(
                                          "Upload",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black,
                                              fontSize: 25),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Icon(
                                          FontAwesomeIcons.upload,
                                          color: Colors.grey,
                                          size: 32,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                  child: Container(
                    width: 45,
                    height: 45,
                    decoration: BoxDecoration(
                      color: Colors.redAccent,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 32,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
