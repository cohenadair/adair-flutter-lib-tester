import 'package:adair_flutter_lib/app_config.dart';
import 'package:adair_flutter_lib/pages/scroll_page.dart';
import 'package:adair_flutter_lib/widgets/adair_flutter_lib_app.dart';
import 'package:adair_flutter_lib/widgets/button.dart';
import 'package:adair_flutter_lib/wrappers/firebase_auth_wrapper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const AdairFlutterLibTester());
}

class AdairFlutterLibTester extends StatefulWidget {
  const AdairFlutterLibTester({super.key});

  @override
  State<AdairFlutterLibTester> createState() => _AdairFlutterLibTesterState();
}

class _AdairFlutterLibTesterState extends State<AdairFlutterLibTester> {
  @override
  void initState() {
    super.initState();

    AppConfig.get.init(
      appName: () => "Adair Flutter Lib Tester",
      colorAppTheme: Colors.teal,
      themeMode: () => ThemeMode.dark,
    );
  }

  @override
  Widget build(BuildContext context) {
    return AdairFlutterLibApp(
      managers: [],
      requiresAuth: true,
      darkTheme: ThemeData.dark().copyWith(
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppConfig.get.colorAppTheme,
          brightness: Brightness.dark,
        ),
        textTheme: ThemeData.dark().textTheme.copyWith(
          bodySmall: const TextStyle(fontSize: 14),
          bodyMedium: const TextStyle(fontSize: 16),
          bodyLarge: const TextStyle(fontSize: 18),
        ),
      ),
      themeMode: ThemeMode.dark,
      homeBuilder: (_) => ScrollPage(
        appBar: AppBar(title: Text(AppConfig.get.appName())),
        children: [
          Button(
            text: "Sign Out",
            onPressed: () => FirebaseAuthWrapper.get.signOut(),
          ),
        ],
      ),
    );
  }
}
