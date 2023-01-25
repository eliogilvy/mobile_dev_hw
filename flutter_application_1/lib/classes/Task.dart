class Task {
  int id;
  final String title;
  final String desc;
  String status;
  DateTime lastUpdate;
  Map<int, String> related = {};
  String taskType;
  String lastFilter = "";
  Task({
    required this.id,
    required this.title,
    required this.desc,
    required this.status,
    required this.lastUpdate,
    required this.taskType,
  });
}
