// import 'package:autowheelweb/Utils/colors.dart';
// import 'package:flutter/material.dart';
// import 'package:syncfusion_flutter_charts/charts.dart';
// import 'package:syncfusion_flutter_charts/sparkcharts.dart';

// class MyHomePage extends StatefulWidget {
//   // ignore: prefer_const_constructors_in_immutables
//   MyHomePage({Key? key}) : super(key: key);

//   @override
//   MyHomePageState createState() => MyHomePageState();
// }

// class MyHomePageState extends State<MyHomePage> {
//   // List<_SalesData> data = [
//   //   _SalesData('Jan', 35),
//   //   _SalesData('Feb', 28),
//   //   _SalesData('Mar', 34),
//   //   _SalesData('Apr', 32),
//   //   _SalesData('May', 40)
//   // ];
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: const Text('Syncfusion Flutter chart'),
//         ),
//         body: Center(
//           child: Container(
//             height: 300,
//             child: SfCircularChart(
//               series: <CircularSeries>[
//                 DoughnutSeries<ChartData, String>(
//                   dataSource: <ChartData>[
//                     ChartData('A', 10,color: AppColor.colPriLite),
//                     ChartData('B', 20,color: AppColor.colRideFare),
//                     ChartData('C', 30,color: AppColor.colPrimary),
//                     ChartData('D', 40,color: AppColor.colYellow),
//                   ],
//                   pointColorMapper: (ChartData data, _) => data.color,
//                   xValueMapper: (ChartData data, _) => data.x,
//                   yValueMapper: (ChartData data, _) => data.y,
//                 ),
//               ],
//             ),
//           ),
//         ),
//       );
//     }
// }

// class ChartData {
//   final String x;
//   final double y;
//   final Color color;

//   ChartData(this.x, this.y, {this.color = Colors.blue});
// }