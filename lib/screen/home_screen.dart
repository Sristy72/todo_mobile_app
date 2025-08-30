import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/task_controller.dart';
import '../models/task_model.dart';
import '../widgets/task_form.dart';
import '../widgets/task_tile.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final controller = Get.put(TaskController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("My To-Do"), backgroundColor: Color.fromARGB(
          255, 185, 172, 198),),
      body: Obx(() {
        if (controller.tasks.isEmpty) {
          return const Center(child: Text("No tasks yet"));
        }
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
            itemCount: controller.tasks.length,
            itemBuilder: (_, i) => TaskTile(task: controller.tasks[i]),
          ),
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final task = await showModalBottomSheet<Task>(
            useSafeArea: true,
            context: context,
            isScrollControlled: true,
            builder: (_) => const TaskForm(),
          );
          if (task != null) {
            controller.addTask(task);
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
