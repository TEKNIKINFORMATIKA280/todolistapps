import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import '../widgets/glass_card.dart';
import '../widgets/glass_button.dart';
import '../theme/app_theme.dart';
import '../main.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late TextEditingController _nameController;
  late TextEditingController _statusController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: userNameNotifier.value);
    _statusController = TextEditingController(text: userStatusNotifier.value);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _statusController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Edit Profil'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: isDark ? Colors.white : Colors.black),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
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
            child: Column(
              children: [
                FadeInUp(
                  child: GlassCard(
                    height: 350,
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        TextField(
                          controller: _nameController,
                          style: TextStyle(color: isDark ? Colors.white : Colors.black),
                          decoration: InputDecoration(
                            labelText: 'Nama Lengkap',
                            labelStyle: TextStyle(color: isDark ? Colors.white70 : Colors.black54),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: isDark ? Colors.white30 : Colors.black26),
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),
                        TextField(
                          controller: _statusController,
                          style: TextStyle(color: isDark ? Colors.white : Colors.black),
                          decoration: InputDecoration(
                            labelText: 'Status / Peran',
                            labelStyle: TextStyle(color: isDark ? Colors.white70 : Colors.black54),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: isDark ? Colors.white30 : Colors.black26),
                            ),
                          ),
                        ),
                        const Spacer(),
                        GlassButton(
                          text: 'Simpan Perubahan',
                          onPressed: () {
                            userNameNotifier.value = _nameController.text;
                            userStatusNotifier.value = _statusController.text;
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Profil berhasil diperbarui')),
                            );
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
    );
  }
}
