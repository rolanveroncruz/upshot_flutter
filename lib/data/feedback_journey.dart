class EMEntry {
  String employeeDo = "";
  String impact = "";
  String doMore = "";
  String doLess = "";
  String? stopDoing = "";
  String addNotes = "";

  EMEntry();

  EMEntry.fromJson(Map<String, dynamic> entry) {
    employeeDo = entry["employee_do"];
    impact = entry["impact"];
    doMore = entry["do_more"];
    doLess = entry["do_less"];
    stopDoing = entry["stop_less"];
    addNotes = entry["add_notes"];
  }
}

class FLFeedbackJourney {
  int fbId = -1;
  String emName = "";
  String emPosition = "";
  String feedbackType = "";
  DateTime date = DateTime.now();
  String generalTopic = "";
  String subTopic = "";
  EMEntry emEntry = EMEntry();

  FLFeedbackJourney.fromJson(Map<String, dynamic> fb) {
    fbId = fb["fb_id"];
    emName = fb["em_name"];
    emPosition = fb["em_position"];
    feedbackType = fb["feedback_type"];
    date = string2Date(fb["date"]);
    generalTopic = fb["general_topic"];
    subTopic = fb["subtopic"];
    emEntry = EMEntry.fromJson(fb["em_entry"]);
  }
}

DateTime string2Date(String datestr) {
  List<String> strSplit = datestr.split(" ");
  List<String> dtSplit = strSplit[0].split(",");
  List<String> dateSplit = dtSplit[0].split("/");
  List<String> timeSplit = strSplit[1].split(":");
  int month = int.parse(dateSplit[0]);
  int day = int.parse(dateSplit[1]);
  int year = int.parse(dateSplit[2]);
  int hour = int.parse(timeSplit[0]);
  int minute = int.parse(timeSplit[1]);
  int second = int.parse(timeSplit[2]);

  return DateTime(year, month, day, hour, minute, second);
}

class EMFeedbackJourney {
  int journeyId = -1;
  String feedbackType = "";
  String generalTopic = "";
  String? subTopic = "";
  String? optionalOtherSubtopic = "";
  bool? requiresFace2Face;
  String frontlinerName = "";
  DateTime dateCreated = DateTime.now();
  String status = "";
  int? phaseId = -1;
  String title = "";

  EMFeedbackJourney.fromJson(Map<String, dynamic> fb) {
    journeyId = fb["journey_id"];
    feedbackType = fb["feedback_type"];
    generalTopic = fb["general_topic"];
    subTopic = fb["subtopic"];
    optionalOtherSubtopic = fb["other_optional_subtopic"];
    requiresFace2Face = fb["requires_face_to_face"];
    frontlinerName = fb["frontliner_name"];
    dateCreated = string2Date(fb["datetime"]);
    status = fb["status"];
    phaseId = fb["current_progress"]["phase_id"];
    title = fb["current_progress"]["title"];
  }
}
