import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:loop/core/theme/colors.dart';
import 'package:loop/core/theme/text_styles.dart';
import 'package:loop/feature/dashboard/presentation/widgets/single_task_card.dart';
import 'package:loop/feature/dashboard/presentation/widgets/task_detail_screen.dart';
import '../../../ai/data/models/ai_generated_task_model.dart';
import '../../../journey/presentation/bloc/journey_bloc.dart';
import '../../../journey/presentation/bloc/journey_state.dart';

class AllGoalsWidget extends StatelessWidget {
  const AllGoalsWidget({super.key});

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

            return ListView.separated(
              padding: const EdgeInsets.all(16),
              separatorBuilder: (_, __) => const SizedBox(height: 24),
              itemCount: groupedTasks.length,
              itemBuilder: (context, index) {
                final goalTasks = groupedTasks[index];

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Goal ${index + 1}",
                      style: AppTextStyles.headingH5.copyWith(
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const Gap(12),
                    ...goalTasks
                        .map((task) => _buildTaskCard(task, context))
                        .toList(),
                  ],
                );
              },
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error:
              (msg) => Center(
                child: Text(
                  "Error: $msg",
                  style: TextStyle(color: Colors.redAccent),
                ),
              ),
          orElse: () {
            return Center(child: Text(state.toString()));
          },
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
