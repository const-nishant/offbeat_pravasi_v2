import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// Global navigator key
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class PushNotifications {
  static final _firebaseMessaging = FirebaseMessaging.instance;
  static final FlutterLocalNotificationsPlugin
      _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  // Initialize push notifications
  static Future<void> init() async {
    await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: false,
      criticalAlert: true,
      provisional: false,
      sound: true,
    );

    await getDeviceToken();
    listenForTokenRefresh();
    await localNotiInit();
  }

  // Get the FCM device token and store it
  static Future<void> getDeviceToken() async {
    try {
      String? token = await _firebaseMessaging.getToken();
      if (token != null) {
        debugPrint("FCM Token: $token");
        await saveTokenToFirestore(token);
      }
    } catch (e) {
      debugPrint("Failed to get device token: $e");
    }
  }

  // Save token to Firestore
  static Future<void> saveTokenToFirestore(String token) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(user.uid)
          .set({'notificationToken': token}, SetOptions(merge: true));
      debugPrint("FCM token updated in Firestore.");
    }
  }

  // Listen for FCM token refresh
  static void listenForTokenRefresh() {
    _firebaseMessaging.onTokenRefresh.listen((newToken) async {
      debugPrint("FCM Token refreshed: $newToken");
      await saveTokenToFirestore(newToken);
    });
  }

  // Initialize local notifications
  static Future<void> localNotiInit() async {
    const AndroidInitializationSettings androidInitSettings =
        AndroidInitializationSettings('@mipmap/launcher_icon');

    const DarwinInitializationSettings iosInitSettings =
        DarwinInitializationSettings();

    const InitializationSettings initSettings = InitializationSettings(
      android: androidInitSettings,
      iOS: iosInitSettings,
    );

    await _flutterLocalNotificationsPlugin.initialize(
      initSettings,
      onDidReceiveNotificationResponse: onNotificationTap,
      onDidReceiveBackgroundNotificationResponse: onNotificationTap,
    );
  }

  // Handle notification tap
  static void onNotificationTap(NotificationResponse notificationResponse) {
    navigatorKey.currentState!.pushNamed("/userlist");
  }

  // Show a simple local notification
  static Future<void> showSimpleNotification({
    required String title,
    required String body,
    required String payload,
  }) async {
    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
      'channel_id',
      'General Notifications',
      channelDescription: 'This is a general notification channel',
      importance: Importance.max,
      priority: Priority.high,
    );

    const NotificationDetails notificationDetails = NotificationDetails(
      android: androidDetails,
    );

    await _flutterLocalNotificationsPlugin
        .show(0, title, body, notificationDetails, payload: payload);
  }
}
