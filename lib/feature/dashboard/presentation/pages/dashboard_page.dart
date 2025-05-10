import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:loop/core/theme/colors.dart';
import 'package:loop/core/theme/theme_switch.dart';
import 'package:loop/core/widgets/template/page_template.dart';
import 'package:loop/feature/auth/presentation/bloc/auth_bloc.dart';
import 'package:loop/core/uiBloc/uiInteraction/ui_interaction_cubit.dart';
import 'package:loop/feature/dashboard/presentation/widgets/all_goals_widget.dart';
import 'package:loop/feature/journey/presentation/bloc/journey_bloc.dart';
import 'package:loop/feature/journey/presentation/bloc/journey_state.dart';
import '../../../journey/presentation/bloc/journey_event.dart';
import '../widgets/dashboard_header.dart';
import '../widgets/today_loop_widget.dart';

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
  String? _currentGoalId;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<JourneyBloc>().add(const JourneyEvent.loadAllGoals());
    });
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
            uiState == UIState.sheetOpen
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
                  top:
                      uiState == UIState.sheetOpen
                          ? const Radius.circular(12)
                          : Radius.zero,
                ),
                child: PageTemplate(
                  padding: EdgeInsets.all(0),
                  backgroundColor: backgroundColor,
                  showBackArrow: false,
                  content: Column(
                    children: [
                      // DashboardHeader(
                      //   userName: 'Daniel',
                      //   growthPercent: 15.0,
                      //   bestResult: '5/5 Tasks',
                      // ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ThemeSwitch(),
                          IconButton(
                            onPressed: () {
                              context.read<AuthBloc>().add(
                                const AuthEvent.signOut(),
                              );
                            },
                            icon: Icon(
                              Icons.logout_rounded,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                      TabBar(
                        splashFactory: NoSplash.splashFactory,
                        overlayColor: MaterialStateProperty.all(
                          Colors.transparent,
                        ),
                        controller: _tabController,
                        labelColor: AppColors.brandPurple,
                        unselectedLabelColor: AppColors.textSecondary,
                        indicator: BoxDecoration(
                          color: AppColors.brandPurple.withOpacity(
                            0.1,
                          ),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        tabs: const [
                          Tab(child: Center(child: Text("Goal"))),
                          Tab(child: Center(child: Text("LOOP"))),
                        ],
                      ),
                      const Gap(16),
                      Expanded(
                        child: TabBarView(
                          controller: _tabController,
                          children: [
                            const AllGoalsWidget(),
                            AllGoalsWidgetV2(),
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
}
