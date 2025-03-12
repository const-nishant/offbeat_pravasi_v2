import 'package:appwrite/appwrite.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:offbeat_pravasi_v2/config/configs.dart';
import 'package:offbeat_pravasi_v2/firebase_options.dart';
import 'package:offbeat_pravasi_v2/helpers/helper_exports.dart';
import 'package:offbeat_pravasi_v2/router/router.dart';
import 'package:provider/provider.dart';
import 'modules/module_exports.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

Client client = Client();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  client
      .setEndpoint(Configs.appWriteEndpoint)
      .setProject(Configs.appWriteProjectId);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => AuthServices()),
      ChangeNotifierProvider(create: (_) => OnboardingServices()),
      ChangeNotifierProvider(create: (_) => Helperservices()),
      ChangeNotifierProvider(create: (_) => HomeServices()),
    ],
    child: Phoenix(
      child: const MyApp(),
    ),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Offbeat Pravasi',
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      routerConfig: router,
    );
  }
}
