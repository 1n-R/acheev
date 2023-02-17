import 'package:flutter/material.dart';

class Task {
  String? id;
  IconData? iconData;
  String? title;
  Color? bgColor;
  Color? iconColor;
  num? notes;

  Task({
    this.id,
    this.iconData,
    this.title,
    this.bgColor,
    this.iconColor,
    this.notes,
  });
}
