import 'package:flutter/cupertino.dart';

import '../model/openai_model.dart';
import 'api_manager.dart';
class OpenAIService {


  Future<dynamic> generateLearningPlan({
    required String goal,
    required String deadline,
    required String routineDetails,
  }) async {
    try {
      final DateTime today = DateTime.now();
      final DateTime goalDeadline = DateTime.parse(deadline);
      final int daysRemaining = goalDeadline
          .difference(today)
          .inDays;

      String planStyle;
      if (daysRemaining <= 3) {
        planStyle =
        "Generate urgent fast-track tasks for each day. Tasks should be smaller but very focused.";
      } else if (daysRemaining <= 7) {
        planStyle = "Plan daily tasks, one for each day.";
      } else if (daysRemaining > 30) {
        planStyle = "Plan weekly milestones, with sub-tasks inside.";
      } else {
        planStyle = "Plan a mix of daily and weekly tasks.";
      }

      final prompt = '''
Today's date is ${today
          .toIso8601String()
          .split('T')
          .first}.
User wants to achieve "$goal" by $deadline.
There are approximately $daysRemaining days remaining.

$planStyle

- Title (clear and action-oriented)
- goalTitle (user's goal)
- Description (short but motivating explanation)
- Estimated Time (in hours)
-
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
        host: "firebase",
        // not used, but required
        requestName: "chat_completions",
        // not used, but required
        withToken: true,
        // sends Firebase token in Authorization header
        param: {
          "prompt": prompt,
        },
        urlVariables: {},
        disableLoader: false,
      );
      return OpenrouterModel.fromJson(response.data);
    } catch (e) {
      rethrow;
      debugPrint('Learning plan error: $e');
      throw Exception('Failed to generate learning plan: $e');
    }
  }
}