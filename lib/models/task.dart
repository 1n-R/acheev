import 'package:acheev/constants/colors.dart';
import 'package:flutter/material.dart';

class Task {
  IconData? iconData;
  String? title;
  Color? bgColor;
  Color? iconColor;
  Color? btnColor;
  num? notes;
  num? done;
  bool isLast;
  Task(
      {this.iconData,
      this.title,
      this.bgColor,
      this.iconColor,
      this.btnColor,
      this.notes,
      this.done,
      this.isLast = false});
  static List<Task> generateTasks() {
    return [
      Task(
        iconData: Icons.person_rounded,
        title: 'Task',
        bgColor: kYellowLight,
        iconColor: kYellowDark,
        btnColor: kYellow,
        notes: 6,
      ),
      Task(
        iconData: Icons.cases_rounded,
        title: 'Organization',
        bgColor: kRedLight,
        iconColor: kRedDark,
        btnColor: kRed,
        notes: 4,
      ),
      Task(
        iconData: Icons.favorite_rounded,
        title: 'Hobby',
        bgColor: kBlueLight,
        iconColor: kBlueDark,
        btnColor: kBlue,
        notes: 7,
      ),
      Task(
        iconData: Icons.audiotrack,
        title: 'Project',
        bgColor: kBlueLight,
        iconColor: kBlueDark,
        btnColor: kBlue,
        notes: 8,
      ),
    ];
  }
}
