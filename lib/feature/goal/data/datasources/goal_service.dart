import 'package:dio/dio.dart';
import 'package:loop/feature/goal/data/models/create_goal_model.dart';
import 'package:loop/feature/goal/data/models/create_goal_response_model.dart';
import 'package:loop/feature/goal/data/models/get_goal_response_model.dart';

import '../../../../core/services/api_manager.dart';

class GoalService {
  Future<CreateGoalResponseModel> createGoal(CreateGoalModel createGoalModel) async {
    try {
      final response = await apiCall(
        host: "render",
        requestName: 'create_goal',
        param: createGoalModel.toJson(),
      );
      return CreateGoalResponseModel.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception('${e.error}');
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<List<GetGoalResponseModel>> getGoal() async {
    try {
      final response = await apiCall(
        host: "render",
        requestName: 'get_goal',
      );
      final List<dynamic> data = response.data ?? [];
      return data
          .map((item) => GetGoalResponseModel.fromJson(item))
          .toList();
    } on DioException catch (e) {
      rethrow;
      throw Exception('${e.error}');
    } catch (e) {
      rethrow;
      throw Exception(e.toString());
    }
  }

  Future<CreateGoalResponseModel> updateGoal(String goalId, Map<String, dynamic> data) async {
    try {
      final response = await apiCall(
        host: "render",
        requestName: 'update_goal',
        urlVariables: {'goal_id': goalId},
        param: data,
      );
      return CreateGoalResponseModel.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception('${e.error}');
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> deleteGoal(String goalId) async {
    try {
      await apiCall(
        host: "render",
        requestName: 'delete_goal',
        urlVariables: {'goal_id': goalId},
      );
    } on DioException catch (e) {
      throw Exception('${e.error}');
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
