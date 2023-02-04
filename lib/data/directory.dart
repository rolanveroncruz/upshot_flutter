import 'package:http/http.dart' as http;
import 'dart:convert';

class ServerDirectory{
    String directoryAddress = "52.76.215.10";
    String path = "/api/directory";
    late List<dynamic> serverList;
  

    Future init() async {
      Uri uri = Uri.http(directoryAddress, path);
      http.Response result = await http.get(uri);
      Map<String, dynamic> data = json.decode(result.body);
      if (data["status"] == "ok"){
        serverList = data["result"];
        // how to handle data["result"], a list of Maps?
      }
    }

    String? getIPFromEmail(String emailServer){
       for(var i=0;i<serverList.length;i++){
        var item = serverList[i];
        var key = item['key'];
        if (emailServer == key){
          return  item['server'];
        }
      }//end for, nothing was found
      return  null;
    }
  
}