import 'package:chat_application/backend.dart/appGet.dart';
import 'package:chat_application/pages/splach.dart';
import 'package:chat_application/services/SPHelper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await SPHelper.spHelper.initSharedPreferences();
  Get.put(AppGet());
  runApp(MyApp());
}
class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GetMaterialApp(
      home: App(),
    );
  }
}
class App extends StatelessWidget {
  // Create the initialization Future outside of `build`:
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return Scaffold(body: Center(child: Text('Error'),),);
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return SplachPage();
        }

        // Otherwise, show something whilst waiting for initialization to complete
       return Scaffold(body: Center(child: CircularProgressIndicator(),),);
      },
    );
  }
}