// import 'package:flutter/material.dart';

class Task {
  String? id;
  String? title;
  String? description;
  String? insert;
  DateTime? date;
  bool? isalarm;
  int? idalarm;
  int? length;
  bool? isnull = true;

  Task(
      {this.id,
      this.title,
      this.description,
      this.insert,
      this.date,
      this.isalarm,
      this.idalarm,
      this.length,
      this.isnull});
}
