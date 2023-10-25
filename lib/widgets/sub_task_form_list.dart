import 'package:flutter/material.dart';
import 'package:todo_todo/models/sub_task_form_model.dart';
import 'package:todo_todo/widgets/sub_task_form.dart';

class SubTaskFormList extends StatelessWidget {
  const SubTaskFormList({
    super.key,
    required this.subTaskForms,
    required this.onRemove,
  });

  final List<SubTaskFormModel> subTaskForms;
  final void Function(int) onRemove;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: subTaskForms.indexed.map(
        (e) {
          final index = e.$1;
          final subTaskFormModel = e.$2;

          return SubTaskForm(
            key: ValueKey<String>(subTaskFormModel.subTaskId),
            index: index,
            subTaskFormModel: subTaskFormModel,
            onRemove: onRemove,
          );
        },
      ).toList(),
    );
  }
}
