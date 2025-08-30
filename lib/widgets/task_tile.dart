import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../models/task_model.dart';
import '../controller/task_controller.dart';
import 'task_form.dart';

class TaskTile extends StatelessWidget {
  final Task task;
  const TaskTile({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<TaskController>();

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
      child: ListTile(
        leading: Checkbox(
          value: task.isDone == 1,
          onChanged: (_) => controller.toggleDone(task),
        ),
        title: Text(
          task.title,
          style: TextStyle(
            decoration: task.isDone == 1
                ? TextDecoration.lineThrough
                : TextDecoration.none,
          ),
        ),
        subtitle: task.notes != null ? Text(task.notes!) : null,

        // 👇 Add edit + delete buttons here
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.edit, color: Colors.blue),
              onPressed: () async {
                final editedTask = await showModalBottomSheet<Task>(
                  context: context,
                  isScrollControlled: true,
                  builder: (_) => TaskForm(task: task),
                );
                if (editedTask != null) {
                  controller.updateTask(editedTask);
                }
              },
            ),
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () {
                controller.deleteTask(task.id!);
              },
            ),
          ],
        ),
      ),
    );
  }
}
