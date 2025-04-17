import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tz;

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> initNotifications() async {
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  final DarwinInitializationSettings initializationSettingsIOS =
      DarwinInitializationSettings(
    requestAlertPermission: true,
    requestBadgePermission: true,
    requestSoundPermission: true,
  );

  InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
    iOS: initializationSettingsIOS,
  );

  await flutterLocalNotificationsPlugin.initialize(initializationSettings);

  // Initialize timezone data
  tz.initializeTimeZones();
}

Future<void> showTestNotificationNow() async {
  const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
    'daily_channel_id', // Same channel as before
    'Daily Notifications',
    channelDescription: 'Daily reminder notifications',
    importance: Importance.max,
    priority: Priority.high,
  );
  const DarwinNotificationDetails iOSDetails = DarwinNotificationDetails(
    presentAlert: true, // Show an alert (required for iOS 10+)
    presentBadge: true, // Update app badge number
    presentSound: true, // Play a sound
  );

  const NotificationDetails platformDetails = NotificationDetails(
    android: androidDetails,
    iOS: iOSDetails,
  );

  await flutterLocalNotificationsPlugin.show(
    1,
    'Test Notification!',
    'This is a test notification!',
    platformDetails,
  );
}

Future<void> scheduleDailyNotification() async {
  const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
    'daily_channel_id',
    'Daily Notifications',
    channelDescription: 'Daily reminder notifications',
    importance: Importance.max,
    priority: Priority.high,
  );

  const NotificationDetails platformDetails =
      NotificationDetails(android: androidDetails);

  // Schedule for 10:00 AM
  final tz.TZDateTime scheduledDate = _nextInstanceOfTime(10, 0);

  await flutterLocalNotificationsPlugin.zonedSchedule(
    0,
    'Daily Reminder!',
    'Donnot forget to come back!',
    scheduledDate,
    platformDetails,
    //androidAllowWhileIdle: true,
    //uiLocalNotificationDateInterpretation:UILocalNotificationDateInterpretation.absoluteTime,
    matchDateTimeComponents: DateTimeComponents.time,
    androidScheduleMode: AndroidScheduleMode.exact,
  );
}

tz.TZDateTime _nextInstanceOfTime(int hour, int minute) {
  final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
  tz.TZDateTime scheduledDate =
      tz.TZDateTime(tz.local, now.year, now.month, now.day, hour, minute);
  if (scheduledDate.isBefore(now)) {
    scheduledDate = scheduledDate.add(const Duration(days: 1));
  }
  return scheduledDate;
}
