import 'package:chat_application/backend.dart/server.dart';
import 'package:chat_application/models/UserMode.dart';
import 'package:chat_application/pages/register.dart';
import 'package:chat_application/pages/users.dart';
import 'package:chat_application/services/SPHelper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplachPage extends StatefulWidget {
  @override
  _SplachPageState createState() => _SplachPageState();
}

class _SplachPageState extends State<SplachPage> {
  UserModel userModel;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userModel = SPHelper.spHelper.getUser();
    appGet.userModel = userModel;
    if (userModel != null) {
      splachMethods();
    }
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 3)).then((value) {
      userModel == null
          ? Get.to(CustomerRegistrationPage())
          : Get.to(UsersPage());
    });
    // TODO: implement build
    return Scaffold();
  }
}
