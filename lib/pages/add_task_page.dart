import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import '../models/task.dart';
import '../services/task_service.dart';
import '../widgets/glass_card.dart';
import '../widgets/glass_button.dart';
import '../theme/app_theme.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({super.key});

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _subjectController = TextEditingController();
  final _deadlineController = TextEditingController();
  final TaskService _taskService = TaskService();

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
      appBar: AppBar(title: const Text('Tambah Tugas')),
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
                  FadeInUp(
                    duration: const Duration(milliseconds: 600),
                    child: GlassCard(
                      height: 450,
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
                            text: 'Simpan Tugas',
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                final task = Task(
                                  title: _titleController.text,
                                  subject: _subjectController.text,
                                  deadline: _deadlineController.text,
                                );
                                await _taskService.addTask(task);
                                if (!mounted) return;
                                Navigator.pop(context, true);
                              }
                            },
                          ),
                        ],
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
