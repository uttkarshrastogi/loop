import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:loop/core/theme/colors.dart';
import 'package:loop/core/theme/text_styles.dart';
import 'package:loop/core/widgets/buttons/appbutton.dart';
import 'package:loop/core/widgets/template/page_template.dart';
import 'package:loop/feature/auth/presentation/bloc/auth_bloc.dart';

import 'package:loop/core/uiBloc/uiInteraction/ui_interaction_cubit.dart';
import 'package:loop/core/widgets/dialog/app_dialog.dart';

import 'package:loop/feature/journey/presentation/bloc/journey_bloc.dart';
import 'package:loop/feature/journey/presentation/bloc/journey_state.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../ai/data/models/ai_generated_task_model.dart';
import '../../../journey/presentation/bloc/journey_event.dart';
import '../../../journey/presentation/pages/add_goal_dialog.dart';

class DashboardPage extends StatefulWidget {
  static const routeName = '/dashboard';

  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage>
    with SingleTickerProviderStateMixin {
  final Map<String, bool> _expandedTaskIds = {};
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UIInteractionCubit, UIState>(
      builder: (context, uiState) {
        final scale = uiState == UIState.sheetOpen ? 0.90 : 1.0;
        final offset = Offset(0, uiState == UIState.sheetOpen ? 0.01 : 0);
        final backgroundColor =
        uiState == UIState.sheetOpen ? AppColors.backgroundZaxis : AppColors.background;

        return Container(
          color: Colors.black,
          child: AnimatedScale(
            scale: scale,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeOut,
            child: AnimatedSlide(
              offset: offset,
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeOut,
              child: ClipRRect(
                borderRadius: BorderRadius.vertical(
                  top: uiState == UIState.sheetOpen ? const Radius.circular(12) : Radius.zero,
                ),
                child: PageTemplate(
                  backgroundColor: backgroundColor,
                  showBackArrow: false,
                  content: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            onPressed: () {
                              context.read<AuthBloc>().add(const AuthEvent.signOut());
                            },
                            icon: Icon(Icons.logout_rounded, color: AppColors.textSecondary),
                          ),
                        ],
                      ),
                      TabBar(
                        splashFactory: NoSplash.splashFactory,
                        overlayColor: MaterialStateProperty.all(Colors.transparent),
                        controller: _tabController,
                        labelColor: AppColors.brandFuchsiaPurple400,
                        unselectedLabelColor: AppColors.textSecondary,
                        indicator: BoxDecoration(
                          color: AppColors.brandFuchsiaPurple400.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        tabs: const [
                          Tab(child: Center(child: Text("LOOP"))),
                          Tab(child: Center(child: Text("Goal"))),
                        ],
                      ),
                      const Gap(16),
                      Expanded(
                        child: TabBarView(
                          controller: _tabController,
                          children: [
                            _buildLoopTab(context),
                            const Center(
                              child: Text("Goals tab here", style: TextStyle(color: Colors.white)),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildLoopTab(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Spacer(),
              GestureDetector(
                onTap: () {
                  showAppDialog(
                    context: context,
                    child: const AddGoalDialog(),
                    title: "Create LOOP",
                  );
                },
                child: Icon(Icons.add, color: AppColors.brandFuchsiaPurple400),
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
                    final key =
                    _isSameDay(date, today) ? 'Today' : _isSameDay(date, tomorrow) ? 'Tomorrow' : DateFormat('EEEE, MMMM d').format(date);

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
                          ...entry.value.map((task) => _buildExpandableTaskCard(task)),
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
          // boxShadow: [
          //   BoxShadow(
          //     color: AppColors.surface.withOpacity(0.2),
          //     blurRadius: 2,
          //     offset: const Offset(0, 2),
          //   ),
          // ],
          borderRadius: BorderRadius.circular(12),
          // border: Border.all(
          //   color: task.isCompleted
          //       ? AppColors.success
          //       : task.isSkipped
          //       ? AppColors.error
          //       : Colors.transparent,
          //   width: 1,
          // ),
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
                      backGroundColor: AppColors.brandFuchsiaPurple400,
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
                      child: Text("Reset", style: AppTextStyles.paragraphSmall.copyWith(color: AppColors.brandFuchsiaPurple400)),
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
    context.read<JourneyBloc>().add(UpdateTaskStatus(taskId: taskId, isCompleted: isCompleted, isSkipped: isSkipped));
  }
  Widget _buildStatusIcon(AiGeneratedTaskModel task) {
    if (task.isCompleted) {
      return const Icon(Icons.check_circle, color: Colors.deepPurpleAccent); // DONE
    } else if (task.isSkipped) {
      return const Icon(Icons.cancel_rounded, color: Colors.redAccent); // SKIPPED
    } else {
      // You can extend this further to check "in review" or "in progress"
      return const Icon(Icons.radio_button_unchecked, color: Colors.grey); // DEFAULT/TODO
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