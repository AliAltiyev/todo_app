import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hive_using/di/application.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:hive_using/screens/splash.dart';

import 'firebase_options.dart';
import 'model/task.dart';
import 'screens/home.dart';

void main() async {
  //For async
  WidgetsFlutterBinding.ensureInitialized();
  //Localization
  await EasyLocalization.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  //Locale Database
  await Hive.initFlutter();
  Hive.registerAdapter<Task>(TaskAdapter());
  await Hive.openBox<Task>('tasks');
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  debugPrint('init firebase');

  //Get it
  Application.setUp();

  //RUNS APP
  runApp(EasyLocalization(
      supportedLocales: const [Locale('ru', 'RU'), Locale('en', 'US')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en', 'US'),
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/splash': (context) => const Splash(),
        '/home': (context) => const Home()
      },
      initialRoute: '/splash',
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      debugShowCheckedModeBanner: false,
      title: 'To do',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
            color: Colors.white,
            elevation: 0,
            iconTheme: IconThemeData(color: Colors.deepPurple, size: 32)),
        primarySwatch: Colors.deepPurple,
      ),

    );
  }
}
