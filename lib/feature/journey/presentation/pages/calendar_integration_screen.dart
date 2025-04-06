import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:loop/core/theme/colors.dart';
import 'package:loop/core/theme/text_styles.dart';
import 'package:loop/core/widgets/buttons/appbutton.dart';
import 'package:loop/core/widgets/template/page_template.dart';
import 'package:loop/feature/goal/data/models/create_goal_model.dart';
import 'package:loop/feature/journey/presentation/pages/generate_screen.dart';
import 'package:loop/feature/user/data/models/user_routine_model.dart';

class CalendarIntegrationScreen extends StatefulWidget {
  static const String routeName = '/calendar-integration';

    final CreateGoalModel createGoalModel;
  final UserRoutineModel userRoutineModel;

  const CalendarIntegrationScreen({Key? key, required this.createGoalModel, required this.userRoutineModel}) : super(key: key);

  @override
  State<CalendarIntegrationScreen> createState() =>
      _CalendarIntegrationScreenState();
}

class _CalendarIntegrationScreenState extends State<CalendarIntegrationScreen> {
  bool _isLoading = false;
  bool _isConnected = false;
  String _statusMessage = '';
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'https://www.googleapis.com/auth/calendar',
      'https://www.googleapis.com/auth/calendar.events',
    ],
  );

  @override
  void initState() {
    super.initState();

    _checkGoogleSignIn();
  }

  Future<void> _checkGoogleSignIn() async {
    try {
      final account = await _googleSignIn.signIn();
      final isSignedIn = await _googleSignIn.isSignedIn();
      setState(() {
        _isConnected = isSignedIn;
        _statusMessage =
            isSignedIn
                ? 'Connected to Google Calendar as ${account?.email}'
                : 'Not connected to Google Calendar';
      });
    } catch (e) {
      setState(() {
        _statusMessage = 'Error checking Google Sign-In status: \$e';
      });
    }
  }

  Future<void> _connectGoogleCalendar() async {
    setState(() {
      _isLoading = true;
      _statusMessage = 'Connecting to Google Calendar...';
    });

    try {
      final account = await _googleSignIn.signIn();

      if (account != null) {
        setState(() {
          _isConnected = true;

          _statusMessage = 'Connected to Google Calendar as ${account.email}';
        });
      } else {
        setState(() {
          _statusMessage = 'Google Sign-In cancelled';
        });
      }
    } catch (e) {
      setState(() {
        _statusMessage = 'Error connecting to Google Calendar: \$e';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _disconnectGoogleCalendar() async {
    setState(() {
      _isLoading = true;
      _statusMessage = 'Disconnecting from Google Calendar...';
    });

    try {
      await _googleSignIn.signOut();
      setState(() {
        _isConnected = false;
        _statusMessage = 'Disconnected from Google Calendar';
      });
    } catch (e) {
      setState(() {
        _statusMessage = 'Error disconnecting from Google Calendar: \$e';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _continueToJourney() {
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder:
    //         (context) => TodoJourneyScreen(
    //           createGoalModel: widget.createGoalModel,userRoutineModel:widget.userRoutineModel ,
    //         ),
    //   ),
    // );
    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (context) =>
                GenerateScreen(
              createGoalModel: widget.createGoalModel,userRoutineModel:widget.userRoutineModel ,
            ),
      ),
    );
    // context.push(
    //   TodoJourneyScreen.routeName,
    //   extra: {'goalId': 'temp-goal-id'},
    // );
  }

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      mascot: Image.asset(
        "assets/loop_mascot_calendar.png",
        height: MediaQuery.of(context).size.height/8,
      ),
      showBottomGradient:true ,
      title: 'Calendar Integration',
      showBackArrow: false,
      content: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Gap(80),
          Text('Sync your calendar', style: AppTextStyles.headingH5),
          const Gap(4),
          Text(
            'Connect your Google Calendar to find the best times for your learning activities.',
            style: AppTextStyles.paragraphXSmall.copyWith(
              color: AppColors.surface,
            ),
          ),
          const Gap(32),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color:
                  _isConnected
                      ? AppColors.success.withOpacity(0.1)
                      : AppColors.greyButton,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Icon(
                  _isConnected ? Icons.check_circle : Icons.info_outline,
                  color:
                      _isConnected
                          ? AppColors.success
                          : AppColors.greyButton,
                ),
                const Gap(16),
                Expanded(
                  child: Text(
                    _statusMessage,
                    style: AppTextStyles.paragraphXSmall,
                  ),
                ),
              ],
            ),
          ),
          const Gap(22),
          Text(
            'Benefits of calendar integration:',
            style: AppTextStyles.headingH5,
          ),
          const Gap(16),
          _buildBenefitItem(
            icon: Icons.schedule,
            title: 'Find available time slots',
            description:
                'We\'ll analyze your calendar to find the best times for learning.',
          ),
          const Gap(16),
          _buildBenefitItem(
            icon: Icons.event_available,
            title: 'Avoid scheduling conflicts',
            description:
                'Your learning plan will work around your existing commitments.',
          ),
          const Gap(16),
          _buildBenefitItem(
            icon: Icons.sync,
            title: 'Keep everything in sync',
            description:
                'Learning tasks can be added to your calendar automatically.',
          ),
          const Gap(28),
          if (_isConnected)
            AppButton(
              text: 'Disconnect Calendar',
              // isLoading: _isLoading,
              // buttonType: AppButtonType.secondary,
              onPressed: _disconnectGoogleCalendar,
            )
          else
            AppButton(
              // backGroundColor: AppColors.brandFuchsiaPurple400,
              text: 'Connect Google Calendar',
              // isLoading: _isLoading,
              onPressed: _connectGoogleCalendar,
            ),
          const Gap(16),
          AppButton(
            backGroundColor: AppColors.brandFuchsiaPurple400,
            text: 'Continue with Calendar',
            // buttonType: _isConnected ? AppButtonType.primary : AppButtonType.secondary,
            onPressed: _continueToJourney,
          ),
          Gap(60),
        ],
      ),
    );
  }

  Widget _buildBenefitItem({
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.brandFuchsiaPurple400.withOpacity(0.2),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: AppColors.brandFuchsiaPurple400, size: 24),
        ),
        const Gap(16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: AppTextStyles.paragraphSmall),
              const Gap(4),
              Text(
                description,
                style: AppTextStyles.paragraphXSmall
              ),
            ],
          ),
        ),
      ],
    );
  }
}
