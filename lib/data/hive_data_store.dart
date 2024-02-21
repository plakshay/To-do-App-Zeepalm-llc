import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/task.dart';

class HiveDataStore {
  static const boxName = "tasksBox";
  final Box<Task> box = Hive.box<Task>(boxName);

  Future<void> addTask({required Task task}) async {
    await box.put(task.id, task);
  }

  Future<Task?> getTask({required String id}) async {
    return box.get(id);
  }

  Future<void> updateTask({required Task task}) async {
    await task.save();
  }

  Future<void> dalateTask({required Task task}) async {
    await task.delete();
  }

  ValueListenable<Box<Task>> listenToTask() {
    return box.listenable();
  }
}
