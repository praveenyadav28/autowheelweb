// // ignore_for_file: file_names, non_constant_identifier_names

// import 'package:admin_panel/Components/menuController.dart';
// import 'package:admin_panel/Utils/Colors.dart';
// import 'package:admin_panel/Utils/responsive.dart';
// import 'package:admin_panel/home/userprofile.dart';
// import 'package:country_picker/country_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// import '../Utils/dftbutton.dart';
// import '../Utils/textstyle.dart';
// import '../main.dart';

// class Approve extends StatefulWidget {
//   const Approve({super.key});

//   @override
//   State<Approve> createState() => _ApproveState();
// }

// class _ApproveState extends State<Approve> {
//   int serialNo = 1;
//   bool userStatus = true;
//   bool _isVisibleFilter = false;
//   void showAdvancedFilter() {
//     setState(() {
//       _isVisibleFilter = !_isVisibleFilter;
//     });
//   }

//   var nationalitySelsected = "Afganisthan";
//   var countrySelsected = "Afganisthan";
//   List StatusList = [
//     "Single",
//     "Never Engaged",
//     "Married",
//     "Never Married",
//     "Divorced without kids",
//     "Divorced with kids(s)",
//     "Widower without kids",
//     "Widower with kids(s)",
//   ];
//   List meetwith = [
//     "Alone",
//     "With a friend",
//     "With a family member",
//   ];
//   List languageList = [
//     {"name": "English", "valuecheck": false},
//     {"name": "عربي", "valuecheck": false},
//     {"name": "française", "valuecheck": false},
//     {"name": "Türk", "valuecheck": false},
//   ];

//   int meetwithcheckbox = 0;
//   List<String>? selectedStatusList = [];
//   double _startValue = 25;
//   double _endValue = 40;

