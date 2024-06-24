// import 'package:flutter/material.dart';
// import 'package:userboffee/Core.dart';
// import 'package:userboffee/feature/setting.dart';

// void main() {
//   runApp( MyApp());
// }

// class MyApp extends StatelessWidget {
//    MyApp({super.key});

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: SettingUi(
        
//       ), // This trailing comma makes auto-formatting nicer for build methods.
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:input_slider/input_slider.dart';
import 'package:input_slider/input_slider_form.dart';
import 'package:provider/provider.dart';
import 'package:userboffee/Core.dart';
import 'package:userboffee/Core/components/coponents.dart';
import 'package:userboffee/Core/config/options.dart';
import 'package:userboffee/Core/provider/Theme_provider.dart';
import 'package:userboffee/feature/setting.dart';
import 'package:userboffee/views/QuetsPage.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Setup();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        ChangeNotifierProvider(create: (context)=> ThemeProvider()..initTheme())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
       
        theme: context.watch<ThemeProvider>().themedata,
        home: CorePage()
      ),
    );
  }
}

// class MyHomePage extends StatefulWidget {
//   MyHomePage() : super();

//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   double _volume = 50;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body:
//       Padding(
//           padding: const EdgeInsets.all(30.0),
//           child: Column(
//             children: [
//               InputSlider(
//                   onChange: (value) {
//                     setState(() {
//                       _volume = value;
//                     });
//                   },
//                   min: 0.0,
//                   max: 100.0,
//                   decimalPlaces: 0,
//                   defaultValue: 30,
//                   activeSliderColor: Colors.green,
//                   inactiveSliderColor: Colors.green[100],
//                   leading: Icon(Icons.volume_down)),
//               _volumeDisplay(),
//               Padding(padding: EdgeInsets.symmetric(vertical: 24), child: Divider(),),
//               Expanded(
//                 child: InputSliderForm(
//                   vertical: true,
//                   leadingWeight: 1,
//                   sliderWeight: 20,
//                   activeSliderColor: Colors.red,
//                   inactiveSliderColor: Colors.green[100],
//                   filled: true,
//                   children: [
//                     InputSlider(
//                       onChange: (value) {
//                         print("Setting 1 changed");
//                       },
//                       min: 0.0,
//                       max: 10.0,
//                       decimalPlaces: 0,
//                       defaultValue: 5.0,
//                       leading: Text("Setting 1:"),
//                     ),
//                     InputSlider(
//                       onChange: (value) {
//                         print("Setting 2 changed");
//                       },
//                       min: 0.0,
//                       max: 1.0,
//                       decimalPlaces: 3,
//                       defaultValue: 0.32,
//                     ),
//                     InputSlider(
//                       onChange: (value) {
//                         print("Setting 3 changed");
//                       },
//                       min: 0.0,
//                       max: 5.0,
//                       decimalPlaces: 1,
//                       defaultValue: 4.1,
//                         leading: Icon(Icons.perm_data_setting_outlined)
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           )),
//     );
//   }

//   Widget _volumeDisplay() {
//     if (_volume < 30) return Text("Turn it up!");
//     if (_volume < 70) return Text("Nice volume :-)");
//     return Text("Ahhhh! My ears!");
//   }
// }