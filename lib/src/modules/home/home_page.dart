import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../../shared/services/background_manager/domain/enums/task_unique_name.dart';
import '../../shared/services/background_manager/domain/interfaces/i_background_manager_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
    required this.backgroundManagerService,
  }) : super(key: key);

  final IBackgroundManagerService backgroundManagerService;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String nextTask = "";

  Future<void> registerTask() async {
    await widget.backgroundManagerService.registerTask(
      const Uuid().v4(),
      TaskTag.example,
      const Duration(minutes: 15),
    );
    setState(() => nextTask = DateTime.now().add(const Duration(minutes: 15)).toString());
  }

  Future<void> cancelAllTasks() async {
    await widget.backgroundManagerService.cancelAllTask();
    setState(() => nextTask = '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Background Service'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Next task: $nextTask',
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: nextTask.isNotEmpty ? () => cancelAllTasks() : () async => registerTask(),
        child: Icon(nextTask.isNotEmpty ? Icons.pause : Icons.play_arrow_rounded),
      ),
    );
  }
}
