import 'package:upshot_flutter/shared/sp_helper.dart';
import 'package:upshot_flutter/shared/user_login.dart';

import 'directory.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:tuple/tuple.dart';

class API {
  ServerDirectory serverDirectory = ServerDirectory();
  SPHelper helper = SPHelper();
  late String? apiServer;
  late UserLogin userLogin;

  void init() async {
    await serverDirectory.init();
    await helper.init();
  }

  Future<Tuple2<int, String?>> login(String email, String password) async {
    var splitted = email.split('@');
    apiServer = serverDirectory.getIPFromEmail(splitted[1]);
    if (apiServer == null) {
      return const Tuple2(-1, "Unknown Server");
    } else {
      Uri uri = Uri.http(apiServer!, "/api/login");
      Object body = jsonEncode(<String, String>{
        "email": email,
        "password": password,
      });
      http.Response result = await http.post(uri, body: body);
      Map<String, dynamic> data = json.decode(result.body);
      data['email'] = email;
      var errorMsg = data['reason'];
      if (data["status"] == "ok") {
        userLogin = UserLogin.fromJson(data);
        helper.writeUserLogin(userLogin);
        helper.writeServerAddress(apiServer!);
        helper.writeUserUUID(data["uuid"]);
        return const Tuple2(0, null);
      } else {
        return Tuple2(-1, errorMsg);
      }
    }
  }
}
