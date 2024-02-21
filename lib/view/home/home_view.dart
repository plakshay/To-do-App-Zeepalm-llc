// ignore_for_file: must_be_immutable

import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';

///
import '../../main.dart';
import '../../models/task.dart';
import '../../utils/colors.dart';
import '../../utils/constanst.dart';
import '../../view/home/widgets/task_widget.dart';
import '../../view/tasks/task_view.dart';
import '../../utils/strings.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  GlobalKey<SliderDrawerState> dKey = GlobalKey<SliderDrawerState>();

  int checkDoneTask(List<Task> task) {
    int i = 0;
    for (Task doneTasks in task) {
      if (doneTasks.isCompleted) {
        i++;
      }
    }
    return i;
  }

  dynamic valueOfTheIndicator(List<Task> task) {
    if (task.isNotEmpty) {
      return task.length;
    } else {
      return 3;
    }
  }

  @override
  Widget build(BuildContext context) {
    final base = BaseWidget.of(context);
    var textTheme = Theme.of(context).textTheme;

    return ValueListenableBuilder(
        valueListenable: base.dataStore.listenToTask(),
        builder: (ctx, Box<Task> box, Widget? child) {
          var tasks = box.values.toList();

          /// Sort Task List
          tasks.sort(((a, b) => a.createdAtDate.compareTo(b.createdAtDate)));

          return Scaffold(
            backgroundColor: Colors.white,
            floatingActionButton: const FAB(),
            body: SliderDrawer(
              isDraggable: false,
              key: dKey,
              animationDuration: 1000,
              appBar: MyAppBar(
                drawerKey: dKey,
              ),
              slider: MySlider(),
              child: _buildBody(
                tasks,
                base,
                textTheme,
              ),
            ),
          );
        });
  }

  Container _buildBody(
    List<Task> tasks,
    BaseWidget base,
    TextTheme textTheme,
  ) {
    return Container(
      color: Colors.black87,
      width: double.infinity,
      height: double.infinity,
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.fromLTRB(55, 0, 0, 0),
            width: double.infinity,
            height: 100,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 25,
                  height: 25,
                  child: CircularProgressIndicator(
                    valueColor:
                        const AlwaysStoppedAnimation(MyColors.primaryColor),
                    backgroundColor: Colors.grey,
                    value: checkDoneTask(tasks) / valueOfTheIndicator(tasks),
                  ),
                ),
                const SizedBox(
                  width: 25,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Task Done",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        )),
                    const SizedBox(
                      height: 3,
                    ),
                    Text("${checkDoneTask(tasks)} of ${tasks.length} task",
                        style: textTheme.subtitle1),
                  ],
                )
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(
              top: 10,
            ),
            child: Divider(
              thickness: 2,
            ),
          ),
          SizedBox(
            width: double.infinity,
            height: 585,
            child: tasks.isNotEmpty
                ? ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: tasks.length,
                    itemBuilder: (BuildContext context, int index) {
                      var task = tasks[index];

                      return Dismissible(
                        direction: DismissDirection.horizontal,
                        background: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(
                              Icons.delete_outline,
                              color: Colors.grey,
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Text(MyString.deletedTask,
                                style: TextStyle(
                                  color: Colors.grey,
                                ))
                          ],
                        ),
                        onDismissed: (direction) {
                          base.dataStore.dalateTask(task: task);
                        },
                        key: Key(task.id),
                        child: TaskWidget(
                          task: tasks[index],
                        ),
                      );
                    },
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FadeIn(
                        child: SizedBox(
                          width: 200,
                          height: 200,
                          child: Lottie.asset(
                            lottieURL,
                            animate: tasks.isNotEmpty ? false : true,
                          ),
                        ),
                      ),
                      FadeInUp(
                        from: 30,
                        child: const Text(
                          MyString.doneAllTask,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
          )
        ],
      ),
    );
  }
}

class MySlider extends StatelessWidget {
  MySlider({
    Key? key,
  }) : super(key: key);

  List<IconData> icons = [
    CupertinoIcons.home,
    CupertinoIcons.person_fill,
    CupertinoIcons.settings,
    CupertinoIcons.info_circle_fill,
  ];

  List<String> texts = [
    "Home",
    "Profile",
    "Settings",
    "Details",
  ];

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 90),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
            colors: MyColors.primaryGradientColor,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight),
      ),
      child: Column(
        children: [
          const CircleAvatar(
            radius: 50,
            backgroundImage: AssetImage('assets/img/usrprofile.png'),
          ),
          const SizedBox(
            height: 8,
          ),
          Text("Lakshay Singhal", style: textTheme.headline2),
          Text("Todo App", style: textTheme.headline3),
          Container(
            margin: const EdgeInsets.symmetric(
              vertical: 30,
              horizontal: 10,
            ),
            width: double.infinity,
            height: 300,
            child: ListView.builder(
                itemCount: icons.length,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (ctx, i) {
                  return InkWell(
                    // ignore: avoid_print
                    onTap: () => print("$i Selected"),
                    child: Container(
                      margin: const EdgeInsets.all(5),
                      child: ListTile(
                          leading: Icon(
                            icons[i],
                            color: Colors.white,
                            size: 30,
                          ),
                          title: Text(
                            texts[i],
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          )),
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }
}

class MyAppBar extends StatefulWidget implements PreferredSizeWidget {
  MyAppBar({
    Key? key,
    required this.drawerKey,
  }) : super(key: key);
  GlobalKey<SliderDrawerState> drawerKey;

  @override
  State<MyAppBar> createState() => _MyAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(100);
}

class _MyAppBarState extends State<MyAppBar>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  bool isDrawerOpen = false;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void toggle() {
    setState(() {
      isDrawerOpen = !isDrawerOpen;
      if (isDrawerOpen) {
        controller.forward();
        widget.drawerKey.currentState!.openSlider();
      } else {
        controller.reverse();
        widget.drawerKey.currentState!.closeSlider();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;

    var base = BaseWidget.of(context).dataStore.box;
    return Container(
      color: Colors.black87,
      width: double.infinity,
      height: 132,
      child: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: IconButton(
                  splashColor: Colors.white,
                  highlightColor: Colors.white,
                  icon: AnimatedIcon(
                    color: Colors.white,
                    icon: AnimatedIcons.menu_close,
                    progress: controller,
                    size: 30,
                  ),
                  onPressed: toggle),
            ),

            Text(MyString.mainTitle, style: textTheme.headline1),

            /// Delete Icon
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: GestureDetector(
                onTap: () {
                  base.isEmpty
                      ? warningNoTask(context)
                      : deleteAllTask(context);
                },
                child: const Icon(
                  color: Colors.white,
                  CupertinoIcons.trash,
                  size: 30,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Floating Action Button
class FAB extends StatelessWidget {
  const FAB({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          CupertinoPageRoute(
            builder: (context) => TaskView(
              taskControllerForSubtitle: null,
              taskControllerForTitle: null,
              task: null,
            ),
          ),
        );
      },
      child: Material(
        borderRadius: BorderRadius.circular(200),
        elevation: 10,
        child: Container(
          width: 70,
          height: 70,
          decoration: BoxDecoration(
            color: MyColors.primaryColor,
            borderRadius: BorderRadius.circular(200),
          ),
          child: const Center(
              child: Icon(
            size: 30,
            Icons.add,
            color: Colors.white,
          )),
        ),
      ),
    );
  }
}
