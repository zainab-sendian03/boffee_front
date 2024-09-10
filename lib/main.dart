// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'package:userboffee/Core/config/network.dart';
import 'package:userboffee/Core/config/options.dart';
import 'package:userboffee/Core/constants/images.dart';
import 'package:userboffee/Core/provider/Theme_provider.dart';
import 'package:userboffee/feature/getpost/bloc/getpost_bloc.dart';
import 'package:userboffee/views/firstpages/splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  tz.initializeTimeZones();
  Setup();
  runApp(EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ar')],
      path: 'asset/translate', // <-- change the path of the translation files
      fallbackLocale: const Locale('en'),
      child:
          //DevicePreview(
          // enabled: !kReleaseMode,
          // builder:(context)=>
          const MyApp()
      //  )
      ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  @override
  void initState() {
    super.initState();
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@drawable/ic_notification');

    const InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);

    flutterLocalNotificationsPlugin.initialize(initializationSettings);
    requestPermissionsAndScheduleNotification();
  }

  Future<void> requestPermissionsAndScheduleNotification() async {
    final bool permissionGranted = await flutterLocalNotificationsPlugin
            .resolvePlatformSpecificImplementation<
                AndroidFlutterLocalNotificationsPlugin>()
            ?.requestPermission() ??
        false;
    print('Permission granted: $permissionGranted');

    if (permissionGranted) {
      await _scheduleDailyNotification();
    }
  }

  Future<void> _scheduleDailyNotification() async {
    final tz.TZDateTime scheduledDate = _nextInstanceOfTime(11, 10);
    print('Scheduling notification for: $scheduledDate');

    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: AndroidNotificationDetails(
        'daily_reading_channel',
        'Daily Reading',
        channelDescription: 'Reminder to read daily',
        icon: "asset/images/logo.png",
        importance: Importance.max,
        priority: Priority.high,
      ),
    );

    await flutterLocalNotificationsPlugin.periodicallyShow(
      0, // Notification ID (use a unique ID for each notification if needed)
      'Reminder',
      'This is a notification sent every minute',
      RepeatInterval.everyMinute, // Interval at which notifications repeat
      platformChannelSpecifics,
    );
  }

  tz.TZDateTime _nextInstanceOfTime(int hour, int minute) {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate =
        tz.TZDateTime(tz.local, now.year, now.month, now.day, hour, minute);
    //     if (scheduledDate.isBefore(now)) {
    //   scheduledDate = scheduledDate.add(const Duration(days: 1));
    // }
    print('Scheduled time: $scheduledDate');
    return scheduledDate;
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (context) => ThemeProvider()..initTheme()),
        ChangeNotifierProvider(
            create: (context) => ThemeProvider()..IniColortheme()),
        BlocProvider(
          create: (context) => GetpostBloc(),
        ),
        StreamProvider(
            lazy: true,
            create: (context) => Conictivity().connection.stream,
            initialData: status.online)
      ],
      child: Builder(builder: (context) {
        return MaterialApp(
            //    useInheritedMediaQuery: true,
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            //??
            //  DevicePreview.locale(context),+
            debugShowCheckedModeBanner: false,
            theme: context.watch<ThemeProvider>().themedata,
            home: const AppScaffold(child: SplashScreen()));
      }),
    );
  }
}

class AppScaffold extends StatelessWidget {
  final Widget child;
  const AppScaffold({
    super.key,
    required this.child,
  });
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    var connection = Provider.of<status>(context);
    return Scaffold(
        body: (connection == status.offline)
            ? Center(
                child: Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(noInternet), fit: BoxFit.fill)),
              ))
            : child);
  }
}
