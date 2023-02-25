class EMEntry {
  String employee_do = "";
  String impact = "";
  String do_more = "";
  String do_less = "";
  String stop_doing = "";
  String add_notes = "";

  EMEntry() {}

  EMEntry.fromJson(Map<String, dynamic> entry) {
    employee_do = entry["employee_do"];
    impact = entry["impact"];
    do_more = entry["do_more"];
    do_less = entry["do_less"];
    stop_doing = entry["stop_doing"];
    add_notes = entry["add_notes"];
  }
}

class FLFeedbackJourney {
  int fb_id = -1;
  String em_name = "";
  String em_position = "";
  String feedback_type = "";
  DateTime date = DateTime.now();
  String generalTopic = "";
  String subTopic = "";
  EMEntry em_entry = EMEntry();

  FLFeedbackJourney.fromJson(Map<String, dynamic> fb) {
    fb_id = fb["fb_id"];
    em_name = fb["em_name"];
    em_position = fb["em_position"];
    feedback_type = fb["feedback_type"];
    date = string2Date(fb["date"]);
    generalTopic = fb["general_topic"];
    subTopic = fb["subtopic"];
    em_entry = EMEntry.fromJson(fb["em_entry"]);
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
  int journey_id = -1;
  String feedback_type = "";
  String generalTopic = "";
  String? subTopic = "";
  String? optional_other_subtopic = "";
  bool? requires_face_to_face = null;
  String frontliner_name = "";
  DateTime date_created = DateTime.now();
  String status = "";
  int? phase_id = -1;
  String title = "";

  EMFeedbackJourney.fromJson(Map<String, dynamic> fb) {
    journey_id = fb["journey_id"];
    feedback_type = fb["feedback_type"];
    generalTopic = fb["general_topic"];
    subTopic = fb["subtopic"];
    optional_other_subtopic = fb["other_optional_subtopic"];
    requires_face_to_face = fb["requires_face_to_face"];
    frontliner_name = fb["frontliner_name"];
    date_created = string2Date(fb["datetime"]);
    status = fb["status"];
    phase_id = fb["current_progress"]["phase_id"];
    title = fb["current_progress"]["title"];
  }
}
