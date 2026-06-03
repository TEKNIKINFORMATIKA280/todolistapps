import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../models/task.dart';
import '../services/task_service.dart';
import '../widgets/task_tile.dart';
import '../animations/page_animation.dart';
import 'add_task_page.dart';
import 'edit_task_page.dart';
import '../main.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TaskService _taskService = TaskService();
  List<Task> _tasks = [];
  List<Task> _filteredTasks = [];
  bool _isLoading = true;
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();
  bool _isSearchFocused = false;

  @override
  void initState() {
    super.initState();
    _loadTasks();
    _searchController.addListener(_filterTasks);
    _searchFocusNode.addListener(() {
      setState(() {
        _isSearchFocused = _searchFocusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _searchFocusNode.dispose();
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadTasks() async {
    setState(() => _isLoading = true);
    final tasks = await _taskService.getAllTasks();
    setState(() {
      _tasks = tasks;
      _filterTasks(); // Re-filter and sort
      _isLoading = false;
    });
  }

  void _filterTasks() {
    final query = _searchController.text.toLowerCase();
    var filtered = _tasks.where((task) {
      return task.title.toLowerCase().contains(query) ||
          task.subject.toLowerCase().contains(query);
    }).toList();

    // Apply Sorting
    if (_sortBy == 'title') {
      filtered.sort((a, b) => a.title.compareTo(b.title));
    } else if (_sortBy == 'completed') {
      filtered.sort((a, b) => (a.isCompleted ? 1 : 0).compareTo(b.isCompleted ? 1 : 0));
    } else {
      filtered.sort((a, b) => b.id!.compareTo(a.id!)); // Default by ID/Latest
    }

    setState(() {
      _filteredTasks = filtered;
    });
  }

  Widget _buildStatItem(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: Colors.purpleAccent, size: 24),
        const SizedBox(height: 6),
        Text(
          value,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.white60,
          ),
        ),
      ],
    );
  }

  String _sortBy = 'latest';

  Future<void> _toggleTaskStatus(Task task) async {
    task.isCompleted = !task.isCompleted;
    await _taskService.updateTask(task);
    _loadTasks();
  }

  Future<void> _deleteTask(int id) async {
    await _taskService.deleteTask(id);
    _loadTasks();
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FadeInDown(
                    child: const Text(
                      '📚 To-Do Mahasiswa',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      ValueListenableBuilder<ThemeMode>(
                        valueListenable: themeNotifier,
                        builder: (context, currentMode, child) {
                          final isDark = currentMode == ThemeMode.dark;
                          return IconButton(
                            icon: Icon(
                              isDark ? Icons.dark_mode : Icons.light_mode,
                              color: isDark ? Colors.purpleAccent : Colors.orangeAccent,
                            ).animate().rotate(duration: 500.ms),
                            onPressed: () {
                              themeNotifier.value =
                                  isDark ? ThemeMode.light : ThemeMode.dark;
                            },
                          );
                        },
                      ),
                      PopupMenuButton<String>(
                        icon: const Icon(Icons.sort, color: Colors.white),
                        onSelected: (value) {
                          setState(() {
                            _sortBy = value;
                            _filterTasks();
                          });
                        },
                        itemBuilder: (context) => [
                          const PopupMenuItem(
                              value: 'latest', child: Text('Terbaru')),
                          const PopupMenuItem(
                              value: 'title', child: Text('Nama (A-Z)')),
                          const PopupMenuItem(
                              value: 'completed', child: Text('Status')),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: FadeIn(
                delay: const Duration(milliseconds: 200),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.white.withOpacity(0.1)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildStatItem('Total', _tasks.length.toString(), Icons.assignment),
                      Container(width: 1, height: 40, color: Colors.white24),
                      _buildStatItem('Selesai', _tasks.where((t) => t.isCompleted).length.toString(), Icons.check_circle),
                      Container(width: 1, height: 40, color: Colors.white24),
                      _buildStatItem('Pending', _tasks.where((t) => !t.isCompleted).length.toString(), Icons.pending_actions),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: FadeIn(
                delay: const Duration(milliseconds: 300),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.easeInOutBack,
                  width: double.infinity,
                  height: 55,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(_isSearchFocused ? 0.2 : 0.1),
                    borderRadius: BorderRadius.circular(_isSearchFocused ? 30 : 15),
                    border: Border.all(
                      color: _isSearchFocused 
                        ? Colors.purpleAccent.withOpacity(0.5) 
                        : Colors.transparent
                    ),
                  ),
                  child: TextField(
                    controller: _searchController,
                    focusNode: _searchFocusNode,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: 'Cari tugas...',
                      hintStyle: const TextStyle(color: Colors.white54),
                      prefixIcon: Icon(
                        Icons.search, 
                        color: _isSearchFocused ? Colors.purpleAccent : Colors.white54
                      ),
                      suffixIcon: _searchController.text.isNotEmpty 
                        ? IconButton(
                            icon: const Icon(Icons.clear, color: Colors.white54),
                            onPressed: () {
                              _searchController.clear();
                              _searchFocusNode.unfocus();
                            },
                          )
                        : null,
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(vertical: 15),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : _filteredTasks.isEmpty
                      ? Center(
                          child: FadeIn(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.assignment_outlined,
                                    size: 80, color: Colors.white24),
                                const SizedBox(height: 16),
                                const Text(
                                  'Belum ada tugas nih,\ntambah yuk!',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white54,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      : ListView.builder(
                          itemCount: _filteredTasks.length,
                          itemBuilder: (context, index) {
                            final task = _filteredTasks[index];
                            return TaskTile(
                              task: task,
                              onToggle: () => _toggleTaskStatus(task),
                              onDelete: () => _deleteTask(task.id!),
                              onTap: () async {
                                final result = await Navigator.push(
                                  context,
                                  FadePageRoute(
                                    child: EditTaskPage(task: task),
                                  ),
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
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 80),
        child: FloatingActionButton(
          onPressed: () async {
            final result = await Navigator.push(
              context,
              SlidePageRoute(child: const AddTaskPage()),
            );
            if (result == true) _loadTasks();
          },
          backgroundColor: Colors.purpleAccent,
          child: const Icon(Icons.add),
        ).animate().scale(delay: 400.ms, duration: 500.ms, curve: Curves.elasticOut),
      ),
    );
  }
}
