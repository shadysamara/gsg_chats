import 'package:cloud_firestore/cloud_firestore.dart';

class MessageMode{
  String senderId;
  String time;
  String date;
  String senderName;
  FieldValue timeStamp;
  String content;
  String chatId;
  MessageMode({this.senderId,this.date,this.senderName,this.time,this.timeStamp,this.content,this.chatId});
  MessageMode.fromMap(Map map){
    this.senderId = map['senderId'];
    this.time = map['time'];
    this.date = map['date'];
    this.senderName = map['senderName'];
    this.timeStamp = map['timeStamp'];
    this.content = map['content'];
    this.chatId = map['chatId'];
  }
  toJson(){
    return {
      'senderId':this.senderId,
      'date':this.date,
      'time':this.time,
      'senderName':this.senderName,
      'timeStamp':this.timeStamp,
      'content':this.content,
      'chatId':this.chatId
    };
  }
}