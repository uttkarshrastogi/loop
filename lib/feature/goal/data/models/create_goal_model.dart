import 'dart:convert';

CreateGoalModel createGoalModelFromJson(String str) => CreateGoalModel.fromJson(json.decode(str));
String createGoalModelToJson(CreateGoalModel data) => json.encode(data.toJson());

class CreateGoalModel {
  String? title;
  String? description;
  String? startDate;
  String? endDate;
  String? priority;
  String? difficulty;
  List<String>? frequency;

  CreateGoalModel({
    this.title,
    this.description,
    this.startDate,
    this.endDate,
    this.priority,
    this.difficulty,
    this.frequency,
  });

  CreateGoalModel copyWith({
    String? title,
    String? description,
    String? startDate,
    String? endDate,
    String? priority,
    String? difficulty,
    List<String>? frequency,
  }) =>
      CreateGoalModel(
        title: title ?? this.title,
        description: description ?? this.description,
        startDate: startDate ?? this.startDate,
        endDate: endDate ?? this.endDate,
        priority: priority ?? this.priority,
        difficulty: difficulty ?? this.difficulty,
        frequency: frequency ?? this.frequency,
      );

  factory CreateGoalModel.fromJson(Map<String, dynamic> json) => CreateGoalModel(
    title: json["title"],
    description: json["description"],
    startDate: json["startDate"],
    endDate: json["endDate"],
    priority: json["priority"],
    difficulty: json["difficulty"],
    frequency: json["frequency"] != null ? List<String>.from(json["frequency"]) : null,
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "description": description,
    "startDate": startDate,
    "endDate": endDate,
    "priority": priority,
    "difficulty": difficulty,
    "frequency": frequency,
  };
}
