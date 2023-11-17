// To parse this JSON data, do
//
//     final getnotesmodel = getnotesmodelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

Getnotesmodel getnotesmodelFromJson(String str) => Getnotesmodel.fromJson(json.decode(str));

String getnotesmodelToJson(Getnotesmodel data) => json.encode(data.toJson());

class Getnotesmodel {
  final int id;
  final int userId;
  final String title;
  final String description;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int isDeleted;

  Getnotesmodel({
    required this.id,
    required this.userId,
    required this.title,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
    required this.isDeleted,
  });

  Getnotesmodel copyWith({
    int? id,
    int? userId,
    String? title,
    String? description,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? isDeleted,
  }) =>
      Getnotesmodel(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        title: title ?? this.title,
        description: description ?? this.description,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        isDeleted: isDeleted ?? this.isDeleted,
      );

  factory Getnotesmodel.fromJson(Map<String, dynamic> json) => Getnotesmodel(
    id: json["id"],
    userId: json["user_id"],
    title: json["title"],
    description: json["description"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    isDeleted: json["is_deleted"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "title": title,
    "description": description,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "is_deleted": isDeleted,
  };
}
