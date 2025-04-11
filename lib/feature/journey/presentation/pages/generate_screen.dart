import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:loop/core/theme/colors.dart';
import 'package:loop/core/theme/text_styles.dart';
import 'package:loop/core/widgets/template/page_template.dart';
import 'package:loop/feature/goal/data/models/create_goal_model.dart';
import 'package:loop/feature/user/data/models/user_routine_model.dart';
import 'package:loop/feature/journey/presentation/bloc/journey_bloc.dart';
import 'package:loop/feature/journey/presentation/bloc/journey_event.dart';
import 'package:loop/feature/journey/presentation/bloc/journey_state.dart';
import 'package:loop/feature/dashboard/presentation/pages/dashboard_page.dart';

import '../../../../core/widgets/globalLoader/bloc/bloc/loader_bloc.dart';


class GenerateScreen extends StatefulWidget {
  static const routeName = '/generate';

  final CreateGoalModel createGoalModel;
  final UserRoutineModel userRoutineModel;

  const GenerateScreen({
    super.key,
    required this.createGoalModel,
    required this.userRoutineModel,
  });

  @override
  State<GenerateScreen> createState() => _GenerateScreenState();
}

class _GenerateScreenState extends State<GenerateScreen> with SingleTickerProviderStateMixin {
  bool _hasTriggered = false;
  late AnimationController _animationController;
  int _currentTextIndex = 0;

  final List<String> _loadingTexts = [
    "Analyzing your goal",
    "Understanding your routine",
    "Generating your loop",
    "Breaking it down into tasks",
    "Aligning with your daily flow",
    "Finalizing your action plan"
  ];


  @override
  void initState() {
    super.initState();

    _triggerGenerate();
    // Initialize animation controller
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          _currentTextIndex = (_currentTextIndex + 1) % _loadingTexts.length;
        });
        _animationController.reset();
        _animationController.forward();
      }
    });

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _triggerGenerate() {
    if (_hasTriggered) return;
    _hasTriggered = true;

    context.read<JourneyBloc>().add(
      GeneratePlan(
        goalmodel: widget.createGoalModel,
        userRoutineModel: widget.userRoutineModel,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final LoaderBloc lBloc = GetIt.instance<LoaderBloc>();
    lBloc.add(const LoaderEvent.loadingOFF());
    return PageTemplate(
      title: 'Generating your plan...',
      showBackArrow: false,
      content: BlocListener<JourneyBloc, JourneyState>(
        listener: (context, state) {
          if (state is JourneyTasksLoaded) {
            Navigator.pushReplacementNamed(context, DashboardPage.routeName);
          } else if (state is JourneyError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Circular loader
              SizedBox(
                width: 120,
                height: 120,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Outer circle
                    Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.grey.withOpacity(0.2),
                          width: 4,
                        ),
                      ),
                    ),
                    // Animated progress circle
                    RotationTransition(
                      turns: Tween(begin: 0.0, end: 1.0).animate(_animationController),
                      child: CustomPaint(
                        size: const Size(120, 120),
                        painter: CircleProgressPainter(),
                      ),
                    ),
                    // Center icon
                    Container(
                      width: 60,
                      height: 60,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.brandFuchsiaPurple400, // Green color from screenshot
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.bar_chart,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              // Main text
              Text(
                _loadingTexts[_currentTextIndex],
                style: AppTextStyles.headingH5,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              // Subtext
              AnimatedOpacity(
                opacity: 1.0,
                duration: const Duration(milliseconds: 500),
                child: Text(
                  "Creating your task loop and\npersonalizing it to your goal...",
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Custom painter for the circular progress indicator
class CircleProgressPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    final paint = Paint()
      ..color = AppColors.brandFuchsiaPurple400 // Green color from screenshot
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round;

    // Draw arc (1/4 of the circle)
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -0.5 * 3.14159, // Start from top
      0.5 * 3.14159,  // 1/4 of the circle
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
