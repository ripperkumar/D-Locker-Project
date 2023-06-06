import 'package:permission_handler/permission_handler.dart';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:d_locker/Modals/file_modal.dart';
import 'package:d_locker/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:mime/mime.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:video_compress/video_compress.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseService {
  Uuid uuid = Uuid();
  Future<File> compressFile(File file, String fileType) async {
    if (fileType == 'image') {
      Directory directory = await getTemporaryDirectory();
      String targetpath = directory.path + "/${uuid.v4().substring(0, 8)}.jpg";
      File? result = await FlutterImageCompress.compressAndGetFile(
          file.path, targetpath,
          quality: 75);
      return result!;
    } else if (fileType == "video") {
      MediaInfo? info = await VideoCompress.compressVideo(file.path,
          quality: VideoQuality.MediumQuality,
          deleteOrigin: false,
          includeAudio: true);
      print(info!.file);
      return File(info.path!);
    } else {
      return file;
    }
  }

  uploadFile(String folderName, BuildContext context) async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(allowMultiple: true);
    if (result != null) {
      List<File>? files = result.paths.map((path) => File(path!)).toList();
      for (File file in files) {
        String? fileType = lookupMimeType(file.path);
        String end = "/";
        int startIndex = 0;
        int endIndex = fileType!.indexOf(end);
        String filteredFiletype = fileType.substring(startIndex, endIndex);
        //filtering file name and extension
        String fileName = file.path.split('/').last;
        String fileExtension = fileName.substring(fileName.indexOf('.') + 1);

        // getting compressed file
        File compressedfile = await compressFile(file, filteredFiletype);
        // getting lenght of files collection
        int length = await userCollection
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection("files")
            .get()
            .then((value) => value.docs.length);
        //uploading files to firebase storage
        UploadTask uploadTask = FirebaseStorage.instance
            .ref()
            .child('files')
            .child('file $length')
            .putFile(compressedfile);
        TaskSnapshot snapshot = await uploadTask.whenComplete(() => {});
        String fileUrl = await snapshot.ref.getDownloadURL();
        // Saving data in firebase

        userCollection
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection('files')
            .add({
          'fileName': fileName,
          'fileUrl': fileUrl,
          'fileType': filteredFiletype,
          'fileExtenstion': fileExtension,
          'folder': folderName,
          'size': (compressedfile.readAsBytesSync().length / 1024).round(),
          'dateUploaded': DateTime.now()
        });
      }
      if (folderName == '') {
        Navigator.of(context).pop();
      }
    } else {
      print("Cancelled");
    }
  }

  deleteFile(FileModel file) async {
    await userCollection
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('files')
        .doc(file.id)
        .delete();
  }

  downloadFile(FileModel file) async {
    Future<String?> downloadpath() async {
      Directory? directory;
      try {
        if (Platform.isIOS) {
          directory = await getApplicationDocumentsDirectory();
        } else {
          directory = Directory('/storage/emulated/0/Download');
          if (!await directory.exists()) {
            directory = await getExternalStorageDirectory();
          }
        }
      } catch (err, stack) {
        print('cannot get the download path');
      }
      print(directory?.path);
      return directory?.path;
    }

    try {
      final downloadPath = await downloadpath();
      final path = "$downloadPath/${file.name.replaceAll(" ", "")}";
      var status = await Permission.storage.status;
      print("${status}!!!");
      if (!status.isGranted) {
        await Permission.storage.request();
      }
      await Dio().download(file.url, path);
    } catch (e) {
      print('error!!!!!!!!');
      print(e.toString());
    }
  }
}
