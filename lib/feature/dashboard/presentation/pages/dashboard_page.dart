import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:loop/core/theme/colors.dart';
import 'package:loop/core/theme/text_styles.dart';
import 'package:loop/core/widgets/icons/app_icon.dart';
import 'package:loop/core/widgets/template/page_template.dart';
import 'package:lottie/lottie.dart';
import '../../../../core/uiBloc/uiInteraction/ui_interaction_cubit.dart';
import '../../../../core/widgets/dialog/app_dialog.dart';
import '../../../goal/presentation/bloc/goal_bloc.dart';
import '../../../goal/presentation/bloc/goal_event.dart';
import '../../../goal/presentation/bloc/goal_state.dart';
import '../../../goal/presentation/widgets/add_goal_dialog.dart';

class DashboardPage extends StatefulWidget {
  static const routeName = '/dashboard';

  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  void initState() {
    super.initState();
    // Fetch goals on first frame
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   context.read<GoalBloc>().add(const GoalEvent.getGoal());
    // });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UIInteractionCubit, UIState>(
      builder: (context, uiState) {
        final scale = uiState == UIState.sheetOpen ? 0.90 : 1.0;
        final offset = Offset(0, uiState == UIState.sheetOpen ? 0.01 : 0);
        final backgroundColor = uiState == UIState.sheetOpen
            ? AppColors.backgroundZaxis
            : AppColors.background;

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
                  top: uiState == UIState.sheetOpen
                      ? const Radius.circular(12)
                      : Radius.zero,
                ),
                child: PageTemplate(
                  backgroundColor: backgroundColor,
                  showBackArrow: false,
                  content: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Home", style: AppTextStyles.headingH2),
                        const Gap(24),
                        Row(
                          children: [
                            Text("Today", style: AppTextStyles.headingH4),
                            const Spacer(),
                            GestureDetector(
                              onTap: () {
                                showAppDialog(
                                  context: context,
                                  child: const AddGoalDialog(),
                                  title: "Create LOOP",
                                );
                              },
                              child: Icon(
                                Icons.add,
                                color: AppColors.brandFuchsiaPurple400,
                              ),
                            ),
                          ],
                        ),
                    
                        const Gap(16),
                        // Lottie.asset(
                        //   'assets/loop_loader_lottie.lottie', // Place your rotating icon image here
                        // ),
                        /// 🔥 BlocBuilder to show goals
                        BlocBuilder<GoalBloc, GoalState>(
                          builder: (context, state) {
                            return state.maybeWhen(
                              // loading: () => const Center(
                              //   child: CircularProgressIndicator(),
                              // ),
                              goalListLoaded: (goals) {
                                if (goals.isEmpty) {
                                  return const Text(
                                    "No goals yet. Start by creating one!",
                                    style: TextStyle(color: Colors.white54),
                                  );
                                }
                                return Column(
                                  children: goals.map((g) {
                                    return Container(
                                      margin: const EdgeInsets.only(bottom: 12),
                                      padding: const EdgeInsets.all(16),
                                      decoration: BoxDecoration(
                                        color: AppColors.backgroundZaxis,
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(g.title??"", style: AppTextStyles.headingH4),
                                          if (g.description != null && g.description!.isNotEmpty)
                                            Padding(
                                              padding: const EdgeInsets.only(top: 4),
                                              child: Text(g.description!,
                                                  style: AppTextStyles.paragraphMedium),
                                            ),
                                        ],
                                      ),
                                    );
                                  }).toList(),
                                );
                              },
                              error: (msg) => Text("Error: $msg", style: const TextStyle(color: Colors.red)),
                              orElse: () => const SizedBox.shrink(),
                            );
                          },
                        ),
                    
                    
                        const Gap(24),
                        GestureDetector(
                          onTap: () async {
                            final token =
                            await FirebaseAuth.instance.currentUser?.getIdToken();
                            log(token!);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: AppColors.primary,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            width: double.infinity,
                            height: 100,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}


// Widget _statusItem(String label, IconData icon, Color color) {
//   return ListTile(
//     leading: Icon(icon, color: color),
//     title: Text(label, style: const TextStyle(color: Colors.white)),
//     onTap: () {
//       // handle selection
//     },
//   );
// }
