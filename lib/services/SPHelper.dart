import 'package:chat_application/models/UserMode.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SPHelper {
  SPHelper._();

  static final SPHelper spHelper = SPHelper._();
  SharedPreferences prefs;

  Future<SharedPreferences> initSharedPreferences() async {
    if (prefs == null) {
      prefs = await SharedPreferences.getInstance();
    }
    return prefs;
  }

////////////////////////////////////////////////////////////////////////////////
saveUser(UserModel userModel){
prefs.setString('userName', userModel.userName);
prefs.setString('userId', userModel.userId);
prefs.setString('userEmail', userModel.email);
}
UserModel getUser(){
  String userId = prefs.getString('userId');
   String userName = prefs.getString('userName');
    String userEmail = prefs.getString('userEmail');
return UserModel(email: userEmail,userId: userId,userName: userName);

}

clearData(){
  prefs.clear();
}
  
}
