import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:loop/core/theme/colors.dart';
import 'package:loop/core/theme/text_styles.dart';
import 'package:loop/core/widgets/buttons/appbutton.dart';
import 'package:loop/feature/dashboard/presentation/widgets/single_task_card.dart';
import 'package:loop/feature/dashboard/presentation/widgets/task_detail_screen.dart';
import 'package:loop/feature/journey/presentation/pages/add_goal_dialog.dart';
import '../../../ai/data/models/ai_generated_task_model.dart';
import '../../../journey/presentation/bloc/journey_bloc.dart';
import '../../../journey/presentation/bloc/journey_state.dart';

class AllGoalsWidgetV2 extends StatefulWidget {
  const AllGoalsWidgetV2({Key? key}) : super(key: key);

  @override
  State<AllGoalsWidgetV2> createState() => _AllGoalsWidgetV2State();
}

class _AllGoalsWidgetV2State extends State<AllGoalsWidgetV2> {
  // track which goals are expanded
  final Map<String, bool> _expandedGoals = {};

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<JourneyBloc, JourneyState>(
      builder: (context, state) {
        return state.maybeWhen(
          allTasksLoaded: (groupedTasks) {
            if (groupedTasks.isEmpty) {
              return const Center(
                child: Text(
                  "No goals created yet!",
                  style: TextStyle(color: Colors.white54),
                ),
              );
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                GestureDetector(onTap: () {
                  context.push(AddGoalDialog.routeName);
                }, child: Icon(Icons.add,color: AppColors.brandPurple,)),

                ListView.builder(
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(16),
                  itemCount: groupedTasks.length,
                  itemBuilder: (context, index) {
                    final goalTasks = groupedTasks[index];
                    final goalId = goalTasks.first.goalId;
                    final isExpanded = _expandedGoals[goalId] ?? false;

                    // compute simple progress %
                    final completedCount =
                        goalTasks.where((t) => t.isCompleted).length;
                    final progress =
                        goalTasks.isEmpty
                            ? 0.0
                            : completedCount / goalTasks.length;

                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      color: AppColors.widgetBackground,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ExpansionTile(
                        key: PageStorageKey(goalId),
                        initiallyExpanded: isExpanded,
                        onExpansionChanged: (open) {
                          setState(() {
                            _expandedGoals[goalId] = open;
                          });
                        },
                        tilePadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        leading: SizedBox(
                          width: 40,
                          height: 40,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              CircularProgressIndicator(
                                value: progress,
                                strokeWidth: 4,
                                backgroundColor: AppColors.neutral200,
                                valueColor: AlwaysStoppedAnimation(
                                  AppColors.brandPurple,
                                ),
                              ),
                              Text(
                                "${(progress * 100).round()}%",
                                style: AppTextStyles.paragraphXSmall.copyWith(
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                        title: Text(
                          "Goal ${index + 1}",
                          style: AppTextStyles.headingH5.copyWith(
                            color: AppColors.textPrimary,
                          ),
                        ),
                        children: [
                          const Gap(8),
                          ...goalTasks.map((task) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 24.0,
                              ),
                              child: _buildTaskCard(task, context),
                            );
                          }).toList(),
                          const Gap(12),
                        ],
                      ),
                    );
                  },
                ),
              ],
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error:
              (msg) => Center(
                child: Text(
                  "Error: $msg",
                  style: const TextStyle(color: Colors.redAccent),
                ),
              ),
          orElse: () => Center(child: Text(state.toString())),
        );
      },
    );
  }

  Widget _buildTaskCard(AiGeneratedTaskModel task, BuildContext context) {
    return GoalTaskCard(
      hasGradient: true,
      task: task,
      onComplete: () {
        context.push(TaskDetailScreen.routeName, extra: task);
      },
      onSkip: () {},
      onEdit: () {},
      onViewTip: () {},
    );
  }
}
