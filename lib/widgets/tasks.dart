import 'package:acheev/models/task.dart';
import 'package:flutter/material.dart';
// import 'package:dotted_border/dotted_border.dart';

class Tasks extends StatelessWidget {
  final tasksList = Task.generateTasks();

  Tasks({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: GridView.builder(
          itemCount: tasksList.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, crossAxisSpacing: 10, mainAxisSpacing: 10),
          itemBuilder: (context, index) =>
              _buildTask(context, tasksList[index])),
    );
  }

  Widget _buildTask(BuildContext context, Task task) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
          color: task.bgColor, borderRadius: BorderRadius.circular(20)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    task.iconData,
                    color: task.iconColor,
                    size: 35,
                  ),
                  const Icon(
                    Icons.more_vert,
                    color: Colors.black,
                    size: 25,
                  )
                ],
              ),
              // const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    task.title.toString(),
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],
          ),
          // const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              _buildTaskStatus(
                  task.btnColor!, task.iconColor!, '${task.notes} notes'),
              // const SizedBox(width: 15),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildTaskStatus(Color bgColor, Color txColor, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
          color: bgColor, borderRadius: BorderRadius.circular(20)),
      child: Text(
        text,
        style: TextStyle(color: txColor),
      ),
    );
  }
}
