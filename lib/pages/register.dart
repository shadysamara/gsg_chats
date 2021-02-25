import 'package:chat_application/backend.dart/server.dart';
import 'package:chat_application/models/UserMode.dart';
import 'package:chat_application/widgets/custom_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class CustomerRegistrationPage extends StatefulWidget {
  @override
  _customerRegistrationPageState createState() =>
      _customerRegistrationPageState();
}

class _customerRegistrationPageState extends State<CustomerRegistrationPage> {
  GlobalKey<FormState> customerRegFormKey = GlobalKey();

  String userName;

  String password;

  String email;
  saveEmail(String value) {
    this.email = value;
  }

  saveuserName(String value) {
    this.userName = value;
  }

  savepassword(String value) {
    this.password = value;
  }

  nullValidation(String value) {
    if (value.isEmpty) {
      return 'required filed*';
    }
  }

  saveForm() async {
    if (customerRegFormKey.currentState.validate()) {
      customerRegFormKey.currentState.save();
      UserModel userModel = UserModel(
          email: this.email, userName: this.userName, password: this.password);
      registerUser(userModel);
    } else {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('customers register'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: Form(
            key: customerRegFormKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  MyTextField(
                    hintTextKey: 'user_name',
                    nofLines: 1,
                    validateFunction: nullValidation,
                    saveFunction: saveuserName,
                  ),
                  MyTextField(
                    hintTextKey: 'email',
                    nofLines: 1,
                    validateFunction: nullValidation,
                    saveFunction: saveEmail,
                  ),
                  MyTextField(
                    hintTextKey: 'password',
                    nofLines: 1,
                    validateFunction: nullValidation,
                    saveFunction: savepassword,
                    textInputType: TextInputType.visiblePassword,
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  RaisedButton(
                      child: Text('register'),
                      onPressed: () {
                        saveForm();
                      })
                ],
              ),
            )),
      ),
    );
  }
}
