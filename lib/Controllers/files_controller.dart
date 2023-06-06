import 'package:d_locker/utils.dart';
import 'package:get/get.dart';
import 'package:d_locker/Modals/file_modal.dart';
import 'package:firebase_auth/firebase_auth.dart';
class FilesController extends GetxController{
  final String type;
  final String foldername;
  final String fileType;
  FilesController(this.type,this.fileType,this.foldername);
  String uid = FirebaseAuth.instance.currentUser!.uid;
  RxList<FileModel> files = <FileModel> [].obs;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    if(type == 'files'){
      print(fileType+"!!!!!!!!!!!!!!");
      files.bindStream(userCollection.doc(uid).collection('files').where('fileType',isEqualTo: fileType).snapshots().map((query)  {
        List<FileModel> tempFiles =[];
        query.docs.forEach((doc) {tempFiles.add(FileModel.fromDocumentSnapshot(doc));});
        return tempFiles;
      }));

    }else{
      files.bindStream(userCollection.doc(uid).collection('files').where('folder',isEqualTo: foldername).snapshots().map((query){
        List <FileModel> tempfiles = [];
        query.docs.forEach((element) {
          tempfiles.add(FileModel.fromDocumentSnapshot(element));
        });
        return tempfiles;
      }));
    }
    
  }
  
}

class FilesBinding implements Bindings{
  final String type;
  final String foldername;
  final String fileType;
  FilesBinding(this.type,this.fileType,this.foldername);
  @override
  void dependencies(){
    Get.lazyPut<FilesController>(() =>FilesController(type, this.fileType, foldername) );
  }
}