import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';
import 'package:workmanager/workmanager.dart';

import '../domain/enums/task_unique_name.dart';
import '../domain/interfaces/i_background_manager_service.dart';

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((taskName, inputData) {
    debugPrint('Task executing: $taskName');

    return Future.value(true);
  });
}

class WorkManagerBackgroundManagerServiceImpl implements IBackgroundManagerService {
  @override
  Future<void> initialize() async {
    await Workmanager().initialize(
      callbackDispatcher,
      isInDebugMode: true,
    );
  }

  @override
  Future<void> registerTask(
    String taskName,
    TaskTag tag,
    Duration frequency,
  ) async {
    Workmanager().registerPeriodicTask(
      const Uuid().v4(),
      taskName,
      tag: tag.tag,
      frequency: frequency,
    );
  }

  @override
  Future<void> cancelTaskByTag(TaskTag tag) {
    return Workmanager().cancelByTag(tag.tag);
  }

  @override
  Future<void> cancelAllTask() {
    return Workmanager().cancelAll();
  }
}
