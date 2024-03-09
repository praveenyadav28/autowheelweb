// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'dart:developer';

import 'package:autowheelweb/Components/fullscreen.dart';
import 'package:autowheelweb/Components/menuController.dart';
import 'package:autowheelweb/Utils/Colors.dart';
import 'package:autowheelweb/Utils/dummy.dart';
import 'package:autowheelweb/Utils/mediaquery.dart';
import 'package:autowheelweb/onboarding/splash.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});
 @override
  Widget build(BuildContext context) {
    Sizes.init(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Auto Wheel',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColor.colPrimary),
        useMaterial3: false,
      ),
       home: MultiProvider(
        providers: [
          ChangeNotifierProvider<Classvaluechange>(
              create: (_) => Classvaluechange()),
          ChangeNotifierProvider(create: (context) => MenuControlle())
        ],
        child:  FullScreen(),
      ),
    );
  }
}

// class MyHomePage extends StatefulWidget {
//   MyHomePage({Key? key,required this.title}) : super(key: key);

//   final String title;

//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
// late List data = [] ;

//   Future<String> getData() async {
//    http.Response? response = await http.get(Uri.parse("http://lms.muepetro.com/api/UserController1/GetLocation"));
// if (response != null && response.statusCode == 200) {
//         // headers: {"Accept": "application/json"}
        
//     setState(() {
//       data = json.decode( response.body);
//     });
//     return "Success";
//   }
//   else 
//   {
//     log("Error");
//   }
//     return "Error";
//    }

//   @override
//   void initState() {
//     super.initState();
//     getData();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Flutter Api Example"),
//       ),
//       body: Center(
//         child: getList()
//       ),
//     );
//   }

//   Widget getList() {
//     if (data == null || data.length < 1) {
//       return Container(
//         child: Center(
//           child: Text("Please wait..."),
//         ),
//       );
//     }
//     return ListView.separated(
//       itemCount: data!.length,
//       itemBuilder: (BuildContext context, int index) {
//         return getListItem(index);
//       },
//       separatorBuilder: (context, index) {
//         return Divider();
//       },
//     );
//   }

//   Widget? getListItem(int i) {
//     if (data == null || data.length < 1) return null;
//     if (i == 0) {
//       return Container(
//         margin: EdgeInsets.all(4),
//         child: Center(
//           child: Text(
//             "Titles",
//             style: TextStyle(
//               fontSize: 22,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//         ),
//       );
//     }

//     return Container(
//       child: Container(
//         margin: EdgeInsets.all(4.0),
//         child: Padding(
//           padding: EdgeInsets.all(4),
//           child: Text(
//             data[i]['location_Name'].toString(),
//             style: TextStyle(fontSize: 18),
//           ),
//         ),
//       ),
//     );
//   }

// }