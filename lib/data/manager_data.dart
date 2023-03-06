import 'dart:core';

import 'feedback_journey.dart';
import 'package:upshot_flutter/shared/sp_helper.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ManagerDataService {
  SPHelper helper = SPHelper();
  ManagerDataService() {
    helper.init();
  }

  Future<List<EMFeedbackJourney>> getAllFeedbackGiven() async {
    String? server = helper.getServerAddress();
    String? uuid = helper.getUserUUID();
    Uri uri = Uri.http(server!, "/api/$uuid/get_all_journey_status");
    http.Response result = await http.post(uri, body: {});
    Map<String, dynamic> data = json.decode(result.body);

    List<EMFeedbackJourney> retval = [];
    if (data["status"] == "ok") {
      retval =
          _createListFromAllFeedbackStatus(data["active_ongoing_journeys"]);
    }
    return retval;
  }

  List<EMFeedbackJourney> _createListFromAllFeedbackStatus(List<dynamic> all) {
    List<EMFeedbackJourney> result = [];
    for (var i = 0; i < all.length; i++) {
      Map<String, dynamic> journey = all[i];
      EMFeedbackJourney fb = EMFeedbackJourney.fromJson(journey);
      result.add(fb);
    }
    return result;
  }
}
