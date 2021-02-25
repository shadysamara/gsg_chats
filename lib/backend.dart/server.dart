import 'package:chat_application/backend.dart/appGet.dart';
import 'package:chat_application/models/MessageModel.dart';
import 'package:chat_application/models/UserMode.dart';
import 'package:chat_application/pages/register.dart';
import 'package:chat_application/pages/users.dart';
import 'package:chat_application/services/SPHelper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;
FirebaseAuth firebaseAuth = FirebaseAuth.instance;
String chatCollectionName = 'chats';
String messageCollectionName = 'messages';
String usersCollectionName = 'users';
AppGet appGet = Get.find();

splachMethods() {
  getAlUsers();
}

saveUserInFirestore(UserModel userModel) async {
  firestore
      .collection(usersCollectionName)
      .doc(userModel.userId)
      .set(userModel.toJson());
  SPHelper.spHelper.saveUser(userModel);
  appGet.setUserModel(userModel);
}

///////////////////////////////////////////////////////
getUserFormFirestore(String userId) async {
  DocumentSnapshot documentSnapshot =
      await firestore.collection(usersCollectionName).doc(userId).get();
  UserModel userModel = UserModel.fromJson(documentSnapshot.data());
  SPHelper.spHelper.saveUser(userModel);
  appGet.setUserModel(userModel);
}

/////////////////////////////////////////////////////////
getUserFromSp() {
  UserModel userModel = SPHelper.spHelper.getUser();
  appGet.setUserModel(userModel);
}

//////////////////////////////////////////////////////////
Future<UserModel> registerUser(UserModel userModel) async {
  try {
    UserCredential userCredential =
        await firebaseAuth.createUserWithEmailAndPassword(
            email: userModel.email, password: userModel.password);
    userModel.userId = userCredential.user.uid;
    saveUserInFirestore(userModel);
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      print('The password provided is too weak.');
    } else if (e.code == 'email-already-in-use') {
      print('The account already exists for that email.');
    }
  } catch (e) {
    print(e);
  }
}
///////////////////////////////////////////////////////

Future<UserModel> login(String email, String password) async {
  try {
    UserCredential userCredential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    getUserFormFirestore(userCredential.user.uid);
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      print('No user found for that email.');
    } else if (e.code == 'wrong-password') {
      print('Wrong password provided for that user.');
    }
  }
}

signOut() async {
  firebaseAuth.signOut();
  SPHelper.spHelper.clearData();
}

///////////////////////////////////////////////////////
getAlUsers() async {
  QuerySnapshot querySnapshot =
      await firestore.collection(usersCollectionName).get();
  List<UserModel> usersModels =
      querySnapshot.docs.map((e) => UserModel.fromJson(e.data())).toList();
  appGet.users.value = usersModels
      .where((element) => element.userId != appGet.userModel.userId)
      .toList();
}

///////////////////////////////////////////////////////
Future<String> createChat(List<String> usersIds) async {
  String chatId = usersIds.reduce((value, element) => value + element);
  await firestore
      .collection(chatCollectionName)
      .doc(chatId)
      .set({'users': usersIds});
  return chatId;
}

///////////////////////////////////////////////////////
createMessage(MessageMode message) async {
  firestore
      .collection(chatCollectionName)
      .doc(message.chatId)
      .collection(messageCollectionName)
      .add(message.toJson());
}

///////////////////////////////////////////////////////
Future<List<Map<String, dynamic>>> getAllChats() async {
  String myId = appGet.userModel.userId;
  QuerySnapshot querySnapshot = await firestore
      .collection(chatCollectionName)
      .where('users', arrayContains: myId)
      .get();
  List<Map<String, dynamic>> chats =
      querySnapshot.docs.map((e) => e.data()).toList();
  return chats;
}

///////////////////////////////////////////////////////
Stream<QuerySnapshot> getChatMessages(String chatId) {
  Stream<QuerySnapshot> stream = firestore
      .collection(chatCollectionName)
      .doc(chatId)
      .collection(messageCollectionName)
      .orderBy('timeStamp')
      .snapshots();
  return stream;
}
///////////////////////////////////////////////////////
