import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import '../services/task_service.dart';
import '../widgets/glass_card.dart';

class StatisticPage extends StatefulWidget {
  const StatisticPage({super.key});

  @override
  State<StatisticPage> createState() => _StatisticPageState();
}

class _StatisticPageState extends State<StatisticPage> {
  final TaskService _taskService = TaskService();
  int total = 0;
  int completed = 0;
  int pending = 0;
  double percentage = 0;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadStats();
  }

  Future<void> _loadStats() async {
    final tasks = await _taskService.getAllTasks();
    setState(() {
      total = tasks.length;
      completed = tasks.where((t) => t.isCompleted).length;
      pending = total - completed;
      percentage = total == 0 ? 0 : (completed / total);
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              FadeInDown(
                child: const Text(
                  '📊 Statistik Tugas',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              _isLoading 
                ? const CircularProgressIndicator()
                : FadeInUp(
                  child: GlassCard(
                    height: 300,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 150,
                          width: 150,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              CircularProgressIndicator(
                                value: percentage,
                                strokeWidth: 15,
                                backgroundColor: Colors.white10,
                                valueColor: const AlwaysStoppedAnimation<Color>(Colors.purpleAccent),
                              ),
                              Text(
                                '${(percentage * 100).toInt()}%',
                                style: const TextStyle(
                                  fontSize: 40, // Diperbesar dari 30
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _statLabel('Total', total),
                            _statLabel('Selesai', completed),
                            _statLabel('Pending', pending),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _statLabel(String label, int value) {
    return Column(
      children: [
        Text(value.toString(),
            style: const TextStyle(
                fontSize: 24, // Diperbesar dari 20
                fontWeight: FontWeight.bold,
                color: Colors.white)),
        Text(label,
            style: const TextStyle(
                fontSize: 16, // Diperbesar
                color: Colors.white60)),
      ],
    );
  }
}
