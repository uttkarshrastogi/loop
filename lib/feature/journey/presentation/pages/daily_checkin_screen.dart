import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:loop/core/theme/colors.dart';
import 'package:loop/core/theme/text_styles.dart';
import 'package:loop/core/widgets/buttons/appbutton.dart';
import 'package:loop/core/widgets/template/page_template.dart';
import 'package:loop/feature/journey/presentation/bloc/journey_bloc.dart';
import 'package:loop/feature/journey/presentation/bloc/journey_event.dart';
import 'package:loop/feature/journey/presentation/bloc/journey_state.dart';


import '../../../../core/services/openai_service.dart';
import '../../../ai/data/models/ai_generated_task_model.dart';
import '../../data/datasources/ai_planner_service.dart';

class DailyCheckInScreen extends StatefulWidget {
  static const String routeName = '/daily-checkin';
  
  final Map<String, dynamic>? arguments;
  
  const DailyCheckInScreen({Key? key, this.arguments}) : super(key: key);

  @override
  State<DailyCheckInScreen> createState() => _DailyCheckInScreenState();
}

class _DailyCheckInScreenState extends State<DailyCheckInScreen> {
  String? _goalId;
  bool _isLoading = false;
  String _selectedFeedback = '';
  final TextEditingController _customFeedbackController = TextEditingController();
  
  final List<String> _feedbackOptions = [
    'Too much work today',
    'Tasks were too difficult',
    'Tasks were too easy',
    'Perfect amount of challenge',
    'Need more resources',
    'Need more time',
  ];
  
  Map<String, dynamic>? _aiResponse;
  
  @override
  void initState() {
    super.initState();
    if (widget.arguments != null && widget.arguments!.containsKey('goalId')) {
      _goalId = widget.arguments!['goalId'];
      _loadTodayTasks();
    }
  }
  
  @override
  void dispose() {
    _customFeedbackController.dispose();
    super.dispose();
  }
  
  void _loadTodayTasks() {
    context.read<JourneyBloc>().add(LoadTodayTasks());
  }
  
  Future<void> _submitFeedback() async {
    if (_selectedFeedback.isEmpty && _customFeedbackController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select or enter feedback')),
      );
      return;
    }
    
    setState(() {
      _isLoading = true;
    });
    
    try {
      final feedback = _selectedFeedback.isNotEmpty
          ? _selectedFeedback
          : _customFeedbackController.text;
      
      final progress = _calculateProgress();
      
      if (_goalId != null) {
        final aiPlannerService = AIPlannerService(
          openAIService: context.read<OpenAIService>(),
        );
        
        final response = await aiPlannerService.generateFeedback(
          goalId: _goalId!,
          progress: progress,
          userFeedback: feedback,
        );
        
        setState(() {
          _aiResponse = response;
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error generating feedback: $e')),
      );
    }
  }
  
  String _calculateProgress() {
    // In a real implementation, this would calculate the actual progress
    // based on completed tasks, etc.
    return 'Completed 2 out of 5 tasks for today';
  }

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      mascot: Image.asset(
        "assets/loop_mascot_hi.png",
        height: MediaQuery.of(context).size.height/6,
      ),
      title: 'Daily Check-in',
      showBackArrow: true,
      content: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'How was your day?',
                style: AppTextStyles.headingH2,
              ),
              const Gap(8),
              Text(
                'Your feedback helps us adjust your learning plan.',
                style: AppTextStyles.paragraphMedium.copyWith(color: AppColors.grey),
              ),
              const Gap(32),
              
