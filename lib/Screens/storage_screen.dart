import 'package:d_locker/Widgets/storage_container.dart';
import 'package:d_locker/Widgets/upload_options.dart';
import 'package:flutter/material.dart';
class StorageScreen extends StatelessWidget {
  const StorageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          SizedBox(height:
            60,),
          StorageContainer(),
          Spacer(),
          Padding(
            padding:  EdgeInsets.only(bottom: 22.0),
            child: UploadOptions(),
          ),
        ],
      ),
    );
  }
}
