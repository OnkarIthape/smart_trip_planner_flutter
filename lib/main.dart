
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'data/local/isar_service.dart';
import 'presentation/home_screen.dart';

Future <void> main()async {
  await dotenv.load(fileName: ".env");
  await IsarService.init(); // isar initialization 
  runApp(const ProviderScope(child: SmartTripApp()));
}

class SmartTripApp extends StatelessWidget {
  const SmartTripApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Trip Planner',
      theme: ThemeData.dark(useMaterial3: true),
      home: const HomeScreen(),
    );
  }
}