              // Today's tasks
              Text(
                'Today\'s Plan',
                style: AppTextStyles.headingH4,
              ),
              const Gap(16),
              BlocBuilder<JourneyBloc, JourneyState>(
                builder: (context, state) {
                  if (state is JourneyLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  
                  if (state is JourneyTodayTasksLoaded) {
                    return _buildTodayTasks(state.tasks);
                  }
                  
                  return const Center(
                    child: Text('No tasks for today'),
                  );
                },
              ),
              const Gap(32),
              
              // Feedback options
              Text(
                'How did you find today\'s tasks?',
                style: AppTextStyles.headingH4,
              ),
              const Gap(16),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: _feedbackOptions.map((option) {
                  final isSelected = _selectedFeedback == option;
                  
                  return ChoiceChip(
                    label: Text(option),
                    selected: isSelected,
                    onSelected: (selected) {
                      setState(() {
                        _selectedFeedback = selected ? option : '';
                      });
                    },
                  );
                }).toList(),
              ),
              const Gap(24),
              
              // Custom feedback
              Text(
                'Or add your own feedback:',
                style: AppTextStyles.paragraphMedium,
              ),
              const Gap(8),
              TextField(
                controller: _customFeedbackController,
                decoration: const InputDecoration(
                  hintText: 'Enter your feedback here...',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    setState(() {
                      _selectedFeedback = '';
                    });
                  }
                },
              ),
              const Gap(32),
              
              // Submit button
              AppButton(
                text: 'Submit Feedback',
                // isLoading: _isLoading,
                onPressed: _submitFeedback,
              ),
              const Gap(32),
              
              // AI Response
              if (_aiResponse != null) ...[
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'AI Feedback',
                        style: AppTextStyles.headingH4,
                      ),
                      const Gap(16),
                      Text(
                        'Encouragement:',
                        style: AppTextStyles.headingH5,
                      ),
                      const Gap(4),
                      Text(
                        _aiResponse!['encouragement'] ?? 'Keep up the good work!',
                        style: AppTextStyles.paragraphMedium,
                      ),
                      const Gap(16),
                      Text(
                        'Adjustments:',
                        style: AppTextStyles.headingH5,
                      ),
                      const Gap(4),
                      Text(
                        _aiResponse!['adjustments'] ?? 'No adjustments needed at this time.',
                        style: AppTextStyles.paragraphMedium,
                      ),
                      const Gap(16),
                      Text(
                        'Next Steps:',
                        style: AppTextStyles.headingH5,
                      ),
                      const Gap(4),
                      Text(
                        _aiResponse!['nextSteps'] ?? 'Continue with your current plan.',
                        style: AppTextStyles.paragraphMedium,
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
  
  Widget _buildTodayTasks(List<AiGeneratedTaskModel> tasks) {
    if (tasks.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.lightGrey,
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Center(
          child: Text('No tasks scheduled for today'),
        ),
      );
    }
    
    return Column(
      children: tasks.map((task) => _buildTaskItem(task)).toList(),
    );
  }
  
  Widget _buildTaskItem(AiGeneratedTaskModel task) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.lightGrey,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: task.isCompleted
              ? AppColors.success
              : task.isSkipped
                  ? AppColors.error
                  : Colors.transparent,
        ),
      ),
      child: Row(
        children: [
          _buildStatusIcon(task),
          const Gap(12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  task.title,
                  style: AppTextStyles.paragraphMedium.copyWith(
                    fontWeight: FontWeight.bold,
                    decoration: task.isCompleted || task.isSkipped
                        ? TextDecoration.lineThrough
                        : null,
                  ),
                ),
                const Gap(4),
                Text(
                  '${task.estimatedHours} hours',
                  style: AppTextStyles.paragraphSmall.copyWith(
                    color: AppColors.grey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildStatusIcon(AiGeneratedTaskModel task) {
    if (task.isCompleted) {
      return const CircleAvatar(
        radius: 12,
        backgroundColor: AppColors.success,
        child: Icon(
          Icons.check,
          size: 16,
          color: Colors.white,
        ),
      );
    }
    
    if (task.isSkipped) {
      return const CircleAvatar(
        radius: 12,
        backgroundColor: AppColors.error,
        child: Icon(
          Icons.close,
          size: 16,
          color: Colors.white,
        ),
      );
    }
    
    return const CircleAvatar(
      radius: 12,
      backgroundColor: AppColors.grey,
      child: Icon(
        Icons.schedule,
        size: 16,
        color: Colors.white,
      ),
    );
  }
}
