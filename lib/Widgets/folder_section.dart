import 'package:d_locker/Controllers/file_screen_controller.dart';
import 'package:d_locker/Controllers/files_controller.dart';
import 'package:d_locker/Modals/folder.dart';
import 'package:d_locker/Screens/display_file_screen.dart';
import 'package:d_locker/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FolderSection extends StatelessWidget {
  const FolderSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetX<FilesScreenController>(
        builder: (FilesScreenController folderController) {
      if (folderController != null && folderController.foldersList != null) {
        return GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: folderController.foldersList.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, crossAxisSpacing: 20, mainAxisSpacing: 20),
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () => Get.to(
                    () => DisplayFileScreen(
                          folderController.foldersList[index].name,
                          "folder",
                        ),
                    binding: FilesBinding(
                        "folders",
                        folderController.foldersList[index].name,
                        folderController.foldersList[index].name)),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey.shade100,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.00001),
                          offset: Offset(10, 10),
                          blurRadius: 5)
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/folder.png",
                        width: 82,
                        height: 82,
                        fit: BoxFit.cover,
                      ),
                      Text(
                        folderController.foldersList[index].name,
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey,
                            fontWeight: FontWeight.bold),
                      ),
                      StreamBuilder(
                          stream: userCollection
                              .doc(FirebaseAuth.instance.currentUser!.uid)
                              .collection("files")
                              .where("folder",
                                  isEqualTo:
                                      folderController.foldersList[index].name)
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            return Text(
                              "${snapshot.data!.docs.length} items",
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[400],
                                  fontWeight: FontWeight.bold),
                            );
                          }),
                    ],
                  ),
                ),
              );
            });
      } else {
        return Center(
          child: CircularProgressIndicator(),
        );
      }
    });
  }
}
