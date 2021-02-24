class UserModel{
  String email;
  String password;
  String userName;
  String userId;
  UserModel({this.email,this.password,this.userName,this.userId});
  UserModel.fromJson(Map map){
    this.email = map['email'];
    this.userName = map['userName'];
    this.userId = map['userId'];
  }
  toJson(){
    return {
      'email':this.email,
      'userName':this.userName,
      'userId':this.userId
    };
  }
}