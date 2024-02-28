// ignore_for_file: prefer_const_constructors

import 'package:autowheelweb/Components/fullscreen.dart';
import 'package:autowheelweb/Components/menuController.dart';
import 'package:autowheelweb/Utils/Colors.dart';
import 'package:autowheelweb/Utils/mediaquery.dart';
import 'package:autowheelweb/desktop/followup.dart';
import 'package:autowheelweb/desktop/prospect.dart';
import 'package:autowheelweb/desktop/report.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
            home: 
     MultiProvider(
        providers: [
          ChangeNotifierProvider<Classvaluechange>(
              create: (_) => Classvaluechange()),
          ChangeNotifierProvider(create: (context) => MenuControlle())
        ],
        child:  ReportScreen(),
      )
    );
  }
}
