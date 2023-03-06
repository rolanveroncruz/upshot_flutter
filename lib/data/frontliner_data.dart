import 'dart:core';

import 'feedback_journey.dart';
import 'package:upshot_flutter/shared/sp_helper.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class FLDataService {
  SPHelper helper = SPHelper();
  List<FLFeedbackJourney>? theData;

  FLDataService() {
    helper.init();
  }

  Future<List<FLFeedbackJourney>?> getAllSubmittedJourneys(
      {bool force = false}) async {
    if (theData == null || force) {
      String? server = helper.getServerAddress();
      String? uuid = helper.getUserUUID();
      Uri uri = Uri.http(server!, "/api/$uuid/fl_get_all_submitted_feedback");
      http.Response result = await http.post(uri, body: {});
      Map<String, dynamic> data = json.decode(result.body);
      if (data["status"] == "ok") {
        theData = _createListFromSubmittedFeedback(data["all_feedback"]);
      }
      return theData; // return the retrieved values.
    } else {
      return theData; // return the cached values.
    }
  }

  List<FLFeedbackJourney> _createListFromSubmittedFeedback(List<dynamic> all) {
    // This simply converts all which is a List of anyhing to a List of FLFeedbackJourneys.
    List<FLFeedbackJourney> temp = [];
    for (var i = 0; i < all.length; i++) {
      Map<String, dynamic> journey = all[i];
      FLFeedbackJourney fb = FLFeedbackJourney.fromJson(journey);
      temp.add(fb);
    }
    return temp;
  }
}
