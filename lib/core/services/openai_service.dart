import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:loop/core/model/openai_model.dart';

import '../../../../core/services/api_manager.dart'; // Assuming apiCall() is here

class OpenAIService {
  Future<OpenaiModel> generateLearningPlan({
    required String goal,
    required String deadline,
    required String routineDetails,
  }) async {
    try {
      final prompt = '''
User wants to achieve $goal by $deadline. Their daily routine is: $routineDetails. 
Suggest a time-distributed, achievable learning plan broken into weekly or daily tasks. Each step should include:
- Title
- Description
- Duration in hours
- Source links (articles, docs,research papers) note: please verify the source links this is at the highest priority the links should work and not break you should 100 percent sure
Return JSON structured like [{ title, description, hours, source }]
''';

      final response = await apiCall(
        withToken: false,
        // customToken: {'Authorization': "Bearer sk-ZJRYCjOCqkMbwQ5nlQeOOw"},
        host: "mistral",
        requestName: "chat_completions",
        param: {
          'model': 'mistral',
          'prompt':prompt,
          "stream": false
        },
      );

      final content = response.data;
      print("response.data");

      return OpenaiModel.fromJson(content);
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
        customToken: {'Authorization': "Bearer sk-ZJRYCjOCqkMbwQ5nlQeOOw"},
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
