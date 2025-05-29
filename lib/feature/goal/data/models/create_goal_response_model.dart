// To parse this JSON data, do
//
//     final createGoalResponseModel = createGoalResponseModelFromJson(jsonString);

import 'dart:convert';

CreateGoalResponseModel createGoalResponseModelFromJson(String str) => CreateGoalResponseModel.fromJson(json.decode(str));

String createGoalResponseModelToJson(CreateGoalResponseModel data) => json.encode(data.toJson());

class CreateGoalResponseModel {
  String? userId;
  String? title;
  String? description;
  String? startDate;
  String? endDate;
  bool? active;
  String? id;
  String? createdAt;
  String? updatedAt;
  int? v;

  CreateGoalResponseModel({
    this.userId,
    this.title,
    this.description,
    this.startDate,
    this.endDate,
    this.active,
    this.id,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  CreateGoalResponseModel copyWith({
    String? userId,
    String? title,
    String? description,
    String? startDate,
    String? endDate,
    bool? active,
    String? id,
    String? createdAt,
    String? updatedAt,
    int? v,
  }) =>
      CreateGoalResponseModel(
        userId: userId ?? this.userId,
        title: title ?? this.title,
        description: description ?? this.description,
        startDate: startDate ?? this.startDate,
        endDate: endDate ?? this.endDate,
        active: active ?? this.active,
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        v: v ?? this.v,
      );

  factory CreateGoalResponseModel.fromJson(Map<String, dynamic> json) => CreateGoalResponseModel(
    userId: json["userId"],
    title: json["title"],
    description: json["description"],
    startDate: json["startDate"],
    endDate: json["endDate"],
    active: json["active"],
    id: json["_id"],
    createdAt: json["createdAt"],
    updatedAt: json["updatedAt"],
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "title": title,
    "description": description,
    "startDate": startDate,
    "endDate": endDate,
    "active": active,
    "_id": id,
    "createdAt": createdAt,
    "updatedAt": updatedAt,
    "__v": v,
  };
}
