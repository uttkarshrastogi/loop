import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:loop/core/theme/colors.dart';
import 'package:loop/core/theme/text_styles.dart';
import 'package:loop/core/widgets/buttons/appbutton.dart';
import 'package:loop/core/widgets/dialog/app_dialog.dart';
import 'package:loop/feature/journey/presentation/bloc/journey_bloc.dart';
import 'package:loop/feature/journey/presentation/bloc/journey_state.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../ai/data/models/ai_generated_task_model.dart';
import '../../../journey/presentation/bloc/journey_event.dart';
import '../../../journey/presentation/pages/add_goal_dialog.dart';

class TodayLoopView extends StatefulWidget {
  final String? currentGoalId;

  const TodayLoopView({super.key, required this.currentGoalId});

  @override
  State<TodayLoopView> createState() => _TodayLoopViewState();
}

class _TodayLoopViewState extends State<TodayLoopView> {
  final Map<String, bool> _expandedTaskIds = {};

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Spacer(),
              GestureDetector(
                onTap: () {
                  context.push(AddGoalDialog.routeName);
                  // showAppDialog(
                  //   context: context,
                  //   child: const AddGoalDialog(),
                  //   title: "Create LOOP",
                  // );
                },
                child: Icon(Icons.add, color: AppColors.brandPurple),
              ),
            ],
          ),
          const Gap(16),
          BlocBuilder<JourneyBloc, JourneyState>(
            builder: (context, state) {
              return state.maybeWhen(
                tasksLoaded: (tasks) {
                  if (tasks.isEmpty) {
                    return const Text(
                      "No generated tasks yet. Start by creating one!",
                      style: TextStyle(color: Colors.white54),
                    );
                  }

                  final today = DateTime.now();
                  final tomorrow = today.add(const Duration(days: 1));
                  final grouped = <String, List<AiGeneratedTaskModel>>{};

                  for (final task in tasks) {
                    final date = DateTime(task.assignedDate.year, task.assignedDate.month, task.assignedDate.day);
                    final key = _isSameDay(date, today)
                        ? 'Today'
                        : _isSameDay(date, tomorrow)
                        ? 'Tomorrow'
                        : DateFormat('EEEE, MMMM d').format(date);
                    grouped.putIfAbsent(key, () => []).add(task);
                  }

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: grouped.entries.map((entry) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(entry.key, style: AppTextStyles.headingH6.copyWith(color: AppColors.border)),
                          const Gap(8),
                          ...entry.value.map((task) => _buildExpandableTaskCard(task)).toList(),
                          const Gap(16),
                        ],
                      );
                    }).toList(),
                  );
                },
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (msg) => Text("Error loading tasks: $msg"),
                orElse: () => const SizedBox.shrink(),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildExpandableTaskCard(AiGeneratedTaskModel task) {
    final isExpanded = _expandedTaskIds[task.id] ?? false;

    return GestureDetector(
      onTap: () {
        setState(() {
          _expandedTaskIds[task.id!] = !isExpanded;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                _buildStatusIcon(task),
                const Gap(12),
                Expanded(
                  child: Text(
                    cleanTitle(task.title),
                    style: AppTextStyles.paragraphLarge.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            if (isExpanded) ...[
              const Gap(8),
              Text(task.description, style: AppTextStyles.paragraphMedium.copyWith(color: Colors.white70)),
              if (task.source.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: InkWell(
                    onTap: () => launchUrl(Uri.parse(task.source)),
                    child: Text("View Resource",
                        style: AppTextStyles.paragraphMedium.copyWith(
                          color: AppColors.primary,
                          decoration: TextDecoration.underline,
                        )),
                  ),
                ),
              const Gap(8),
              Text('${task.estimatedHours} hours', style: AppTextStyles.paragraphSmall.copyWith(color: Colors.grey)),
              const Gap(12),
              if (!task.isCompleted && !task.isSkipped)
                Row(
                  children: [
                    AppButton(
                      width: 100,
                      text: "Skip",
                      onPressed: () => _updateStatus(task.id!, isSkipped: true),
                      isGhost: true,
                      withBorder: true,
                    ),
                    const Gap(12),
                    AppButton(
                      width: 150,
                      text: "Complete",
                      onPressed: () => _updateStatus(task.id!, isCompleted: true),
                      withBorder: true,
                      backGroundColor: AppColors.brandPurple,
                    ),
                  ],
                )
              else
                Row(
                  children: [
                    Text(task.isCompleted ? "✅ Completed" : "❌ Skipped"),
                    const Spacer(),
                    TextButton(
                      onPressed: () => _updateStatus(task.id!, isCompleted: false, isSkipped: false),
                      child: Text("Reset", style: AppTextStyles.paragraphSmall.copyWith(color: AppColors.brandPurple)),
                    ),
                  ],
                )
            ]
          ],
        ),
      ),
    );
  }

  void _updateStatus(String taskId, {bool isCompleted = false, bool isSkipped = false}) {
    if (widget.currentGoalId == null) {
      print('No goalId (loopDocId) set!');
      return;
    }
    context.read<JourneyBloc>().add(
      UpdateTaskStatus(
        taskId: taskId,
        isCompleted: isCompleted,
        isSkipped: isSkipped,
        loopDocId: widget.currentGoalId!,
      ),
    );
  }

  Widget _buildStatusIcon(AiGeneratedTaskModel task) {
    if (task.isCompleted) {
      return const Icon(Icons.check_circle, color: Colors.deepPurpleAccent);
    } else if (task.isSkipped) {
      return const Icon(Icons.cancel_rounded, color: Colors.redAccent);
    } else {
      return const Icon(Icons.radio_button_unchecked, color: Colors.grey);
    }
  }

  bool _isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  String cleanTitle(String title) {
    final regex = RegExp(r'^(Day \d+:|Week \d+:)\s*');
    return title.replaceFirst(regex, '');
  }
}
