// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_application_test/views/PDFviewer.dart';
// import 'package:path/path.dart';
// import 'package:path_provider/path_provider.dart';

// class home extends StatelessWidget {
//   const home({super.key});
//   static Future<File> loadAsset(String path) async {
//     final data = await rootBundle.load(path);
//     final bytes = data.buffer.asInt8List();
//     return _storFile(path, bytes);
//   }

//   static Future<File> _storFile(String Url, List<int> bytes) async {
//     final filename = basename(Url);
//     final dir = await getApplicationDocumentsDirectory();
//     final file = File('${dir.path}/$filename');
//     await file.writeAsBytes(bytes, flush: true);
//     return file;
//   }

//   // void openPDF(BuildContext context, File file) {
//   //   Navigator.of(context).push(
//   //     MaterialPageRoute(
//   //       builder: (context) => PDFviewer( bookModel: ,),
//   //     ),
//   //   );
//   // }

//   @override
//   Widget build(BuildContext context) {
//     //final coinProvider = Provider.of<CoinProvider>(context);

//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: Scaffold(
//         appBar: AppBar(
//           backgroundColor: const Color.fromARGB(255, 196, 155, 114),
//           title: const Text(
//             'Category',
//             style: TextStyle(fontSize: 30, color: Color(0xff5D3F2E)),
//           ),
//           actions: [
//             Stack(
//               children: [
//                 Container(
//                   height: 35,
//                   width: 100,
//                   decoration: BoxDecoration(
//                     color: const Color.fromARGB(255, 239, 239, 239),
//                     borderRadius: BorderRadius.circular(20),
//                   ),
//                   child: Padding(
//                     padding: const EdgeInsets.only(left: 50),
//                     child: Image.asset(
//                       "asset/images/coin.png",
//                       scale: 3,
//                     ),
//                   ),
//                 ),
//                 const Padding(
//                   padding: EdgeInsets.only(left: 18),
//                   child: Text(
//                     "",
//                     // "${coinProvider.coins}",
//                     style: TextStyle(fontSize: 25, color: Color(0xFF5D3F2E)),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//         body: Center(
//           child: Builder(builder: (ncontext) {
//             return ElevatedButton(
//               onPressed: () async {
//                 const path = 'asset/the_little_prince.pdf';
//                 final file = await loadAsset(path);
//                 // ignore: unnecessary_null_comparison
//                 if (file == null) return;
//                 openPDF(ncontext, file);
//               },
//               child: const Text("PDF"),
//             );
//           }),
//         ),
//       ),
//     );
//   }
// }
