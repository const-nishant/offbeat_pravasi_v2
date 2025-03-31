import 'dart:convert';
import 'package:appwrite/appwrite.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
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

  // Initialize Firebase Messaging
  await PushNotifications.init();

  // Initialize Local Notifications for Android & iOS
  await PushNotifications.localNotiInit();

  // Handle background messages
  FirebaseMessaging.onBackgroundMessage(_firebaseBackgroundMessage);

  // Handle when notification is tapped (app in background)
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    if (message.notification != null) {
      debugPrint("Background Notification Tapped");
      navigatorKey.currentState!.pushNamed("/home");
    }
  });

  // Handle foreground notifications
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    String payloadData = jsonEncode(message.data);
    debugPrint("Got a message in foreground");

    if (message.notification != null) {
      PushNotifications.showSimpleNotification(
        title: message.notification!.title!,
        body: message.notification!.body!,
        payload: payloadData,
      );
    }
  });

  // Handle app launch from terminated state
  final RemoteMessage? initialMessage =
      await FirebaseMessaging.instance.getInitialMessage();

  if (initialMessage != null) {
    debugPrint("Launched from terminated state");
    Future.delayed(const Duration(seconds: 1), () {
      navigatorKey.currentState!.pushNamed("/explore");
    });
  }

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
        ChangeNotifierProvider(create: (_) => SOSService()),
      ],
      child: Phoenix(
        child: const MyApp(),
      ),
    ),
  );
}

// Function to handle background messages
Future<void> _firebaseBackgroundMessage(RemoteMessage message) async {
  if (message.notification != null) {
    debugPrint("Notification Received in background...");
  }
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
