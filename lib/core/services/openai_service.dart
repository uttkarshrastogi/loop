import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:loop/core/model/openai_model.dart';

import '../../../../core/services/api_manager.dart'; // Assuming apiCall() is here

class OpenAIService {

  final String _apiKey = dotenv.env['OPENAI_API_KEY'] ?? '';

  Future<OpenrouterModel> generateLearningPlan({
    required String goal,
    required String deadline,
    required String routineDetails,
  }) async {

    try {
      final DateTime today = DateTime.now();
      final DateTime goalDeadline = DateTime.parse(deadline); // deadline you got from user
      final int daysRemaining = goalDeadline.difference(today).inDays;

      String planStyle;
      if (daysRemaining <= 3) {
        planStyle = "Generate urgent fast-track tasks for each day. Tasks should be smaller but very focused.";
      } else if (daysRemaining <= 7) {
        planStyle = "Plan daily tasks, one for each day.";
      } else if (daysRemaining > 30) {
        planStyle = "Plan weekly milestones, with sub-tasks inside.";
      } else {
        planStyle = "Plan a mix of daily and weekly tasks.";
      }

      final prompt = '''
Today's date is ${today.toIso8601String().split('T').first}.
User wants to achieve "$goal" by $deadline.
There are approximately $daysRemaining days remaining.

$planStyle

- Title (clear and action-oriented)
- Description (short but motivating explanation)
- Estimated Time (in hours)
- 2–4 Sub-Steps (tiny actionable points to achieve the task)
- Difficulty Level ("Easy", "Medium", or "Hard")
- Motivation Tip (1-2 lines of encouragement related to the task)
- Expected Outcome (What user will achieve after completing this task)
- Verified Source Links (only working URLs: articles, research papers, docs; please verify carefully)
- Bonus Reward (optional small reward user can imagine earning after the task, like "Unlock your next milestone" or "Celebrate with a 5-min break")

IMPORTANT:
- Return only valid JSON inside Markdown triple backticks like ```json
- Example structure: [{ title, description, hours, subSteps, difficulty, motivationTip, outcome, source, reward }]
- Double-check that the sources are reliable and live (NOT broken links). This is the HIGHEST priority.

Keep the tone positive and slightly energetic, suitable for 12–40 age group audiences.

Return only the JSON array.

''';

      final response = await apiCall(
        customToken: {'Authorization': "Bearer $_apiKey"},
        host: "open-router",
        requestName: "chat_completions",
        param: {
          'model': 'openai/gpt-3.5-turbo',
          'prompt':prompt,
          "stream": false
        },
      );

      final content = response.data;
      return OpenrouterModel.fromJson(content);
    } catch (e) {
      rethrow;
      debugPrint('Learning plan error: $e');
      throw Exception('Failed to generate learning plan: $e');
    }
  }

  Future<Map<String, dynamic>> generateFeedback({
    required String goal,
    required String progress,
    required String feedback,
  }) async {
    try {
      final prompt = '''
User is working on the goal: $goal
Their progress so far: $progress
Their feedback on the plan: $feedback

Provide:
1. Encouragement based on their progress
2. Adjustments to make the plan more suitable
3. Specific next steps to focus on

Return JSON structured like { "encouragement": "...", "adjustments": "...", "nextSteps": "..." }
''';

      final response = await apiCall(
        customToken: {'Authorization': "Bearer $_apiKey"},
        host: "ai",
        requestName: "chat_completions",
        param: {
          'model': 'gpt-4-turbo',
          'messages': [
            {
              'role': 'system',
              'content':
                  'You are an AI assistant that provides personalized feedback on learning progress. Return only valid JSON without any additional text.',
            },
            {'role': 'user', 'content': prompt},
          ],
          'temperature': 0.7,
        },
      );

      final content = response.data['choices'][0]['message']['content'];

      String jsonStr = content;
      if (content.contains('```json')) {
        jsonStr = content.split('```json')[1].split('```')[0].trim();
      } else if (content.contains('```')) {
        jsonStr = content.split('```')[1].split('```')[0].trim();
      }

      return Map<String, dynamic>.from(json.decode(jsonStr));
    } catch (e) {
      debugPrint('Feedback generation error: $e');
      throw Exception('Failed to generate feedback: $e');
    }
  }
}
