import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../widgets/glass_card.dart';
import '../services/task_service.dart';
import 'setting_detail_page.dart';
import 'edit_profile_page.dart';
import 'contact_page.dart';
import '../main.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  void _showResetDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1E1E2E),
        title: const Text('Reset Data', style: TextStyle(color: Colors.white)),
        content: const Text('Apakah Anda yakin ingin menghapus semua tugas?',
            style: TextStyle(color: Colors.white70)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () async {
              await TaskService().deleteAllTasks();
              if (context.mounted) {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Semua data berhasil dihapus')),
                );
              }
            },
            child: const Text('Ya, Hapus',
                style: TextStyle(color: Colors.redAccent)),
          ),
        ],
      ),
    );
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
                  '⚙️ Pengaturan',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: FadeInUp(
                  duration: const Duration(milliseconds: 600),
                  child: GlassCard(
                    height: double.infinity,
                    child: Material(
                      color: Colors.transparent,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            _buildItem(
                              context: context,
                              icon: Icons.person,
                              title: 'Profil Pengguna',
                              trailing: userNameNotifier,
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (_) => const EditProfilePage()));
                              },
                            ),
                            ValueListenableBuilder<ThemeMode>(
                              valueListenable: themeNotifier,
                              builder: (context, currentMode, _) {
                                final isDark = currentMode == ThemeMode.dark;
                                return ListTile(
                                  onTap: () => themeNotifier.value = isDark ? ThemeMode.light : ThemeMode.dark,
                                  leading: Icon(isDark ? Icons.dark_mode : Icons.light_mode, color: Colors.purpleAccent, size: 28),
                                  title: const Text('Tema Aplikasi', style: TextStyle(color: Colors.white, fontSize: 18)),
                                  trailing: Switch(
                                    value: isDark,
                                    activeColor: Colors.purpleAccent,
                                    onChanged: (val) => themeNotifier.value = val ? ThemeMode.dark : ThemeMode.light,
                                  ),
                                );
                              },
                            ),
                            _buildItem(
                              context: context,
                              icon: Icons.info_outline,
                              title: 'Informasi Aplikasi',
                              trailingValue: 'v1.2.0',
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (_) => const SettingDetailPage(
                                  title: 'Informasi Aplikasi',
                                  content: '1. Nama: To-Do Mahasiswa\n2. Versi: 1.2.0\n3. Developer: Rafael Paulus Sitompul\n4. Kontak: rafaelsitompoel@gmail.com\n5. Platform: Flutter SDK\n6. Database: SQLite\n7. UI Design: Glassmorphism\n8. Animasi: Premium Engine\n9. Fitur: Smart Deadline\n10. Tema: Dynamic Mode\n11. Lisensi: Personal\n12. © 2026 Rafael Paulus Sitompul',
                                )));
                              },
                            ),
                            _buildItem(
                              context: context,
                              icon: Icons.help_outline_rounded,
                              title: 'Tentang Aplikasi',
                              trailingValue: 'About',
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (_) => const SettingDetailPage(
                                  title: 'Tentang Aplikasi',
                                  content: 'Aplikasi To-Do Mahasiswa dirancang untuk membantu Anda mengelola tugas akademik dengan lebih terorganisir dengan antarmuka Glassmorphism yang modern.',
                                )));
                              },
                            ),
                            _buildItem(
                              context: context,
                              icon: Icons.chat_outlined,
                              title: 'Hubungi WhatsApp',
                              trailingValue: 'Admin',
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (_) => const ContactPage()));
                              },
                            ),
                            const Divider(color: Colors.white12),
                            ListTile(
                              leading: const Icon(Icons.delete_forever, color: Colors.redAccent)
                                  .animate(onPlay: (c) => c.repeat(reverse: true)).shake(hz: 2),
                              title: const Text('Reset Semua Data', style: TextStyle(color: Colors.redAccent, fontSize: 18)),
                              onTap: () => _showResetDialog(context),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const Text('© 2026 To-Do Mahasiswa', style: TextStyle(color: Colors.white30, fontSize: 12)),
              const SizedBox(height: 85),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildItem({
    required BuildContext context,
    required IconData icon,
    required String title,
    ValueNotifier<String>? trailing,
    String? trailingValue,
    required VoidCallback onTap,
  }) {
    return ListTile(
      onTap: onTap,
      leading: Icon(icon, color: Colors.purpleAccent, size: 28),
      title: Text(title, style: const TextStyle(color: Colors.white, fontSize: 18)),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (trailing != null)
            ValueListenableBuilder<String>(
              valueListenable: trailing,
              builder: (_, val, __) => Text(val, style: const TextStyle(color: Colors.white60, fontSize: 14)),
            )
          else if (trailingValue != null)
            Text(trailingValue, style: const TextStyle(color: Colors.white60, fontSize: 14)),
          const SizedBox(width: 8),
          const Icon(Icons.chevron_right, color: Colors.white30, size: 20),
        ],
      ),
    );
  }
}
