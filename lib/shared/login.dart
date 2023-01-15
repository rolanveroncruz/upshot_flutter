class UserLogin {
  String email;
  String name;
  String uuid;

  UserLogin(this.email, this.name, this.uuid);

  UserLogin.fromJson(Map<String, dynamic> userloginMap):
    email = userloginMap['email'] ?? '',
    name = userloginMap['name'] ?? '',
    uuid = userloginMap['uuid'] ?? ''; 

  Map<String, dynamic> toJson(){
    return {
      'email': email,
      'name': name,
      'uuid': uuid,

    };
  } 
  }