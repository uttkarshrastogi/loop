import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:loop/core/widgets/template/page_template.dart';

import '../../../../core/model/loop_card_model.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../core/uiBloc/uiInteraction/ui_interaction_cubit.dart';
import '../../../../core/widgets/buttons/star_button.dart';
import '../../../../core/widgets/cards/loop_habit_card_widget.dart';
import '../../../../core/widgets/cards/purple_app_headbar.dart';
import '../../../generate loop/presentation/widgets/create_task_sheet.dart';
import '../../../journey/presentation/bloc/journey_bloc.dart';
import '../../../journey/presentation/bloc/journey_state.dart';

const IconData iconFruit = Icons.eco_outlined; // Example
const IconData iconStreak = Icons.sync_alt;
const IconData iconCalendar = Icons.calendar_today_outlined;
const IconData iconClock = Icons.access_time_outlined;
const IconData iconFire = Icons.local_fire_department_outlined;
const IconData iconStats = Icons.bar_chart_outlined;
const IconData iconMenu = Icons.menu;
// Placeholder icons (replace with actual icons you need, e.g., HeroIcons)

final cardData = LoopCardData(
  titleIcon: iconFruit,
  title: "Eating Fruits",
  progressPercent: 0.51, // 51%
  progressLabel: "51",
  tags: [
    TagData(iconData: iconStreak, label: "28 DAY STREAK"),
    TagData(iconData: iconCalendar, label: "135 DAYS LEFT"),
    TagData(iconData: iconClock, label: "MON-TUE-WED-THU-FRI-SAT"),
    TagData(
      iconData: iconFire,
      label: "HIGH",
      // Example: Custom styling for the "HIGH" tag
      backgroundColor: Colors.red.shade100,
      iconColor: Colors.red.shade700,
      textColor: Colors.red.shade700,
    ),
  ],
  description:
      "The core objective is to ensure that you hit your daily intake limit of 3 fruits/day. This will make sure that...",
  bottomIconsLeft: [
    iconCalendar,
    iconStats
  ], // Using same calendar icon for demo
  bottomIconRight: iconMenu,
);

class DashboardTemp extends StatelessWidget {
  const DashboardTemp({super.key});

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 75, right: 8),
        child: StarButton(
          onTap: (){
            context.read<UIInteractionCubit>().openSheet();
            //
            showModalBottomSheet(
              context: context,
              isScrollControlled: true, // ⬅️ critical
              backgroundColor: Colors.transparent,
              useRootNavigator: true,
              // backgroundColor: Theme.of(context).colorScheme.surface,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
              ),
              builder: (context) => const CreateTaskSheet(),
            );
          },
        ),
      ),
      replacementAppBar: buildPurpleHeaderAppBar(context, text: 'Yudha, you have 13 loops.\nAdd more loops?'),
        content: BlocBuilder<JourneyBloc, JourneyState>(
    builder: (context, state) {
      return state.maybeWhen(
        allTasksLoaded: (groupedTasks) {
          if (groupedTasks.isEmpty) {
            return const Padding(
              padding: EdgeInsets.all(24),
              child: Text(
                "No goals yet. Tap ✨ to create one!",
                style: AppTextStyles.paragraphLarge,
              ),
            );
          }

          return Column(
            children: [
              const SizedBox(height: 16),
              SizedBox(
                height: 320,
                child: PageView.builder(
                  controller: PageController(viewportFraction: 0.9),
                  itemCount: groupedTasks.length,
                  itemBuilder: (context, index) {
                    final goalTasks = groupedTasks[index];
                    final goalTitle = goalTasks.first.goalTitle ?? 'Untitled Goal';

                    final completedCount = goalTasks.where((t) => t.isCompleted).length;
                    final progress = goalTasks.isEmpty ? 0.0 : completedCount / goalTasks.length;

                    // return LoopHabitInfoCard(
                    //   title: goalTitle,
                    //   progress: progress,
                    //   taskCount: goalTasks.length,
                    //   onTap: () {
                    //     // you can push to detail if needed
                    //   }, cardData: null,
                    // );
                  },
                ),
              ),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        orElse: () => const SizedBox(),
      );
    },
    ),

    );
  }
}
