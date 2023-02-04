class UserLogin {
  String email = '';
  String name = '';
  int   role_id = -1;
  String uuid = '';

  UserLogin(this.email, this.name, this.role_id, this.uuid);

  UserLogin.fromJson(Map<String, dynamic> userloginMap){
    email = userloginMap['email'] ?? '';
    name = userloginMap['name'] ?? '';
    role_id = userloginMap['role_id'] ?? -1;
    uuid = userloginMap['uuid'] ?? '';
    }

  Map<String, dynamic> toJson(){
    return {
      'email': email,
      'name': name,
      'role_id': role_id,
      'uuid': uuid
    };
  } 
  }