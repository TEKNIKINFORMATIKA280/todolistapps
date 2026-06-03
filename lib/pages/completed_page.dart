import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import '../models/task.dart';
import '../services/task_service.dart';
import '../widgets/task_tile.dart';

class CompletedPage extends StatefulWidget {
  const CompletedPage({super.key});

  @override
  State<CompletedPage> createState() => _CompletedPageState();
}

class _CompletedPageState extends State<CompletedPage> {
  final TaskService _taskService = TaskService();
  List<Task> _completedTasks = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  Future<void> _loadTasks() async {
    setState(() => _isLoading = true);
    final tasks = await _taskService.getAllTasks();
    setState(() {
      _completedTasks = tasks.where((t) => t.isCompleted).toList();
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: FadeInDown(
                child: const Text(
                  '✅ Tugas Selesai',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Expanded(
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : _completedTasks.isEmpty
                      ? const Center(child: Text('Belum ada tugas selesai', style: TextStyle(color: Colors.white54)))
                      : ListView.builder(
                          itemCount: _completedTasks.length,
                          itemBuilder: (context, index) {
                            final task = _completedTasks[index];
                            return TaskTile(
                              task: task,
                              onToggle: () async {
                                task.isCompleted = !task.isCompleted;
                                await _taskService.updateTask(task);
                                _loadTasks();
                              },
                              onDelete: () async {
                                await _taskService.deleteTask(task.id!);
                                _loadTasks();
                              },
                              onTap: () {},
                            );
                          },
                        ),
            ),
          ],
        ),
      ),
    );
  }
}
