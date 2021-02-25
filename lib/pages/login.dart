import 'package:chat_application/backend.dart/server.dart';
import 'package:chat_application/pages/register.dart';
import 'package:chat_application/widgets/custom_textfield.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String userName;
  String password;
  saveUserName(String value) {
    this.userName = value;
  }

  savePassword(String value) {
    this.password = value;
  }

  nullValidation(String value) {
    if (value.isEmpty) {
      return 'required filed*';
    }
  }

  Widget _loginLabel(context) {
    return Container(
      margin: EdgeInsets.only(top: 25, bottom: 25),
      child: Text(
        "login",
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w500,
          fontSize: 22,
        ),
      ),
    );
  }

  final GlobalKey<FormState> loginFormKey = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: EdgeInsets.only(left: 20, top: 15, right: 20),
                child: Form(
                  key: loginFormKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _loginLabel(context),
                      _userNameField(),
                      _passwordField(),
                    ],
                  ),
                ),
              ),
              _loginButton(),
              _registerButton(),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> checkUsername() async {
    final mFormData = loginFormKey.currentState;
    if (!mFormData.validate()) {
      return;
    }

    mFormData.save();

    try {
      String email = this.userName.trim().toLowerCase();
      String password = this.password.trim();
      login(email, password);
    } catch (e) {}
  }

  Widget _userNameField() {
    return MyTextField(
      hintTextKey: 'user_name',
      nofLines: 1,
      saveFunction: saveUserName,
      validateFunction: nullValidation,
    );
  }

  Widget _passwordField() {
    return MyTextField(
      hintTextKey: 'password',
      nofLines: 1,
      saveFunction: savePassword,
      validateFunction: nullValidation,
    );
  }

  Widget _loginButton() {
    return Container(
      padding: EdgeInsets.only(left: 20, top: 15, right: 20),
      child: RaisedButton(
        child: Text('login'),
        onPressed: () => checkUsername,
      ),
    );
  }

  registerButtonFunction() {
    FocusScope.of(context).unfocus();
    Get.to(CustomerRegistrationPage());
  }

  Widget _registerButton() {
    return Container(
      padding: EdgeInsets.only(left: 20, top: 15, right: 20),
      child: RaisedButton(
        child: Text('register'),
        onPressed: () => registerButtonFunction,
      ),
    );
  }
}
