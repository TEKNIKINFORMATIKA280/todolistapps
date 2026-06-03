import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class GlassNavbar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const GlassNavbar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final unselectedColor = isDark ? Colors.white60 : Colors.black45;

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
      child: GlassmorphicContainer(
        width: double.infinity,
        height: 70,
        borderRadius: 30,
        blur: 20,
        alignment: Alignment.center,
        border: 2,
        linearGradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            (isDark ? Colors.white : Colors.black).withOpacity(0.15),
            (isDark ? Colors.white : Colors.black).withOpacity(0.05),
          ],
        ),
        borderGradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            (isDark ? Colors.white : Colors.black).withOpacity(0.5),
            (isDark ? Colors.white : Colors.black).withOpacity(0.2),
          ],
        ),
        child: SalomonBottomBar(
          currentIndex: currentIndex,
          onTap: onTap,
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          itemPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          items: [
            /// Home
            SalomonBottomBarItem(
              icon: const Icon(Icons.home_rounded),
              title: const Text("Home"),
              selectedColor: Colors.purpleAccent,
              unselectedColor: unselectedColor,
            ),

            /// Deadline
            SalomonBottomBarItem(
              icon: const Icon(Icons.calendar_month_rounded),
              title: const Text("Deadline"),
              selectedColor: Colors.orangeAccent,
              unselectedColor: unselectedColor,
            ),

            /// Completed
            SalomonBottomBarItem(
              icon: const Icon(Icons.check_circle_rounded),
              title: const Text("Selesai"),
              selectedColor: Colors.greenAccent,
              unselectedColor: unselectedColor,
            ),

            /// Statistics
            SalomonBottomBarItem(
              icon: const Icon(Icons.bar_chart_rounded),
              title: const Text("Stats"),
              selectedColor: Colors.blueAccent,
              unselectedColor: unselectedColor,
            ),

            /// Settings
            SalomonBottomBarItem(
              icon: const Icon(Icons.settings_rounded),
              title: const Text("Settings"),
              selectedColor: Colors.tealAccent,
              unselectedColor: unselectedColor,
            ),
          ],
        ),
      ),
    );
  }
}
