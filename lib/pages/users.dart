import 'package:chat_application/backend.dart/appGet.dart';
import 'package:chat_application/backend.dart/server.dart';
import 'package:chat_application/models/UserMode.dart';
import 'package:chat_application/pages/messages.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/route_manager.dart';

class UsersPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Users'),
      ),
      body: Obx(() {
        return appGet.users.isEmpty
            ? Center(
                child: Text('No Users Found'),
              )
            : ListView.builder(
                itemCount: appGet.users.length,
                itemBuilder: (context, index) {
                  return UserWidget(appGet.users[index]);
                });
      }),
    );
  }
}

class UserWidget extends StatelessWidget {
  UserModel userModel;
  UserWidget(this.userModel);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: ListTile(
        onTap: () async {
          String chatId =
              await createChat([userModel.userId, appGet.userModel.userId]);
          Get.to(ChatMessagesPage(userModel, chatId));
        },
        leading: CircleAvatar(
          radius: 30,
          child: Text(userModel.userName[0].toUpperCase()),
        ),
        title: Text(userModel.userName),
        subtitle: Text(userModel.email),
        trailing: Icon(Icons.chat_rounded),
      ),
    );
  }
}
