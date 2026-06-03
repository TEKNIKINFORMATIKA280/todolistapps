import '../database/database_helper.dart';
import '../models/task.dart';

class TaskService {
  final DatabaseHelper _dbHelper = DatabaseHelper.instance;

  Future<int> addTask(Task task) async {
    return await _dbHelper.insertTask(task);
  }

  Future<List<Task>> getAllTasks() async {
    return await _dbHelper.getAllTasks();
  }

  Future<int> updateTask(Task task) async {
    return await _dbHelper.updateTask(task);
  }

  Future<int> deleteTask(int id) async {
    return await _dbHelper.deleteTask(id);
  }

  Future<int> deleteAllTasks() async {
    return await _dbHelper.deleteAllTasks();
  }
}
