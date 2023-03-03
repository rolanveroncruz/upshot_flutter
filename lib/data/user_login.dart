class UserLogin {
  String email = '';
  String name = '';
  int roleId = -1;
  String uuid = '';

  UserLogin(this.email, this.name, this.roleId, this.uuid);

  UserLogin.fromJson(Map<String, dynamic> userloginMap) {
    email = userloginMap['email'] ?? '';
    name = userloginMap['name'] ?? '';
    roleId = userloginMap['role_id'] ?? -1;
    uuid = userloginMap['uuid'] ?? '';
  }

  Map<String, dynamic> toJson() {
    return {'email': email, 'name': name, 'role_id': roleId, 'uuid': uuid};
  }
}
