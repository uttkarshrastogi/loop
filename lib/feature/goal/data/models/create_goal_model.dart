
import 'dart:convert';

CreateGoalModel createGoalModelFromJson(String str) => CreateGoalModel.fromJson(json.decode(str));

String createGoalModelToJson(CreateGoalModel data) => json.encode(data.toJson());

class CreateGoalModel {
  String? title;
  String? description;
  String? startDate;
  String? endDate;

  CreateGoalModel({
    this.title,
    this.description,
    this.startDate,
    this.endDate,
  });

  CreateGoalModel copyWith({
    String? title,
    String? description,
    String? startDate,
    String? endDate,
  }) =>
      CreateGoalModel(
        title: title ?? this.title,
        description: description ?? this.description,
        startDate: startDate ?? this.startDate,
        endDate: endDate ?? this.endDate,
      );

  factory CreateGoalModel.fromJson(Map<String, dynamic> json) => CreateGoalModel(
    title: json["title"],
    description: json["description"],
    startDate: json["startDate"],
    endDate: json["endDate"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "description": description,
    "startDate": startDate,
    "endDate": endDate,
  };
}
