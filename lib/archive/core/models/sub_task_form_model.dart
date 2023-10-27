
class SubTaskFormModel {
  final String subtaskId;
  String? name;
  bool isDone;

  SubTaskFormModel({
    required this.subtaskId,
    this.name,
    this.isDone = false,
  });
}
