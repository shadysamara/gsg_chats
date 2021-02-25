import 'dart:async';

import 'package:chat_application/models/MessageModel.dart';
import 'package:chat_application/models/UserMode.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:chat_application/backend.dart/server.dart';
import 'package:flutter_chat_bubble/bubble_type.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_1.dart';
import 'package:get/get.dart';

class ChatMessagesPage extends StatelessWidget {
  TextEditingController controller = TextEditingController();
  ScrollController scrollController = ScrollController();
  UserModel otherUser;
  String chatId;
  ChatMessagesPage(this.otherUser, this.chatId);
  createWidget(MessageMode messageMode) {
    bool isMe = !(messageMode.senderId == otherUser.userId);
    if (isMe) {
      return createMyMessage(messageMode);
    } else {
      return createFriendMessage(messageMode);
    }
  }

  Widget createMyMessage(MessageMode messageMode) {
    return ChatBubble(
      clipper: ChatBubbleClipper1(type: BubbleType.sendBubble),
      alignment: Alignment.topRight,
      margin: EdgeInsets.only(top: 20),
      backGroundColor: Colors.blue,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(Get.context).size.width * 0.7,
        ),
        child: Text(messageMode.content),
      ),
    );
  }

  Widget createFriendMessage(MessageMode messageMode) {
    return Row(
      children: [
        CircleAvatar(
          radius: 30,
          child: Text(otherUser.userName[0].toUpperCase()),
        ),
        ChatBubble(
          clipper: ChatBubbleClipper1(type: BubbleType.receiverBubble),
          alignment: Alignment.topLeft,
          margin: EdgeInsets.only(top: 20),
          backGroundColor: Colors.red,
          child: Container(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(Get.context).size.width * 0.7,
            ),
            child: Text(messageMode.content),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Messages'),
      ),
      body: Column(
        children: [
          Expanded(
              child: Container(
            child: StreamBuilder<QuerySnapshot>(
                stream: getChatMessages(chatId),
                builder: (context, AsyncSnapshot<QuerySnapshot> dataSnapShot) {
                  Timer(
                      Duration(milliseconds: 100),
                      () => scrollController
                          .jumpTo(scrollController.position.maxScrollExtent));
                  if (dataSnapShot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (dataSnapShot.hasData) {
                    List<MessageMode> messages = dataSnapShot.data.docs
                        .map((e) => MessageMode.fromMap(e.data()))
                        .toList();

                    return ListView.builder(
                        controller: scrollController,
                        itemCount: messages.length,
                        itemBuilder: (context, index) {
                          return createWidget(messages[index]);
                        });
                  }
                  return Center(
                    child: Text('No Messages'),
                  );
                }),
          )),
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(border: Border.all(color: Colors.black)),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: controller,
                    onTap: () {},
                    decoration: InputDecoration(
                        hintText: 'Enter your message',
                        border: InputBorder.none),
                  ),
                ),
                IconButton(
                    icon: Icon(Icons.send),
                    onPressed: () {
                      DateTime dateTime = DateTime.now();
                      MessageMode messageMode = MessageMode(
                          content: controller.text,
                          senderId: appGet.userModel.userId,
                          senderName: appGet.userModel.userName,
                          timeStamp: FieldValue.serverTimestamp(),
                          date:
                              '${dateTime.year}-${dateTime.month}-${dateTime.day}',
                          time: '${dateTime.hour}:${dateTime.minute}',
                          chatId: chatId);
                      createMessage(messageMode);
                      Timer(
                          Duration(milliseconds: 100),
                          () => scrollController.jumpTo(
                              scrollController.position.maxScrollExtent));
                      // Timer(
                      //     Duration(milliseconds: 100),
                      //     () => scrollController.jumpTo(
                      //         scrollController.position.maxScrollExtent));
                      controller.clear();
                    })
              ],
            ),
          )
        ],
      ),
    );
  }
}
