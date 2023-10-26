import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:todo_todo/archive/core/models/task_model.dart';
import 'package:todo_todo/archive/core/view_models/task_view_model.dart';
import 'package:todo_todo/archive/ui/widgets/task_list_screen/task_list_section.dart';
import 'package:todo_todo/enums.dart';

class TaskListBox extends StatelessWidget {
  const TaskListBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Consumer<TaskViewModel>(
          builder: (BuildContext context, taskModel, Widget? child) {
            final now = DateTime.now();
            final filteredTask = <TaskModel>[];
            final pastTasks = filteredTask
                .where((task) => !task.isDone && task.isBeforeThanToday)
                .toList();
            final todayTasks = filteredTask.where((task) {
              return !task.isDone && isSameDay(task.dueDate, now);
            }).toList();
            final futureTasks = filteredTask
                .where((task) => !task.isDone && task.isFutureThanToday)
                .toList();
            final completeTodayTasks = filteredTask
                .where(
                    (task) => task.isDone && isSameDay(task.completedDate, now))
                .toList();

            return Column(
              children: [
                if (pastTasks.isNotEmpty)
                  TaskListSection(
                    tasks: pastTasks,
                    taskListSectionState: TaskListBlockState.past,
                  ),
                if (todayTasks.isNotEmpty)
                  TaskListSection(
                    tasks: todayTasks,
                    taskListSectionState: TaskListBlockState.today,
                  ),
                if (futureTasks.isNotEmpty)
                  TaskListSection(
                    tasks: futureTasks,
                    taskListSectionState: TaskListBlockState.future,
                  ),
                if (completeTodayTasks.isNotEmpty)
                  TaskListSection(
                    tasks: completeTodayTasks,
                    taskListSectionState: TaskListBlockState.complete,
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}
