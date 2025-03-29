import 'package:appwrite/appwrite.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:offbeat_pravasi_v2/config/configs.dart';
import 'package:offbeat_pravasi_v2/firebase_options.dart';
import 'package:offbeat_pravasi_v2/helpers/helper_exports.dart';
import 'package:offbeat_pravasi_v2/router/router.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'modules/module_exports.dart';

Client client = Client();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(
      widgetsBinding: WidgetsFlutterBinding.ensureInitialized());

  client
      .setEndpoint(Configs.appWriteEndpoint)
      .setProject(Configs.appWriteProjectId);

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Ensure SharedPreferences is initialized before the app starts
  // ignore: unused_local_variable
  SharedPreferences prefs = await SharedPreferences.getInstance();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthServices()),
        ChangeNotifierProvider(create: (_) => OnboardingServices()),
        ChangeNotifierProvider(create: (_) => Helperservices()),
        ChangeNotifierProvider(create: (_) => HomeServices()),
        ChangeNotifierProvider(create: (_) => Trekservices()),
        ChangeNotifierProvider(create: (_) => ProfileService()),
        ChangeNotifierProvider(create: (_) => Communityservices()),
      ],
      child: Phoenix(
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    initialization();
  }

  void initialization() async {
    await Future.delayed(const Duration(milliseconds: 200));
    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Offbeat प्रवासी',
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      routerConfig: router,
    );
  }
}
