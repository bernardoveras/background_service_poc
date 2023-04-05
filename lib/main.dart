import 'package:flutter/material.dart';

import 'src/modules/home/home_page.dart';
import 'src/shared/services/background_manager/data/workmanager_background_manager_service_impl.dart';

final backgroundManagerService = WorkManagerBackgroundManagerServiceImpl();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await backgroundManagerService.initialize();

  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Background Service - POC',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: HomePage(backgroundManagerService: backgroundManagerService),
    );
  }
}
