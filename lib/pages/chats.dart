import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class ChatsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Chats'),
      ),
    );
  }
}

class AllChats extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Obx(() {});
  }
}
