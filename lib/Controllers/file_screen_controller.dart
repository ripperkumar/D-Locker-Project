import 'dart:io';

import 'package:d_locker/Modals/folder_model.dart';
import 'package:d_locker/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:d_locker/Modals/file_modal.dart';
class FilesScreenController extends GetxController {
  String uid = FirebaseAuth.instance.currentUser!.uid;
  RxList<FolderModel> foldersList = <FolderModel>[].obs;
  RxList<FileModel> recentfilesList = <FileModel>[].obs;
  @override
  void onInit() {
    super.onInit();
    recentfilesList.bindStream(
      userCollection
          .doc(uid)
          .collection("files")
          .orderBy('dateUploaded', descending: true)
          .snapshots()
          .map(
            (query) {
          List<FileModel> files = [];
          query.docs.forEach((element) {
            FileModel file = FileModel.fromDocumentSnapshot(element);
            files.add(file);
          });
          return files;
        },
      ),
    );


    foldersList.bindStream(
      userCollection
          .doc(uid)
          .collection("folders")
          .orderBy('time', descending: true)
          .snapshots()
          .map(
            (query) {
              List<FolderModel> folders = [];
                query.docs.forEach((element) {
                  FolderModel folder = FolderModel.fromDocumentSnapshot(element);
                folders.add(folder);
                });
                return folders;
            },
          ),
    );
  }
}
