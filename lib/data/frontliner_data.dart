import 'dart:core';

import 'feedback_journey.dart';
import 'package:upshot_flutter/shared/sp_helper.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class FLDataService {
  SPHelper helper = SPHelper();
  FLDataService() {
    helper.init();
  }

  Future<List<FLFeedbackJourney>> getAllSubmittedJourneys() async {
    String? server = helper.getServerAddress();
    String? uuid = helper.getUserUUID();
    Uri uri = Uri.http(server!, "/api/${uuid}/fl_get_all_submitted_feedback");
    http.Response result = await http.post(uri, body: {});
    Map<String, dynamic> data = json.decode(result.body);

    List<FLFeedbackJourney> retval = [];
    if (data["status"] == "ok") {
      retval = createListFromSubmittedFeedback(data["all_feedback"]);
    }
    return retval;
  }

  List<FLFeedbackJourney> createListFromSubmittedFeedback(List<dynamic> all) {
    List<FLFeedbackJourney> result = [];
    for (var i = 0; i < all.length; i++) {
      Map<String, dynamic> journey = all[i];
      FLFeedbackJourney fb = FLFeedbackJourney.fromJson(journey);
      result.add(fb);
    }
    return result;
  }
}
