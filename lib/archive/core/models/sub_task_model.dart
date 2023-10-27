
import 'package:todo_todo/archive/core/models/sub_task_form_model.dart';

class SubTaskModel {
  final String subtaskId;
  final String name;
  final bool isDone;

  SubTaskModel({
    required this.subtaskId,
    required this.name,
    this.isDone = false,
  });

  static SubTaskModel fromSubTaskFormModel(SubTaskFormModel subtaskFormModel) {
    return SubTaskModel(
      subtaskId: subtaskFormModel.subtaskId,
      name: subtaskFormModel.name!,
      isDone: subtaskFormModel.isDone,
    );
  }

  static SubTaskModel fromJson(Map<String, dynamic> json) {
    return SubTaskModel(
      subtaskId: json['subtaskId'],
      name: json['name'],
      isDone: bool.tryParse(json['isDone']) ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'subtaskId': subtaskId,
      'name': name,
      'isDone': isDone.toString(),
    };
  }

  SubTaskFormModel toSubTaskFormModel() {
    return SubTaskFormModel(
      subtaskId: subtaskId,
      name: name,
      isDone: isDone,
    );
  }

  SubTaskModel copyWith({
    String? name,
    bool? isDone,
  }) {
    return SubTaskModel(
      subtaskId: subtaskId,
      name: name ?? this.name,
      isDone: isDone ?? this.isDone,
    );
  }
}
