import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import '../models/task.dart';
import '../services/task_service.dart';
import '../widgets/glass_card.dart';
import '../widgets/glass_button.dart';
import '../theme/app_theme.dart';

class EditTaskPage extends StatefulWidget {
  final Task task;
  const EditTaskPage({super.key, required this.task});

  @override
  State<EditTaskPage> createState() => _EditTaskPageState();
}

class _EditTaskPageState extends State<EditTaskPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _subjectController;
  late TextEditingController _deadlineController;
  final TaskService _taskService = TaskService();

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.task.title);
    _subjectController = TextEditingController(text: widget.task.subject);
    _deadlineController = TextEditingController(text: widget.task.deadline);
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      builder: (context, child) {
        final isDark = Theme.of(context).brightness == Brightness.dark;
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: isDark 
              ? const ColorScheme.dark(
                  primary: Colors.purpleAccent,
                  onPrimary: Colors.white,
                  surface: Color(0xFF1E1E2E),
                  onSurface: Colors.white,
                )
              : const ColorScheme.light(
                  primary: Colors.purpleAccent,
                  onPrimary: Colors.white,
                  surface: Colors.white,
                  onSurface: Colors.black,
                ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Colors.purpleAccent,
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        _deadlineController.text =
            "${picked.day}/${picked.month}/${picked.year}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(title: const Text('Edit Tugas')),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: AppTheme.getBackgroundColors(isDark),
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  Hero(
                    tag: 'task-${widget.task.id}',
                    child: FadeInUp(
                      child: GlassCard(
                        height: 450,
                        child: Material(
                          color: Colors.transparent,
                          child: Column(
                            children: [
                              TextFormField(
                                controller: _titleController,
                                style: TextStyle(color: isDark ? Colors.white : Colors.black),
                                decoration: InputDecoration(
                                  labelText: 'Judul Tugas',
                                  labelStyle: TextStyle(color: isDark ? Colors.white70 : Colors.black54),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: isDark ? Colors.white30 : Colors.black26),
                                  ),
                                ),
                                validator: (value) =>
                                    value!.isEmpty ? 'Judul tidak boleh kosong' : null,
                              ),
                              const SizedBox(height: 20),
                              TextFormField(
                                controller: _subjectController,
                                style: TextStyle(color: isDark ? Colors.white : Colors.black),
                                decoration: InputDecoration(
                                  labelText: 'Mata Kuliah',
                                  labelStyle: TextStyle(color: isDark ? Colors.white70 : Colors.black54),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: isDark ? Colors.white30 : Colors.black26),
                                  ),
                                ),
                                validator: (value) =>
                                    value!.isEmpty ? 'Mata kuliah tidak boleh kosong' : null,
                              ),
                              const SizedBox(height: 20),
                              TextFormField(
                                controller: _deadlineController,
                                style: TextStyle(color: isDark ? Colors.white : Colors.black),
                                decoration: InputDecoration(
                                  labelText: 'Deadline',
                                  labelStyle: TextStyle(color: isDark ? Colors.white70 : Colors.black54),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: isDark ? Colors.white30 : Colors.black26),
                                  ),
                                  suffixIcon: Icon(Icons.calendar_today, color: isDark ? Colors.white70 : Colors.black54),
                                ),
                                readOnly: true,
                                onTap: () => _selectDate(context),
                                validator: (value) =>
                                    value!.isEmpty ? 'Deadline tidak boleh kosong' : null,
                              ),
                              const Spacer(),
                              GlassButton(
                                text: 'Update Tugas',
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    widget.task.title = _titleController.text;
                                    widget.task.subject = _subjectController.text;
                                    widget.task.deadline = _deadlineController.text;
                                    await _taskService.updateTask(widget.task);
                                    if (!mounted) return;
                                    Navigator.pop(context, true);
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
