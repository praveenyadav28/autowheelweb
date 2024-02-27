// ignore_for_file: file_names
// // ignore_for_file: prefer_typing_uninitialized_variables, prefer_const_constructors, sort_child_properties_last, file_names, non_constant_identifier_names

// import 'package:country_picker/country_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// import '../Utils/Colors.dart';
// import '../Utils/dftbutton.dart';
// import '../Utils/responsive.dart';
// import '../Utils/textstyle.dart';
// import '../Components/menuController.dart';

// class Message extends StatefulWidget {
//   const Message({super.key});

//   @override
//   State<Message> createState() => _MessageState();
// }

// class _MessageState extends State<Message> {
//   TextEditingController titlecontroller = TextEditingController();
//   TextEditingController messagecontroller = TextEditingController();
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
//   final _formKey = GlobalKey<FormState>();
//   var h, w;
//   @override
//   Widget build(BuildContext context) {
//     h = MediaQuery.of(context).size.height;
//     w = MediaQuery.of(context).size.width;
//     return Scaffold(
//       backgroundColor: const Color(0xff9610FF).withOpacity(.2),
//       appBar: AppBar(
//         leading: (!Responsive.isDesktop(context))
//             ? IconButton(
//                 onPressed: context.read<MenuControlle>().controlMenu,
//                 icon: const Icon(Icons.menu))
//             : Container(),
//         title: Text(
//           "Notifications/Emails",
//           style: TextStyle(fontSize: 22, fontWeight: FontWeight.w400),
//         ),
//         centerTitle: true,
//         elevation: 0,
//         actions: [
//           Center(
//             child: Padding(
//               padding: EdgeInsets.only(right: w * 0.03),
//               child: MaterialButton(
//                   onPressed: () {
//                     Navigator.push(context,
//                         MaterialPageRoute(builder: (context) => History()));
//                   },
//                   child: Text("History",
//                       style: TextStyle(fontSize: 18, color: Colors.blue)),
//                   height: 40,
//                   minWidth: 130,
//                   color: Colors.white,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(8),
//                   )),
//             ),
//           )
//         ],
//       ),
//       body: SingleChildScrollView(
//         child: Form(
//           key: _formKey,
//           child: Padding(
//             padding:
//                 EdgeInsets.symmetric(horizontal: w * 0.03, vertical: h * 0.03),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Align(
//                   alignment: Alignment.centerRight,
//                   child: DftButton(
//                       height: 40,
//                       width: 100,
//                       child: Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Text(
//                           "Filter",
//                           style: TextStyle(color: Kwhiteclr),
//                         ),
//                       ),
//                       color: kprimclr,
//                       borderRadius: BorderRadius.circular(10),
//                       onTap: () {
//                         showAdvancedFilter();
//                       }),
//                 ),
//                 Visibility(
//                     visible: _isVisibleFilter,
//                     child: Column(children: [
//                       Text(
//                         "Nationality",
//                         style: Style40.copyWith(fontSize: 20),
//                       ),
//                       SizedBox(
//                         height: h * 0.05,
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           ElevatedButton(
//                             child: const Text("Nationality"),
//                             onPressed: () {
//                               showCountryPicker(
//                                 context: context,
//                                 onSelect: (Country country) {
//                                   nationalitySelsected = country.displayName;
//                                 },
//                                 countryListTheme: CountryListThemeData(
//                                   borderRadius: const BorderRadius.only(
//                                     topLeft: Radius.circular(40.0),
//                                     topRight: Radius.circular(40.0),
//                                   ),
//                                   inputDecoration: InputDecoration(
//                                     labelText: 'Search',
//                                     hintText: 'Start typing to search',
//                                     prefixIcon: const Icon(Icons.search),
//                                     border: OutlineInputBorder(
//                                       borderSide: BorderSide(
//                                         color: const Color(0xFF8C98A8)
//                                             .withOpacity(0.2),
//                                       ),
//                                     ),
//                                   ),
//                                   searchTextStyle: const TextStyle(
//                                     color: Colors.blue,
//                                     fontSize: 18,
//                                   ),
//                                 ),
//                               );
//                             },
//                           ),
//                           Text(
//                             nationalitySelsected.toString(),
//                             style: Style16,
//                           )
//                         ],
//                       ),
//                       SizedBox(
//                         height: h * 0.02,
//                       ),
//                       Text(
//                         "Country",
//                         style: Style40.copyWith(fontSize: 20),
//                       ),
//                       SizedBox(
//                         height: h * 0.05,
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           ElevatedButton(
//                             child: const Text("Country"),
//                             onPressed: () {
//                               showCountryPicker(
//                                 context: context,
//                                 onSelect: (Country country) {
//                                   countrySelsected = country.displayName;
//                                 },
//                                 countryListTheme: CountryListThemeData(
//                                   borderRadius: const BorderRadius.only(
//                                     topLeft: Radius.circular(40.0),
//                                     topRight: Radius.circular(40.0),
//                                   ),
//                                   inputDecoration: InputDecoration(
//                                     labelText: 'Search',
//                                     hintText: 'Start typing to search',
//                                     prefixIcon: const Icon(Icons.search),
//                                     border: OutlineInputBorder(
//                                       borderSide: BorderSide(
//                                         color: const Color(0xFF8C98A8)
//                                             .withOpacity(0.2),
//                                       ),
//                                     ),
//                                   ),
//                                   searchTextStyle: const TextStyle(
//                                     color: Colors.blue,
//                                     fontSize: 18,
//                                   ),
//                                 ),
//                               );
//                             },
//                           ),
//                           Text(
//                             countrySelsected.toString(),
//                             style: Style16,
//                           )
//                         ],
//                       ),
//                       SizedBox(
//                         height: h * 0.02,
//                       ),
//                       Container(
//                         height: 2,
//                         color: kbuilddot,
//                         margin: EdgeInsets.symmetric(vertical: h * 0.01),
//                       ),
//                       Text(
//                         "Age",
//                         style: Style40.copyWith(fontSize: 20),
//                       ),
//                       RangeSlider(
//                         min: 18.0,
//                         max: 70.0,
//                         divisions: 52,
//                         labels: RangeLabels(_startValue.round().toString(),
//                             _endValue.round().toString()),
//                         values: RangeValues(_startValue, _endValue),
//                         onChanged: (values) {
//                           setState(() {
//                             _startValue = values.start;
//                             _endValue = values.end;
//                           });
//                         },
//                       ),
//                       Text(
//                         "All Language",
//                         style: Style40.copyWith(fontSize: 20),
//                       ),
//                       ListView.builder(
//                           padding: EdgeInsets.all(0),
//                           shrinkWrap: true,
//                           physics: NeverScrollableScrollPhysics(),
//                           itemCount: languageList.length,
//                           itemBuilder: (BuildContext context, int index) {
//                             return Padding(
//                               padding: EdgeInsets.only(right: w * 0.03),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 mainAxisAlignment: MainAxisAlignment.start,
//                                 children: [
//                                   SizedBox(
//                                     height: h * 0.014,
//                                   ),
//                                   Row(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceBetween,
//                                     children: [
//                                       SizedBox(
//                                           width: w * 0.28,
//                                           child: Text(
//                                             languageList[index]["name"],
//                                             style: Style16.copyWith(
//                                                 color: kblackclr),
//                                           )),
//                                       SizedBox(
//                                         width: 20,
//                                         height: 20,
//                                         child: Checkbox(
//                                             side: MaterialStateBorderSide
//                                                 .resolveWith(
//                                               (states) => BorderSide(
//                                                   width: 1.0, color: kprimclr),
//                                             ),
//                                             shape: RoundedRectangleBorder(
//                                               borderRadius:
//                                                   BorderRadius.circular(2.0),
//                                             ),
//                                             activeColor: Colors.white,
//                                             checkColor: kprimclr,
//                                             value: languageList[index]
//                                                 ["valuecheck"],
//                                             onChanged: (bool? Newvalue) {
//                                               setState(() {
//                                                 languageList[index]
//                                                     ["valuecheck"] = Newvalue!;
//                                               });
//                                             }),
//                                       ),
//                                     ],
//                                   ),
//                                 ],
//                               ),
//                             );
//                           }),
//                       Container(
//                         height: 2,
//                         color: kbuilddot,
//                         margin: EdgeInsets.symmetric(vertical: h * 0.01),
//                       ),
//                       Text(
//                         "Status",
//                         style: Style40.copyWith(fontSize: 20),
//                       ),
//                       Wrap(
//                         children: StatusList.map(
//                           (lorem2) {
//                             bool isSelectedLorem2 = false;
//                             if (selectedStatusList!.contains(lorem2)) {
//                               isSelectedLorem2 = true;
//                             }
//                             return GestureDetector(
//                               onTap: () {
//                                 if (!selectedStatusList!.contains(lorem2)) {
//                                   selectedStatusList!.add(lorem2);
//                                   setState(() {});
//                                 } else {
//                                   selectedStatusList!.removeWhere(
//                                       (element) => element == lorem2);
//                                   setState(() {});
//                                 }
//                               },
//                               child: Container(
//                                   margin: const EdgeInsets.all(5),
//                                   child: Container(
//                                     decoration: BoxDecoration(
//                                       color: isSelectedLorem2
//                                           ? kprimclr
//                                           : kborderclr,
//                                       borderRadius: BorderRadius.circular(100),
//                                     ),
//                                     child: Padding(
//                                       padding: const EdgeInsets.symmetric(
//                                           vertical: 12, horizontal: 18),
//                                       child: Text(
//                                         lorem2,
//                                         style: Style16.copyWith(
//                                           fontSize: 14,
//                                           fontWeight: FontWeight.w400,
//                                           color: isSelectedLorem2
//                                               ? Kwhiteclr
//                                               : kblackclr,
//                                         ),
//                                       ),
//                                     ),
//                                   )),
//                             );
//                           },
//                         ).toList(),
//                       ),
//                       const Divider(
//                         thickness: 2,
//                       ),
//                       FilterRow(
//                           text: "Real Photos Only",
//                           value: realPhotosFilter,
//                           onChanged: (value) {
//                             realPhotosFilter = value;
//                             setState(
//                               () {},
//                             );
//                           }),
//                       FilterRow(
//                           text: "Unblured photos only",
//                           value: unbluredFilter,
//                           onChanged: (value) {
//                             unbluredFilter = value;
//                             setState(
//                               () {},
//                             );
//                           }),
//                       Container(
//                         height: 2,
//                         color: kbuilddot,
//                         margin: EdgeInsets.symmetric(vertical: h * 0.02),
//                       ),
//                       Text(
//                         "I will meet you",
//                         style: Style40.copyWith(fontSize: 20),
//                       ),
//                       ListView.builder(
//                           physics: const BouncingScrollPhysics(),
//                           padding: const EdgeInsets.all(0),
//                           shrinkWrap: true,
//                           scrollDirection: Axis.vertical,
//                           itemCount: meetwith.length,
//                           itemBuilder: (BuildContext context, int index) {
//                             return InkWell(
//                               onTap: () {
//                                 setState(() {
//                                   meetwithcheckbox = index;
//                                 });
//                               },
//                               child: Row(
//                                 children: [
//                                   Container(
//                                     width: 20,
//                                     height: 20,
//                                     margin: const EdgeInsets.all(8),
//                                     decoration: BoxDecoration(
//                                       border: Border.all(
//                                         color: kprimclr,
//                                       ),
//                                       borderRadius: BorderRadius.circular(5),
//                                       color: index == meetwithcheckbox
//                                           ? kprimclr
//                                           : Kwhiteclr,
//                                     ),
//                                     child: const Center(
//                                         child: Icon(
//                                       Icons.check,
//                                       color: Kwhiteclr,
//                                       size: 18,
//                                     )),
//                                   ),
//                                   SizedBox(
//                                     width: w * 0.05,
//                                   ),
//                                   Text(meetwith[index], style: Style14),
//                                 ],
//                               ),
//                             );
//                           }),
//                       SizedBox(
//                         height: h * 0.02,
//                       ),
//                     ])),
//                 Text("Title", style: TextStyle(fontSize: 18, color: kblackclr)),
//                 SizedBox(height: h * 0.01),
//                 TextFormField(
//                   keyboardAppearance: Brightness.light,
//                   cursorWidth: w * 0.00277,
//                   controller: titlecontroller,
//                   style: TextStyle(
//                       fontSize: 18, color: kblackclr.withOpacity(0.8)),
//                   decoration: InputDecoration(
//                     contentPadding:
//                         EdgeInsets.symmetric(horizontal: w * 0.0277),
//                     hintText: "Title",
//                     hintStyle: TextStyle(
//                         fontSize: 18, color: kblackclr.withOpacity(0.5)),
//                     border: InputBorder.none,
//                     enabledBorder: OutlineInputBorder(
//                       borderSide: BorderSide(color: kblackclr),
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                       borderSide: BorderSide(color: kblackclr),
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                     focusedErrorBorder: OutlineInputBorder(
//                       borderSide: BorderSide(color: kblackclr),
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                     errorBorder: OutlineInputBorder(
//                       borderSide: BorderSide(color: kblackclr),
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                   ),
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please enter title';
//                     }
//                     return null;
//                   },
//                 ),
//                 SizedBox(height: h * 0.1),
//                 Text("Message",
//                     style: TextStyle(fontSize: 18, color: kblackclr)),
//                 SizedBox(height: h * 0.01),
//                 TextFormField(
//                     maxLines: 7,
//                     keyboardAppearance: Brightness.light,
//                     cursorWidth: w * 0.00277,
//                     controller: messagecontroller,
//                     style: TextStyle(
//                         fontSize: 18, color: kblackclr.withOpacity(0.8)),
//                     decoration: InputDecoration(
//                       contentPadding: EdgeInsets.symmetric(
//                           horizontal: w * 0.0277, vertical: h * 0.03),
//                       hintText: "Message",
//                       hintStyle: TextStyle(
//                           fontSize: 18, color: kblackclr.withOpacity(0.5)),
//                       border: InputBorder.none,
//                       enabledBorder: OutlineInputBorder(
//                         borderSide: BorderSide(color: kblackclr),
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                       focusedBorder: OutlineInputBorder(
//                         borderSide: BorderSide(color: kblackclr),
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                       focusedErrorBorder: OutlineInputBorder(
//                         borderSide: BorderSide(color: kblackclr),
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                       errorBorder: OutlineInputBorder(
//                         borderSide: BorderSide(color: kblackclr),
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                     ),
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Please enter message';
//                       }
//                       return null;
//                     }),
//                 SizedBox(height: h * 0.04),
//                 DftButton(
//                     onTap: () {
//                       if (_formKey.currentState!.validate()) {
//                         message1.add(messagecontroller.text.toString());
//                         title.add(titlecontroller.text.toString());
//                         messagecontroller.clear();
//                         titlecontroller.clear();
//                       }
//                     },
//                     child: Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Text("Send", style: TextStyle(color: Kwhiteclr)),
//                     ),
//                     height: 40,
//                     width: 100,
//                     color: kprimclr,
//                     borderRadius: BorderRadius.circular(10))
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// List title = [];
// List message1 = [];

// class History extends StatefulWidget {
//   const History({super.key});

//   @override
//   State<History> createState() => _HistoryState();
// }

// class _HistoryState extends State<History> {
//   var h, w;
//   @override
//   Widget build(BuildContext context) {
//     h = MediaQuery.of(context).size.height;
//     w = MediaQuery.of(context).size.width;
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("History",
//             style: TextStyle(fontSize: 22, fontWeight: FontWeight.w400)),
//         centerTitle: true,
//         elevation: 0,
//       ),
//       backgroundColor: Kwhiteclr,
//       body: Container(
//         color: const Color(0xff9610FF).withOpacity(.2),
//         child: ListView.builder(
//             itemCount: message1.length,
//             itemBuilder: (BuildContext context, int index) {
//               return Padding(
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
//                 child: Container(
//                   width: w * 1,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(8),
//                     border: Border.all(color: kblackclr),
//                   ),
//                   child: Padding(
//                     padding: const EdgeInsets.only(left: 15),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Padding(
//                           padding: EdgeInsets.symmetric(vertical: 12),
//                           child: Row(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text("Title : ",
//                                   style: TextStyle(
//                                       fontSize: 18, color: kblackclr)),
//                               Text(title.elementAt(index),
//                                   style: TextStyle(
//                                       fontSize: 16, color: klightblackclr))
//                             ],
//                           ),
//                         ),
//                         Row(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text("Message : ",
//                                 style:
//                                     TextStyle(fontSize: 18, color: kblackclr)),
//                             Text(message1.elementAt(index),
//                                 style: TextStyle(
//                                     fontSize: 16, color: klightblackclr))
//                           ],
//                         ),
//                         Padding(
//                           padding: EdgeInsets.symmetric(vertical: 12),
//                           child: Row(
//                             children: const [
//                               Text("Filter :  ",
//                                   style: TextStyle(
//                                       fontSize: 18, color: kblackclr)),
//                               Text("Nationality : American,",
//                                   style: TextStyle(
//                                       fontSize: 16, color: Colors.blue)),
//                               SizedBox(
//                                 width: 10,
//                               ),
//                               Text("Country : Egypt,",
//                                   style: TextStyle(
//                                       fontSize: 16, color: Colors.green)),
//                               SizedBox(
//                                 width: 10,
//                               ),
//                               Text("Meet With : Alone,",
//                                   style: TextStyle(
//                                       fontSize: 16, color: Colors.blue)),
//                               SizedBox(
//                                 width: 10,
//                               ),
//                               Text("Status : Single,",
//                                   style: TextStyle(
//                                       fontSize: 16, color: Colors.green)),
//                               SizedBox(
//                                 width: 10,
//                               ),
//                               Text("Age : 25 - 30,",
//                                   style: TextStyle(
//                                       fontSize: 16, color: Colors.blue)),
//                               SizedBox(
//                                 width: 10,
//                               ),
//                               Text("   Gender : Male,",
//                                   style: TextStyle(
//                                       fontSize: 16, color: Colors.green)),
//                               SizedBox(
//                                 width: 10,
//                               ),
//                               Text("   Real photos and bulered photos : False,",
//                                   style: TextStyle(
//                                       fontSize: 16, color: Colors.blue)),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               );
//             }),
//       ),
//     );
//   }
// }
