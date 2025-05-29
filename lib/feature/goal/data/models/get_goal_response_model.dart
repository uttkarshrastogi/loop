// To parse this JSON data, do
//
//     final getGoalResponseModel = getGoalResponseModelFromJson(jsonString);

import 'dart:convert';

List<GetGoalResponseModel> getGoalResponseModelFromJson(String str) => List<GetGoalResponseModel>.from(json.decode(str).map((x) => GetGoalResponseModel.fromJson(x)));

String getGoalResponseModelToJson(List<GetGoalResponseModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetGoalResponseModel {
  String? id;
  String? userId;
  String? title;
  String? description;
  String? startDate;
  String? endDate;
  bool? active;
  String? createdAt;
  String? updatedAt;
  int? v;

  GetGoalResponseModel({
    this.id,
    this.userId,
    this.title,
    this.description,
    this.startDate,
    this.endDate,
    this.active,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  GetGoalResponseModel copyWith({
    String? id,
    String? userId,
    String? title,
    String? description,
    String? startDate,
    String? endDate,
    bool? active,
    String? createdAt,
    String? updatedAt,
    int? v,
  }) =>
      GetGoalResponseModel(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        title: title ?? this.title,
        description: description ?? this.description,
        startDate: startDate ?? this.startDate,
        endDate: endDate ?? this.endDate,
        active: active ?? this.active,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        v: v ?? this.v,
      );

  factory GetGoalResponseModel.fromJson(Map<String, dynamic> json) => GetGoalResponseModel(
    id: json["_id"],
    userId: json["userId"],
    title: json["title"],
    description: json["description"],
    startDate: json["startDate"],
    endDate: json["endDate"],
    active: json["active"],
    createdAt: json["createdAt"],
    updatedAt: json["updatedAt"],
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "userId": userId,
    "title": title,
    "description": description,
    "startDate": startDate,
    "endDate": endDate,
    "active": active,
    "createdAt": createdAt,
    "updatedAt": updatedAt,
    "__v": v,
  };
}
