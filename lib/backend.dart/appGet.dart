

import 'package:chat_application/models/UserMode.dart';
import 'package:get/get.dart';

class AppGet extends GetxController{
  UserModel userModel;
  setUserModel(UserModel userModel){
    this.userModel = userModel;
    update();
  }
}