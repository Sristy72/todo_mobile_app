import 'package:get/get.dart';
import '../database/task_db.dart';
import '../models/task_model.dart';

class TaskController extends GetxController {
  var tasks = <Task>[].obs;
  final TaskDB _db = TaskDB();

  @override
  void onInit() {
    super.onInit();
    loadTasks();
  }

  Future<void> loadTasks() async {
    final data = await _db.getAllTasks();
    tasks.assignAll(data);
  }

  Future<void> addTask(Task task) async {
    await _db.insertTask(task);
    loadTasks();
  }

  Future<void> updateTask(Task task) async {
    await _db.updateTask(task);
    loadTasks();
  }

  Future<void> deleteTask(int id) async {
    await _db.deleteTask(id);
    loadTasks();
  }

  Future<void> toggleDone(Task task) async {
    task.isDone = task.isDone == 1 ? 0 : 1;
    await _db.updateTask(task);
    loadTasks();
  }
}
