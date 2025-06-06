import 'package:flutter/material.dart';
import 'package:loop/core/theme/colors.dart';
import 'package:loop/core/theme/text_styles.dart';

class TempScreen extends StatelessWidget {
  static const routeName ="/TempScreen";
  const TempScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to Add Habit screen
        },
        backgroundColor: AppColors.brandColor,
        child: const Icon(Icons.add, size: 32),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: AppColors.brandColor,
        unselectedItemColor: AppColors.textSecondary,
        showUnselectedLabels: true,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.insert_chart_outlined),
            activeIcon: Icon(Icons.insert_chart),
            label: 'Stats',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.lightbulb_outline),
            activeIcon: Icon(Icons.lightbulb),
            label: 'Tips',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Greeting and streak
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text('Good Morning, Alex!', style: AppTextStyles.headingH2),
                        SizedBox(height: 4),
                        Text('Keep your streak going 🔥', style: AppTextStyles.paragraphMedium),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.brandColor.withOpacity(0.1),
                    ),
                    child: const Icon(Icons.local_fire_department, color: AppColors.brandColor),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Progress ring
              Center(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      width: 120,
                      height: 120,
                      child: CircularProgressIndicator(
                        value: 0.6,
                        strokeWidth: 12,
                        color: AppColors.brandColor,
                        backgroundColor: AppColors.brandColor.withOpacity(0.2),
                      ),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Text('60%', style: AppTextStyles.headingH2),
                        Text('Complete', style: AppTextStyles.paragraphSmall),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Today's Habits list
              const Text('Today', style: AppTextStyles.headingH3),
              const SizedBox(height: 12),
              Expanded(
                child: ListView.separated(
                  itemCount: 3,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    return HabitCard(
                      title: index == 0 ? 'Meditation' : index == 1 ? 'Drink Water' : 'Read Book',
                      subtitle: index == 1 ? '5 of 8 glasses' : null,
                      done: index == 0,
                      onToggle: (done) {
                        // Handle toggle
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HabitCard extends StatelessWidget {
  final String title;
  final String? subtitle;
  final bool done;
  final ValueChanged<bool> onToggle;

  const HabitCard({
    Key? key,
    required this.title,
    this.subtitle,
    this.done = false,
    required this.onToggle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.widgetBackground,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            offset: const Offset(0, 2),
            blurRadius: 6,
          ),
        ],
      ),
      child: Row(
        children: [
          Checkbox(
            value: done,
            onChanged: (v) => onToggle(v ?? false),
            activeColor: AppColors.brandColor,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppTextStyles.headingH4),
                if (subtitle != null) ...[
                  const SizedBox(height: 4),
                  Text(subtitle!, style: AppTextStyles.paragraphSmall),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class EmptyDashboardScreen extends StatelessWidget {
  const EmptyDashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to Add Habit
        },
        backgroundColor: AppColors.brandColor,
        child: const Icon(Icons.add, size: 32),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: AppColors.brandColor,
        unselectedItemColor: AppColors.textSecondary,
        showUnselectedLabels: true,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.insert_chart_outlined),
            activeIcon: Icon(Icons.insert_chart),
            label: 'Stats',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.lightbulb_outline),
            activeIcon: Icon(Icons.lightbulb),
            label: 'Tips',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.celebration, size: 96, color: AppColors.brandColor.withOpacity(0.3)),
                const SizedBox(height: 24),
                Text('You’re all caught up!', style: AppTextStyles.headingH3, textAlign: TextAlign.center),
                const SizedBox(height: 12),
                Text(
                  'Great job completing your habits for today. Come back tomorrow for more!',
                  style: AppTextStyles.paragraphMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    // Navigate to Add Habit
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.brandColor,
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  child: const Text('Add a Habit'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
