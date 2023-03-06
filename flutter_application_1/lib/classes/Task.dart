import 'dart:convert';

//Task
class Task {
  String id = '';
  String title = "";
  String desc = "";
  String status = "";
  DateTime lastUpdate = DateTime.now();
  Map<String, String> related = {};
  String taskType = "";
  String lastFilter = "";
  String? image;
  bool shared = false;
  Task({
    required this.title,
    required this.desc,
    required this.status,
    required this.lastUpdate,
    required this.taskType,
    required this.related,
    required this.shared,
    this.lastFilter = "",
    this.image,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'desc': desc,
      'status': status,
      'lastUpdate': lastUpdate.millisecondsSinceEpoch.toString(),
      'related': jsonEncode(related),
      'shared': shared,
      'taskType': taskType,
      'lastFilter': lastFilter,
      'image': image
    };
  }

  Map<String, dynamic> toQR() {
    return {
      'id': id,
      'title': title,
      'desc': desc,
      'status': status,
      'lastUpdate': DateTime.now().millisecondsSinceEpoch.toString(),
      'related': jsonEncode({}),
      'taskType': taskType,
      'lastFilter': '',
      'shared': shared,
    };
  }

  Task.fromMap(Map<dynamic, dynamic> map) {
    id = map['id']!;
    title = map['title']!;
    desc = map['desc']!;
    status = map['status']!;
    lastUpdate =
        DateTime.fromMillisecondsSinceEpoch(int.parse(map['lastUpdate']!));
    _relatedFromMap(Map<String, String>.from(json.decode(map['related']!)));
    taskType = map['taskType']!;
    if (map['shared'] is bool) {
      shared = map['shared'];
    } else {
      shared = map['shared'] == 1;
    }
    lastFilter = map['lastFilter']!;
    try {
      image = map['image']!;
    } catch (e) {
      image = null;
    }
  }

  _relatedFromMap(Map<String, String> map) {
    map.forEach(
      (key, value) {
        related[key] = value;
      },
    );
  }
}
