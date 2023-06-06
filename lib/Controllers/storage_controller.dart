import 'package:d_locker/utils.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class StorageController extends GetxController {
  String uid = FirebaseAuth.instance.currentUser!.uid;
  RxInt size = 0.obs;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getStorage();
  }

  getStorage() {
    size.bindStream(
        userCollection.doc(uid).collection("files").snapshots().map((query) {
      int size = 0;
      query.docs.forEach((element) {
        size += extractSize(element);
      });
      return size;
    }));
  }

  int extractSize(element) {
    return element['size'];
  }
}