//   var realPhotosFilter = false;
//   var unbluredFilter = true;
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
//         title: const Text("Approve List", overflow: TextOverflow.ellipsis),
//       ),
//       backgroundColor: const Color(0xff9610FF).withOpacity(.2),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: EdgeInsets.all(w * 0.02),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               SizedBox(
//                 height: h * 0.04,
//               ),
//               Align(
//                 alignment: Alignment.centerRight,
//                 child: DftButton(
//                     height: 40,
//                     width: 100,
//                     color: kprimclr,
//                     borderRadius: BorderRadius.circular(10),
//                     onTap: () {
//                       showAdvancedFilter();
//                     },
//                     child: const Padding(
//                       padding: EdgeInsets.all(8.0),
//                       child: Text(
//                         "Filter",
//                         style: TextStyle(color: Kwhiteclr),
//                       ),
//                     )),
//               ),
//               Visibility(
//                   visible: _isVisibleFilter,
//                   child: Column(children: [
//                     Text(
//                       "Nationality",
//                       style: Style40.copyWith(fontSize: 20),
//                     ),
//                     SizedBox(
//                       height: h * 0.05,
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         ElevatedButton(
//                           child: const Text("Nationality"),
//                           onPressed: () {
//                             showCountryPicker(
//                               context: context,
//                               onSelect: (Country country) {
//                                 nationalitySelsected = country.displayName;
//                               },
//                               countryListTheme: CountryListThemeData(
//                                 borderRadius: const BorderRadius.only(
//                                   topLeft: Radius.circular(40.0),
//                                   topRight: Radius.circular(40.0),
//                                 ),
//                                 inputDecoration: InputDecoration(
//                                   labelText: 'Search',
//                                   hintText: 'Start typing to search',
//                                   prefixIcon: const Icon(Icons.search),
//                                   border: OutlineInputBorder(
//                                     borderSide: BorderSide(
//                                       color: const Color(0xFF8C98A8)
//                                           .withOpacity(0.2),
//                                     ),
//                                   ),
//                                 ),
//                                 searchTextStyle: const TextStyle(
//                                   color: Colors.blue,
//                                   fontSize: 18,
//                                 ),
//                               ),
//                             );
//                           },
//                         ),
//                         Text(
//                           nationalitySelsected.toString(),
//                           style: Style16,
//                         )
//                       ],
//                     ),
//                     SizedBox(
//                       height: h * 0.02,
//                     ),
//                     Text(
//                       "Country",
//                       style: Style40.copyWith(fontSize: 20),
//                     ),
//                     SizedBox(
//                       height: h * 0.05,
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         ElevatedButton(
//                           child: const Text("Country"),
//                           onPressed: () {
//                             showCountryPicker(
//                               context: context,
//                               onSelect: (Country country) {
//                                 countrySelsected = country.displayName;
//                               },
//                               countryListTheme: CountryListThemeData(
//                                 borderRadius: const BorderRadius.only(
//                                   topLeft: Radius.circular(40.0),
//                                   topRight: Radius.circular(40.0),
//                                 ),
//                                 inputDecoration: InputDecoration(
//                                   labelText: 'Search',
//                                   hintText: 'Start typing to search',
//                                   prefixIcon: const Icon(Icons.search),
//                                   border: OutlineInputBorder(
//                                     borderSide: BorderSide(
//                                       color: const Color(0xFF8C98A8)
//                                           .withOpacity(0.2),
//                                     ),
//                                   ),
//                                 ),
//                                 searchTextStyle: const TextStyle(
//                                   color: Colors.blue,
//                                   fontSize: 18,
//                                 ),
//                               ),
//                             );
//                           },
//                         ),
//                         Text(
//                           countrySelsected.toString(),
//                           style: Style16,
//                         )
//                       ],
//                     ),
//                     SizedBox(
//                       height: h * 0.02,
//                     ),
//                     Container(
//                       height: 2,
//                       color: kbuilddot,
//                       margin: EdgeInsets.symmetric(vertical: h * 0.01),
//                     ),
//                     Text(
//                       "Age",
//                       style: Style40.copyWith(fontSize: 20),
//                     ),
//                     RangeSlider(
//                       min: 18.0,
//                       max: 70.0,
//                       divisions: 52,
//                       labels: RangeLabels(_startValue.round().toString(),
//                           _endValue.round().toString()),
//                       values: RangeValues(_startValue, _endValue),
//                       onChanged: (values) {
//                         setState(() {
//                           _startValue = values.start;
//                           _endValue = values.end;
//                         });
//                       },
//                     ),
//                     Text(
//                       "All Language",
//                       style: Style40.copyWith(fontSize: 20),
//                     ),
//                     ListView.builder(
//                         padding: const EdgeInsets.all(0),
//                         shrinkWrap: true,
//                         physics: const NeverScrollableScrollPhysics(),
//                         itemCount: languageList.length,
//                         itemBuilder: (BuildContext context, int index) {
//                           return Padding(
//                             padding: EdgeInsets.only(right: w * 0.03),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               children: [
//                                 SizedBox(
//                                   height: h * 0.014,
//                                 ),
//                                 Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     SizedBox(
//                                         width: w * 0.28,
//                                         child: Text(
//                                           languageList[index]["name"],
//                                           style: Style16.copyWith(
//                                               color: kblackclr),
//                                         )),
//                                     SizedBox(
//                                       width: 20,
//                                       height: 20,
//                                       child: Checkbox(
//                                           side: MaterialStateBorderSide
//                                               .resolveWith(
//                                             (states) => const BorderSide(
//                                                 width: 1.0, color: kprimclr),
//                                           ),
//                                           shape: RoundedRectangleBorder(
//                                             borderRadius:
//                                                 BorderRadius.circular(2.0),
//                                           ),
//                                           activeColor: Colors.white,
//                                           checkColor: kprimclr,
//                                           value: languageList[index]
//                                               ["valuecheck"],
//                                           onChanged: (bool? Newvalue) {
//                                             setState(() {
//                                               languageList[index]
//                                                   ["valuecheck"] = Newvalue!;
//                                             });
//                                           }),
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           );
//                         }),
//                     Container(
//                       height: 2,
//                       color: kbuilddot,
//                       margin: EdgeInsets.symmetric(vertical: h * 0.01),
//                     ),
//                     Text(
//                       "Status",
//                       style: Style40.copyWith(fontSize: 20),
//                     ),
//                     Wrap(
//                       children: StatusList.map(
//                         (lorem2) {
//                           bool isSelectedLorem2 = false;
//                           if (selectedStatusList!.contains(lorem2)) {
//                             isSelectedLorem2 = true;
//                           }
//                           return GestureDetector(
//                             onTap: () {
//                               if (!selectedStatusList!.contains(lorem2)) {
//                                 selectedStatusList!.add(lorem2);
//                                 setState(() {});
//                               } else {
//                                 selectedStatusList!.removeWhere(
//                                     (element) => element == lorem2);
//                                 setState(() {});
//                               }
//                             },
//                             child: Container(
//                                 margin: const EdgeInsets.all(5),
//                                 child: Container(
//                                   decoration: BoxDecoration(
//                                     color: isSelectedLorem2
//                                         ? kprimclr
//                                         : kborderclr,
//                                     borderRadius: BorderRadius.circular(100),
//                                   ),
//                                   child: Padding(
//                                     padding: const EdgeInsets.symmetric(
//                                         vertical: 12, horizontal: 18),
//                                     child: Text(
//                                       lorem2,
//                                       style: Style16.copyWith(
//                                         fontSize: 14,
//                                         fontWeight: FontWeight.w400,
//                                         color: isSelectedLorem2
//                                             ? Kwhiteclr
//                                             : kblackclr,
//                                       ),
//                                     ),
//                                   ),
//                                 )),
//                           );
//                         },
//                       ).toList(),
//                     ),
//                     const Divider(
//                       thickness: 2,
//                     ),
//                     FilterRow(
//                         text: "Real Photos Only",
//                         value: realPhotosFilter,
//                         onChanged: (value) {
//                           realPhotosFilter = value;
//                           setState(
//                             () {},
//                           );
//                         }),
//                     FilterRow(
//                         text: "Unblured photos only",
//                         value: unbluredFilter,
//                         onChanged: (value) {
//                           unbluredFilter = value;
//                           setState(
//                             () {},
//                           );
//                         }),
//                     Container(
//                       height: 2,
//                       color: kbuilddot,
//                       margin: EdgeInsets.symmetric(vertical: h * 0.02),
//                     ),
//                     Text(
//                       "I will meet you",
//                       style: Style40.copyWith(fontSize: 20),
//                     ),
//                     ListView.builder(
//                         physics: const BouncingScrollPhysics(),
//                         padding: const EdgeInsets.all(0),
//                         shrinkWrap: true,
//                         scrollDirection: Axis.vertical,
//                         itemCount: meetwith.length,
//                         itemBuilder: (BuildContext context, int index) {
//                           return InkWell(
//                             onTap: () {
//                               setState(() {
//                                 meetwithcheckbox = index;
//                               });
//                             },
//                             child: Row(
//                               children: [
//                                 Container(
//                                   width: 20,
//                                   height: 20,
//                                   margin: const EdgeInsets.all(8),
//                                   decoration: BoxDecoration(
//                                     border: Border.all(
//                                       color: kprimclr,
//                                     ),
//                                     borderRadius: BorderRadius.circular(5),
//                                     color: index == meetwithcheckbox
//                                         ? kprimclr
//                                         : Kwhiteclr,
//                                   ),
//                                   child: const Center(
//                                       child: Icon(
//                                     Icons.check,
//                                     color: Kwhiteclr,
//                                     size: 18,
//                                   )),
//                                 ),
//                                 SizedBox(
//                                   width: w * 0.05,
//                                 ),
//                                 Text(meetwith[index], style: Style14),
//                               ],
//                             ),
//                           );
//                         }),
//                     SizedBox(
//                       height: h * 0.02,
//                     ),
//                   ])),
//               SizedBox(
//                   width: Responsive.isMobile(context) ? w * 0.7 : w * 0.35,
//                   child: TextFormField(
//                     decoration: InputDecoration(
//                         suffixIcon: Container(
//                             margin: const EdgeInsets.only(right: 5),
//                             decoration: BoxDecoration(
//                                 color: const Color(0xff9610FF).withOpacity(.3),
//                                 borderRadius: BorderRadius.circular(10)),
//                             child: const Icon(Icons.search)),
//                         filled: true,
//                         hintText: "Search...",
//                         fillColor: Colors.white,
//                         errorBorder: OutlineInputBorder(
//                             borderSide: BorderSide.none,
//                             borderRadius: BorderRadius.circular(20)),
//                         focusedBorder: OutlineInputBorder(
//                             borderSide: BorderSide.none,
//                             borderRadius: BorderRadius.circular(20)),
//                         border: OutlineInputBorder(
//                             borderSide: BorderSide.none,
//                             borderRadius: BorderRadius.circular(20))),
//                   )),
//               Padding(
//                 padding: EdgeInsets.symmetric(
//                   vertical: h * 0.04,
//                 ),
//                 child: SingleChildScrollView(
//                   scrollDirection: Axis.horizontal,
//                   child: Table(
//                     border: TableBorder.all(
//                         color: Colors.transparent,
//                         width: 0,
//                         borderRadius: BorderRadius.circular(10)),
//                     columnWidths: !Responsive.isMobile(context)
//                         ? !Responsive.isTablet(context)
//                             ? <int, TableColumnWidth>{
//                                 0: FixedColumnWidth(w * .08),
//                                 1: FlexColumnWidth(w * .00001),
//                                 2: FixedColumnWidth(w * .21),
//                                 3: FixedColumnWidth(w * .17),
//                                 4: FixedColumnWidth(w * .17),
//                                 5: FixedColumnWidth(w * .17),
//                               }
//                             : <int, TableColumnWidth>{
//                                 0: FixedColumnWidth(w * .08),
//                                 1: FlexColumnWidth(w * .00001),
//                                 2: FixedColumnWidth(w * .28),
//                                 3: FixedColumnWidth(w * .2 - 3),
//                                 4: FixedColumnWidth(w * .2 - 3),
//                                 5: FixedColumnWidth(w * .2 - 3),
//                               }
//                         : <int, TableColumnWidth>{
//                             0: const FixedColumnWidth(60),
//                             1: const FlexColumnWidth(01),
//                             2: const FixedColumnWidth(200),
//                             3: const FixedColumnWidth(130),
//                             4: const FixedColumnWidth(130),
//                             5: const FixedColumnWidth(130),
//                           },
//                     defaultVerticalAlignment: TableCellVerticalAlignment.middle,
//                     children: [
//                       const TableRow(children: [
//                         TableCell(
//                           child: Center(
//                             child: Text(
//                               "Sr.No.",
//                               style: TextStyle(
//                                   color: Colors.black,
//                                   fontSize: 18,
//                                   fontWeight: FontWeight.w500),
//                             ),
//                           ),
//                         ),
//                         TableCell(child: Text("")),
//                         TableCell(
//                           child: Center(
//                             child: Text(
//                               "User",
//                               style: TextStyle(
//                                   color: Colors.black,
//                                   fontSize: 18,
//                                   fontWeight: FontWeight.w500),
//                             ),
//                           ),
//                         ),
//                         TableCell(
//                           child: Center(
//                             child: Text("Contact Details",
//                                 style: TextStyle(
//                                     color: Colors.black,
//                                     fontSize: 18,
//                                     fontWeight: FontWeight.w500)),
//                           ),
//                         ),
//                         TableCell(
//                           child: Center(
//                             child: Text(
//                               "Date",
//                               style: TextStyle(
//                                   color: Colors.black,
//                                   fontSize: 18,
//                                   fontWeight: FontWeight.w500),
//                             ),
//                           ),
//                         ),
//                         TableCell(
//                           child: Center(
//                             child: Text(
//                               "Your Response",
//                               style: TextStyle(
//                                   color: Colors.black,
//                                   fontSize: 18,
//                                   fontWeight: FontWeight.w500),
//                             ),
//                           ),
//                         )
//                       ]),
//                       for (var i = 0; i < 15; i++) ...[
//                         TableRow(children: [
//                           TableCell(
//                               child: Center(
//                             child: Text("${i + 1}"),
//                           )),
//                           TableCell(child: Container()),
//                           TableCell(
//                               child: Center(
//                             child: Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: Row(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   const CircleAvatar(
//                                       maxRadius: 25,
//                                       backgroundImage:
//                                           AssetImage("assets/Wallpaper.jpg")),
//                                   SizedBox(
//                                     width: w * 0.02,
//                                   ),
//                                   Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       const Text("Quarban", style: Style16),
//                                       Text(
//                                         "24y",
//                                         style: Style16.copyWith(
//                                             fontSize: 14,
//                                             fontWeight: FontWeight.w400),
//                                       ),
//                                     ],
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           )),
//                           const TableCell(
//                             child: Center(child: Text("91802328723")),
//                           ),
//                           const TableCell(
//                               child: Center(child: Text("10 March 2023"))),
//                           TableCell(
//                               child: Center(
//                                   child: Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Container(
//                                 decoration: BoxDecoration(
//                                     color: Colors.white,
//                                     borderRadius: BorderRadius.circular(8)),
//                                 child: IconButton(
//                                     onPressed: () {
//                                       Navigator.push(
//                                           context,
//                                           MaterialPageRoute(
//                                             builder: (context) =>
//                                                  Userprofile(),
//                                           ));
//                                     },
//                                     icon: const Icon(
//                                       Icons.edit,
//                                       color: Color(0xff9610FF),
//                                     )),
//                               ),
//                               SizedBox(
//                                 width: w * 0.01,
//                               ),
//                               Container(
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
//                         ])
//                       ]
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
