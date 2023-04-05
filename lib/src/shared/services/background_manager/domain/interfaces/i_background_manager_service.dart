import '../enums/task_unique_name.dart';

abstract class IBackgroundManagerService {
  Future<void> initialize();
  Future<void> registerTask(String taskName, TaskTag tag, Duration frequency);
  Future<void> cancelTaskByTag(TaskTag tag);
  Future<void> cancelAllTask();
}
