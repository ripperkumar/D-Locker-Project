import 'package:d_locker/Modals/file_modal.dart';
import 'package:d_locker/Widgets/audio_player_widget.dart';
import 'package:d_locker/Widgets/pdf_viewer.dart';
import 'package:d_locker/Widgets/video_player_widget.dart';
import 'package:d_locker/firbase.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class ViewFileScreen extends StatelessWidget {
  FileModel file;
  ViewFileScreen(this.file);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(45),
        child: file.fileType == 'video'
            ? Container()
            : AppBar(
                backgroundColor: Colors.black,
                title: Text(
                  file.name,
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.w600),
                ),
                actions: [
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
                                      padding: const EdgeInsets.all(12.0),
                                      child: Text(
                                        file.name,
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500),
                                        maxLines: 2,
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
                                    onTap: () {
                                      FirebaseService().downloadFile(file);
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
                                    onTap: () {
                                      FirebaseService().deleteFile(file);
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
                      icon: Icon(Icons.more_vert))
                ],
              ),
      ),
      body: file.fileType == 'image'
          ? showImage(file.url)
          : file.fileType == 'application'
              ? showFile(file, context)
              : file.fileType == 'video'
                  ? VideoPlayerWidget(file.url)
                  : file.fileType == 'audio'
                      ? AudioPlayerWidget(file.url)
                      : showError(),
    );
  }

  showError() {}
  showImage(String url) {
    return Center(
      child: Image(
        image: NetworkImage(url),
      ),
    );
  }

  showFile(FileModel file, BuildContext context) {
    if (file.fileExtension == 'pdf') {
      return PdfViewer(file);
    } else {
      return Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Unfortunately this file can be opened",
              style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.w700),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: MediaQuery.of(context).size.width / 2,
              height: 36,
              child: TextButton(
                onPressed: () {
                  FirebaseService().downloadFile(file);
                },
                style: TextButton.styleFrom(backgroundColor: Colors.orange),
                child: Center(
                  child: Text(
                    'Download',
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }
  }
}
