import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import '../models/task.dart';
import '../services/task_service.dart';
import '../widgets/task_tile.dart';
import '../animations/page_animation.dart';
import 'edit_task_page.dart';

class DeadlinePage extends StatefulWidget {
  const DeadlinePage({super.key});

  @override
  State<DeadlinePage> createState() => _DeadlinePageState();
}

class _DeadlinePageState extends State<DeadlinePage> {
  final TaskService _taskService = TaskService();
  List<Task> _tasks = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  Future<void> _loadTasks() async {
    setState(() => _isLoading = true);
    final tasks = await _taskService.getAllTasks();
    
    // Sort by deadline (simple string comparison for now, or parse date)
    tasks.sort((a, b) => a.deadline.compareTo(b.deadline));
    
    setState(() {
      _tasks = tasks;
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
                  '📅 Deadline Tugas',
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
                  : _tasks.isEmpty
                      ? const Center(child: Text('Tidak ada tugas', style: TextStyle(color: Colors.white54)))
                      : ListView.builder(
                          itemCount: _tasks.length,
                          itemBuilder: (context, index) {
                            final task = _tasks[index];
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
                              onTap: () async {
                                final result = await Navigator.push(
                                  context,
                                  FadePageRoute(child: EditTaskPage(task: task)),
                                );
                                if (result == true) _loadTasks();
                              },
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
