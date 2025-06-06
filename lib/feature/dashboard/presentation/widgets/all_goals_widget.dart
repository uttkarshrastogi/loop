import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:loop/core/theme/colors.dart';
import 'package:loop/core/theme/text_styles.dart';
import 'package:loop/feature/dashboard/presentation/widgets/single_task_card.dart';
import 'package:loop/feature/dashboard/presentation/widgets/task_detail_screen.dart';
import '../../../../core/model/task_item_data.dart';
import '../../../../core/widgets/buttons/appbutton.dart';
import '../../../../core/widgets/buttons/swipableTaskButton.dart';
import '../../../../core/widgets/cards/squircle_container.dart';
import '../../../ai/data/models/ai_generated_task_model.dart';
import '../../../journey/presentation/bloc/journey_bloc.dart';
import '../../../journey/presentation/bloc/journey_state.dart';
import 'goal_card_widget.dart';
import 'dart:developer';

class AllGoalsWidget extends StatefulWidget {
  const AllGoalsWidget({Key? key}) : super(key: key);

  @override
  State<AllGoalsWidget> createState() => _AllGoalsWidgetState();
}

class _AllGoalsWidgetState extends State<AllGoalsWidget> {
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // const Padding(
                //   padding: EdgeInsets.symmetric(horizontal: 16),
                //   child: Text("Your Goals", style: AppTextStyles.headingH4),
                // ),
                const SizedBox(height: 16),
                SizedBox(
                  // color: Colors.yellowAccent,
                  height: 320, // Fixed height if consistent across screen sizes
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: PageView.builder(
                      controller: PageController(viewportFraction: 0.9),
                      itemCount: groupedTasks.length,
                      itemBuilder: (context, index) {
                        final goalTasks = groupedTasks[index];
                        final goalTitle = goalTasks.first.goalTitle;

                        final completedCount =
                            goalTasks.where((t) => t.isCompleted).length;
                        final progress =
                            goalTasks.isEmpty
                                ? 0.0
                                : completedCount / goalTasks.length;
                        return GoalCardWidget(
                          title: goalTitle ?? "",
                          progress: progress,
                          onTap: () {
                            // TODO: Navigate to expanded view
                          },
                          taskCount: 2,
                        );
                      },
                    ),
                  ),
                ),
                // SquircleContainer(),


                AppButton(
                  text: "text",
                  onPressed: () async {
                    log(
                      await FirebaseAuth.instance.currentUser?.getIdToken(true)??"",
                    );
                  },
                ),
                Padding(
                  padding: const EdgeInsets.all(80.0),
                  child: SwipableTaskButton(
                    taskData: TaskItemData(
                        id: "id",
                        title: "title",
                        time: "time",
                        dateText: "dateText"),
                    onSwipeLeftToRight: () {},
                    onSwipeRightToLeft: () {},
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 80.0),
                  child: SquircleMaterialContainer(height: 100, cornerRadius: 30,),
                ),
              ],
            );
          },
          // loading: () => const Center(child: CircularProgressIndicator()),
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
