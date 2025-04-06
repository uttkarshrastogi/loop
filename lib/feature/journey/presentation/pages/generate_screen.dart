import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loop/core/theme/text_styles.dart';
import 'package:loop/core/widgets/template/page_template.dart';
import 'package:loop/core/widgets/buttons/appbutton.dart';
import 'package:loop/feature/goal/data/models/create_goal_model.dart';
import 'package:loop/feature/user/data/models/user_routine_model.dart';
import 'package:loop/feature/journey/presentation/bloc/journey_bloc.dart';
import 'package:loop/feature/journey/presentation/bloc/journey_event.dart';
import 'package:loop/feature/journey/presentation/bloc/journey_state.dart';
import 'package:loop/feature/dashboard/presentation/pages/dashboard_page.dart';

import '../../../../core/routes/index.dart'; // adjust path as needed

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

class _GenerateScreenState extends State<GenerateScreen> {
  bool _hasTriggered = false;

  @override
  void initState() {
    super.initState();
    _triggerGenerate();
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
          child: Container(
            child: Padding(
              padding: const EdgeInsets.only(top: 50.0),
              child: Text("Generating....",style: AppTextStyles.headingH5,),
            ),
          ),
        ),
      ),
    );
  }
}
