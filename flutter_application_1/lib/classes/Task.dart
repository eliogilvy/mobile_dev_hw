import 'dart:convert';

//Task
class Task {
  int id = 0;
  String title = "";
  String desc = "";
  String status = "";
  DateTime lastUpdate = DateTime.now();
  Map<String, String> related = {};
  String taskType = "";
  String lastFilter = "";
  Task({
    required this.title,
    required this.desc,
    required this.status,
    required this.lastUpdate,
    required this.taskType,
    required this.related,
    this.lastFilter = "",
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'desc': desc,
      'status': status,
      'lastUpdate': lastUpdate.toIso8601String(),
      'related': related.toString(),
      'taskType': taskType,
      'lastFilter': lastFilter
    };
  }

  Task.fromMap(Map<dynamic, dynamic> map) {
    id = map['id']!;
    title = map['title']!;
    desc = map['desc']!;
    status = map['status']!;
    lastUpdate =
        DateTime.fromMillisecondsSinceEpoch(int.parse(map['lastUpdate']!));
    related = Map<String, String>.from(json.decode(map['related']!));
    taskType = map['taskType']!;
    lastFilter = map['lastFilter']!;
  }
}
