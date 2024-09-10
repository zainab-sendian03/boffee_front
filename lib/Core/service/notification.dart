// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:timezone/timezone.dart' as tz;
// import 'package:timezone/data/latest.dart' as tz;

// class NotificationService {
//   final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//       FlutterLocalNotificationsPlugin();

//   Future<void> initialize() async {
//     const AndroidInitializationSettings initializationSettingsAndroid =
//         AndroidInitializationSettings('@mipmap/ic_launcher');

//     final InitializationSettings initializationSettings =
//         InitializationSettings(
//       android: initializationSettingsAndroid,
//     );

//     await flutterLocalNotificationsPlugin.initialize(
//       initializationSettings,
//     );

//     tz.initializeTimeZones();
//   }

//   Future<void> _scheduleMinuteNotification() async {
//     const AndroidNotificationDetails androidPlatformChannelSpecifics =
//         AndroidNotificationDetails(
//       'minute_channel',
//       'Minute Reminder',
//       channelDescription: 'Reminder every minute',
//       importance: Importance.max,
//       priority: Priority.high,
//       icon: "@mipmap/ic_launcher",
//     );

//     const NotificationDetails platformChannelSpecifics = NotificationDetails(
//       android: androidPlatformChannelSpecifics,
//     );

//     await flutterLocalNotificationsPlugin.periodicallyShow(
//       0, // Notification ID (use a unique ID for each notification if needed)
//       'Reminder',
//       'This is a notification sent every minute',
//       RepeatInterval.everyMinute, // Interval at which notifications repeat
//       platformChannelSpecifics,
//     );
//   }
// }
