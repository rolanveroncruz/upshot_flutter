class UserLogin {
  String email;

  UserLogin(this.email);

  UserLogin.fromJson(Map<String, dynamic> userloginMap):
    email = userloginMap['email'] ?? '';

  Map<String, dynamic> toJson(){
    return {
      'email': email,
    };
  } 
  }