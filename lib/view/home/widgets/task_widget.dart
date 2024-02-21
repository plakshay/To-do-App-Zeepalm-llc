import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

///
import '../../../models/task.dart';
import '../../../utils/colors.dart';
import '../../../view/tasks/task_view.dart';

class TaskWidget extends StatefulWidget {
  final Task task;
  const TaskWidget({Key? key, required this.task}) : super(key: key);

  @override
  _TaskWidgetState createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  bool iscomplete = false;
  TextEditingController taskControllerForTitle = TextEditingController();
  TextEditingController taskControllerForSubtitle = TextEditingController();
  @override
  void initState() {
    super.initState();
    taskControllerForTitle.text = widget.task.title;
    taskControllerForSubtitle.text = widget.task.subtitle;
  }

  @override
  void dispose() {
    taskControllerForTitle.dispose();
    taskControllerForSubtitle.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("task widget is running great");
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          CupertinoPageRoute(
            builder: (ctx) => TaskView(
              taskControllerForTitle: taskControllerForTitle,
              taskControllerForSubtitle: taskControllerForSubtitle,
              task: widget.task,
            ),
          ),
        );
      },

      /// Main Card
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 600),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
            color: widget.task.isCompleted
                ? Color.fromARGB(169, 24, 26, 25)
                : Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(.1),
                  offset: const Offset(0, 4),
                  blurRadius: 10)
            ]),
        child: ListTile(
            leading: GestureDetector(
              onTap: () {
                widget.task.isCompleted = !widget.task.isCompleted;
                widget.task.save();
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 600),
                decoration: BoxDecoration(
                    color: widget.task.isCompleted
                        ? MyColors.primaryColor
                        : Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.grey, width: .8)),
                child: const Icon(
                  Icons.check,
                  color: Colors.white,
                ),
              ),
            ),
            title: Padding(
              padding: const EdgeInsets.only(bottom: 5, top: 3),
              child: Text(
                taskControllerForTitle.text,
                style: TextStyle(
                    color: widget.task.isCompleted
                        ? MyColors.primaryColor
                        : Colors.black,
                    fontWeight: FontWeight.w500,
                    decoration: widget.task.isCompleted
                        ? TextDecoration.lineThrough
                        : null),
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  taskControllerForSubtitle.text,
                  style: TextStyle(
                    color: widget.task.isCompleted
                        ? MyColors.primaryColor
                        : const Color.fromARGB(255, 164, 164, 164),
                    fontWeight: FontWeight.w300,
                    decoration: widget.task.isCompleted
                        ? TextDecoration.lineThrough
                        : null,
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      bottom: 10,
                      top: 10,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          DateFormat('hh:mm a')
                              .format(widget.task.createdAtTime),
                          style: TextStyle(
                              fontSize: 14,
                              color: widget.task.isCompleted
                                  ? Colors.white
                                  : Colors.grey),
                        ),
                        Text(
                          DateFormat.yMMMEd().format(widget.task.createdAtDate),
                          style: TextStyle(
                              fontSize: 12,
                              color: widget.task.isCompleted
                                  ? Colors.white
                                  : Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
