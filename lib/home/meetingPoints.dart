// ignore_for_file: file_names
// // ignore_for_file: file_names

// import 'package:admin_panel/Utils/Colors.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// import '../Components/menuController.dart';
// import '../Utils/responsive.dart';
// import '../Utils/textstyle.dart';
// import '../main.dart';

// class MeetingPoints extends StatefulWidget {
//   const MeetingPoints({super.key});

//   @override
//   State<MeetingPoints> createState() => _MeetingPointsState();
// }

// class _MeetingPointsState extends State<MeetingPoints> {
//   @override
//   Widget build(BuildContext context) {
//     w = MediaQuery.of(context).size.width;
//     h = MediaQuery.of(context).size.height;
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         leading: (!Responsive.isDesktop(context))
//             ? IconButton(
//                 onPressed: context.read<MenuControlle>().controlMenu,
//                 icon: const Icon(Icons.menu))
//             : Container(),
//         title: const Text("Address List", overflow: TextOverflow.ellipsis),
//         actions: [
//           InkWell(
//             onTap: () {},
//             child: Container(
//                 margin: const EdgeInsets.all(10),
//                 padding: const EdgeInsets.all(10),
//                 decoration: BoxDecoration(
//                     color: Colors.green.withOpacity(.3),
//                     borderRadius: BorderRadius.circular(20)),
//                 child: const Text("+ Add New Meeting Point",
//                     overflow: TextOverflow.ellipsis)),
//           )
//         ],
//       ),
//       backgroundColor: kprimclr.withOpacity(.2),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             SizedBox(
//               height: h * 0.04,
//             ),
//             Padding(
//               padding: EdgeInsets.symmetric(vertical: h * 0.04, horizontal: 15),
//               child: SingleChildScrollView(
//                 scrollDirection: Axis.horizontal,
//                 child: Table(
//                   border: TableBorder.all(
//                       color: Colors.transparent,
//                       width: 0,
//                       borderRadius: BorderRadius.circular(10)),
//                   columnWidths: !Responsive.isMobile(context)
//                       ? !Responsive.isTablet(context)
//                           ? <int, TableColumnWidth>{
//                               0: FixedColumnWidth(w * .08),
//                               1: FlexColumnWidth(w * .00001),
//                               2: FixedColumnWidth(w * .24),
//                               3: FixedColumnWidth(w * .24),
//                               4: FixedColumnWidth(w * .24),
//                             }
//                           : <int, TableColumnWidth>{
//                               0: FixedColumnWidth(w * .1),
//                               1: FlexColumnWidth(w * .00001),
//                               2: FixedColumnWidth(w * .25),
//                               3: FixedColumnWidth(w * .25),
//                               4: FixedColumnWidth(w * .25),
//                             }
//                       : <int, TableColumnWidth>{
//                           0: const FixedColumnWidth(60),
//                           1: const FlexColumnWidth(01),
//                           2: const FixedColumnWidth(150),
//                           3: const FixedColumnWidth(150),
//                           4: const FixedColumnWidth(150),
//                         },
//                   defaultVerticalAlignment: TableCellVerticalAlignment.middle,
//                   children: [
//                     TableRow(children: [
//                       TableCell(
//                         child: SizedBox(
//                           height: h * 0.052,
//                           child: const Center(
//                             child: Text(
//                               "Sr.No.",
//                               style: TextStyle(
//                                   color: Colors.black,
//                                   fontSize: 18,
//                                   fontWeight: FontWeight.w500),
//                             ),
//                           ),
//                         ),
//                       ),
//                       const TableCell(child: Text("")),
//                       TableCell(
//                         child: SizedBox(
//                           height: h * 0.052,
//                           child: const Center(
//                             child: Text(
//                               "Title",
//                               style: TextStyle(
//                                   color: Colors.black,
//                                   fontSize: 18,
//                                   fontWeight: FontWeight.w500),
//                             ),
//                           ),
//                         ),
//                       ),
//                       const TableCell(
//                         child: Center(
//                           child: Text(
//                             "Location",
//                             style: TextStyle(
//                                 color: Colors.black,
//                                 fontSize: 18,
//                                 fontWeight: FontWeight.w500),
//                           ),
//                         ),
//                       ),
//                       const TableCell(
//                         child: Center(
//                           child: Text(
//                             "Action",
//                             style: TextStyle(
//                                 color: Colors.black,
//                                 fontSize: 18,
//                                 fontWeight: FontWeight.w500),
//                           ),
//                         ),
//                       )
//                     ]),
//                     for (var i = 0; i < 5; i++) ...[
//                       TableRow(children: [
//                         TableCell(
//                             child: Center(
//                           child: Text(
//                             "${i + 1}",
//                           ),
//                         )),
//                         const TableCell(child: Text("")),
//                         const TableCell(
//                             child: Padding(
//                           padding: EdgeInsets.all(8.0),
//                           child: Center(
//                             child: Text(
//                               "Restaurat",
//                               style: Style16,
//                             ),
//                           ),
//                         )),
//                         const TableCell(
//                             child: Center(
//                                 child: Text("2972 Westheimer Rd. Illinois "))),
//                         TableCell(
//                           child: TableCell(
//                               child: Center(
//                                   child: Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Container(
//                                 margin: const EdgeInsets.all(8),
//                                 decoration: BoxDecoration(
//                                     color: Colors.white,
//                                     borderRadius: BorderRadius.circular(8)),
//                                 child: IconButton(
//                                     onPressed: () {},
//                                     icon: const Icon(
//                                       Icons.edit,
//                                       color: Color(0xff9610FF),
//                                     )),
//                               ),
//                               Container(
//                                 margin: const EdgeInsets.all(8),
//                                 decoration: BoxDecoration(
//                                     color: Colors.white,
//                                     borderRadius: BorderRadius.circular(8)),
//                                 child: IconButton(
//                                   icon: const Icon(Icons.delete,
//                                       color: Color(0xff9610FF)),
//                                   onPressed: () {},
//                                 ),
//                               ),
//                             ],
//                           ))),
//                         ),
//                       ])
//                     ]
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
