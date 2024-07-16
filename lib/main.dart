// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:input_slider/input_slider.dart';
import 'package:input_slider/input_slider_form.dart';
import 'package:provider/provider.dart';

import 'package:userboffee/Core.dart';
import 'package:userboffee/Core/config/network.dart';
import 'package:userboffee/Core/config/options.dart';
import 'package:userboffee/Core/constants/components.dart';
import 'package:userboffee/Core/constants/images.dart';
import 'package:userboffee/Core/provider/CoinProvider.dart';
import 'package:userboffee/Core/provider/Theme_provider.dart';
import 'package:userboffee/feature/getpost/bloc/getpost_bloc.dart';
import 'package:userboffee/views/auth/signup.dart';
import 'package:userboffee/views/baises_screen/QuetsPage.dart';
import 'package:userboffee/views/baises_screen/setting.dart';
import 'package:userboffee/views/firstpages/splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  Setup();
  runApp(EasyLocalization(
      supportedLocales: [Locale('en'), Locale('ar')],
      path: 'asset/translate', // <-- change the path of the translation files
      fallbackLocale: Locale('en'),
      child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (context) => ThemeProvider()..initTheme()),
        ChangeNotifierProvider(
            create: (context ) =>ThemeProvider()..IniColortheme()),
        ChangeNotifierProvider(
          create: (context) => CoinProvider(),
        ),
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
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            debugShowCheckedModeBanner: false,
             theme: context.watch<ThemeProvider>().themedata,
            home: AppScaffold(child: CorePage()));
      }),
    );
  }
}

class AppScaffold extends StatelessWidget {
  final Widget child;
  const AppScaffold({
    Key? key,
    required this.child,
  }) : super(key: key);
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
