import 'package:chat_application/models/UserMode.dart';
import 'package:get/get.dart';

class AppGet extends GetxController {
  UserModel userModel;
  var users = <UserModel>[].obs;
  setUserModel(UserModel userModel) {
    this.userModel = userModel;
    update();
  }
}
