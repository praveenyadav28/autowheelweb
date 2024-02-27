// // ignore_for_file: prefer_const_declarations, override_on_non_overriding_member, non_constant_identifier_names, prefer_const_constructors, duplicate_ignore, must_be_immutable, avoid_print, use_build_context_synchronously

// import 'dart:async';
// import 'dart:convert';

// import 'package:autowheelweb/Components/menuController.dart';
// import 'package:autowheelweb/Utils/colors.dart';
// import 'package:autowheelweb/Utils/mediaquery.dart';
// import 'package:autowheelweb/Utils/responsive.dart';
// import 'package:autowheelweb/Utils/textfield.dart';
// import 'package:autowheelweb/Utils/textstyle.dart';
// import 'package:autowheelweb/model/group.dart';
// import 'package:autowheelweb/model/prospect_modal.dart';
// import 'package:dropdown_button2/dropdown_button2.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:intl/intl.dart';
// import 'package:provider/provider.dart';

// class FollowUpScreen extends StatefulWidget {
//   final String? refnom;
//   bool value = true;
//   FollowUpScreen({super.key, this.refnom, required this.value});
//   @override
//   State<FollowUpScreen> createState() => _FollowUpScreenState();
// }

// class _FollowUpScreenState extends State<FollowUpScreen> {
//   TextEditingController RefController = TextEditingController();
//   TextEditingController BlankController = TextEditingController();
//   TextEditingController splController = TextEditingController();
//   TextEditingController ActionController = TextEditingController();
//   TextEditingController ContactController = TextEditingController();
//   TextEditingController ContactnumbarController = TextEditingController();
//   TextEditingController RemarksController = TextEditingController();
//   TextEditingController datepickar = TextEditingController(
//     text: DateFormat('yyyy/MM/dd').format(DateTime.now()),
//   );
//   TextEditingController datepickar2 = TextEditingController(
//     text: DateFormat('yyyy/MM/dd').format(DateTime.now()),
//   );
//   List<Map<String, dynamic>> dataList1 = [];
//   List<Map<String, dynamic>> dateList = [];
//   String selectedVisitorName = "Visitor Name";
//   Map<String, dynamic>? selectedvixiterValue;
//   // int vixiterId = 0;
//   final TextEditingController vixiterController = TextEditingController();
//   // int? selectedPrionaityId;
//   int? selectedVisitorId;
//   //
//   List<Map<String, dynamic>> Prionaity = [
//     {'id': 0, 'name': 'Prionaity'}
//   ];
//   Map<String, dynamic>? selectedValue;
//   // int proirityId = 0;
//   final TextEditingController textEditingController = TextEditingController();
//   int? selectedPrionaityId;
//   //
//   List<Map<String, dynamic>> Folowtype = [
//     {'id': 0, 'name': 'Follow type*'}
//   ];
//   String selectedFolowtypeName = "Follow type*";
//   // int? selectedFolowtypeId;
//   Map<String, dynamic>? selectedfollowupValue;
//   int? followupid;
//   final TextEditingController FollowupController = TextEditingController();
//   // int? selectedPrionaityId;
//   //
//   late TimeOfDay selectedTime;

//   String conttact = "";
//   String remark = "";
//   String page = "";
//   String time = '';
//   List<Map<String, String>> dataList = [];
//   @override

//   // void updateTableValues() {
//   //   setState(() {
//   //     conttact = ContactController.text;
//   //     remark = RemarksController.text;
//   //     page = datepickar.text;
//   //          Map<String, String> newData = {
//   //       'Name': conttact,
//   //       'Age': remark,
//   //       'Page': page,
//   //       'time': time
//   //     };
//   //     dataList.add(newData);
//   //   });
//   // }

//   Future<void> _selectTime1(BuildContext context) async {
//     final TimeOfDay? picked = await showTimePicker(
//       context: context,
//       initialTime: selectedTime1,
//     );
//     if (picked != null && picked != selectedTime1) {
//       setState(() {
//         selectedTime1 = picked;
//       });
//     }
//   }

//   late TimeOfDay selectedTime1;
//   Future<void> _selectTime2(BuildContext context) async {
//     final TimeOfDay? picked = await showTimePicker(
//       context: context,
//       initialTime: selectedTime2,
//     );
//     if (picked != null && picked != selectedTime2) {
//       setState(() {
//         selectedTime2 = picked;
//       });
//     }
//   }

//   late TimeOfDay selectedTime2;
//   void startTimer() {
//     // ignore: prefer_const_constructors
//     Timer.periodic(Duration(minutes: 1), (Timer timer) {
//       setState(() {
//         selectedTime1 = TimeOfDay.now();
//         selectedTime2 = TimeOfDay.now();
//       });
//     });
//   }

//   refreshData() async {
//     await prionaityDeta();
//     followtypeDeta();
//     vixiter();
//     PrefixData();
//   }

//   @override
//   void initState() {
//     super.initState();
//     setState(() {
//       selectedTime1 = TimeOfDay.now();
//       selectedTime2 = TimeOfDay.now();
//       prionaityDeta();
//       startTimer();
//       followtypeDeta();
//       vixiter();
//       refreshData();
//     });
//     RefController.text = widget.refnom == null ? "" : widget.refnom.toString();
//     // Prionaity.clear();
//     // Prionaity.add({'id': 0, 'name': 'Prionaity'});
//     // prionaityDeta().then((_) {
//     //   setState(() {
//     //     selectedValue = Prionaity.firstWhere(
//     //       (item) => item['id'] == selectedPrionaityId,
//     //       orElse: () => Prionaity[0],
//     //     );
//       // });
//     // });
//   }

//   @override
//   void dispose() {
//     splController.clear();
//     RemarksController.clear();

//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: widget.value
//             ? (!Responsive.isDesktop(context))
//                 ? IconButton(
//                     onPressed: context.read<MenuControlle>().controlMenu,
//                     icon: const Icon(Icons.menu),
//                   )
//                 : Container()
//             : IconButton(
//                 onPressed: () {
//                   Navigator.pop(context);
//                 },
//                 icon: Icon(Icons.arrow_back_ios_new)),
//         centerTitle: true,
//         backgroundColor: AppColor.colPrimary,
//         title: Text(
//           "Follow Up",
//           style: TextStyle(color: AppColor.colWhite),
//         ),
//         ),
//       backgroundColor: AppColor.colWhite,
//       body:  Container(
//             color: AppColor.colPrimary.withOpacity(.1),
//             height: Sizes.height,
//             child: dateList.isEmpty
//           ? Center(
//               child: CircularProgressIndicator(),  )
//           :SingleChildScrollView(
//                 child: Padding(
//                   padding: EdgeInsets.symmetric(
//                       vertical: Sizes.height * 0.02,
//                       horizontal: Sizes.width * 0.04),
//                   child: Column(
//                     children: [
//                       textformfiles(RefController,
//                           keyboardType: TextInputType.number, onChanged: (e) {
//                         setState(() {
//                           PrefixData();
//                         });
//                       }, labelText: "Ref.No"),
//                       SizedBox(height: Sizes.height * 0.02),
//                       dropdownTextfield(
//                         'Select vixiter',
//                         searchDropDown(
//                           'Select vixiter',
//                           dateList
//                               .map((item) => DropdownMenuItem(
//                                     onTap: () {
//                                       selectedVisitorId = item['id'];
//                                     },
//                                     value: item,
//                                     child: Row(
//                                       children: [
//                                         Text(
//                                           item['customer_Name'].toString(),
//                                           style: const TextStyle(
//                                               fontSize: 16,
//                                               fontWeight: FontWeight.bold),
//                                         ),
//                                       ],
//                                     ),
//                                   ))
//                               .toList(),
//                           selectedvixiterValue,
//                           (value) {
//                             setState(() {
//                               selectedvixiterValue = value;
//                             });
//                           },
//                           vixiterController,
//                           (value) {
//                             setState(() {
//                               // Filter the Prionaity list based on the search value
//                               dateList
//                                   .where((item) => item['customer_Name']
//                                       .toString()
//                                       .toLowerCase()
//                                       .contains(value.toLowerCase()))
//                                   .toList();
//                             });
//                           },
//                           "Search for a vixiter...",
//                           (isOpen) {
//                             if (!isOpen) {
//                               vixiterController.clear();
//                             }
//                           },
//                         ),
//                       ),
//                       SizedBox(
//                         height: Sizes.height * 0.02,
//                       ),
//                       Row(
//                         children: [
//                           Expanded(
//                             child: textformfiles(ContactController,
//                                 labelText: "Contact Person"),
//                           ),
//                           SizedBox(width: Sizes.width * 0.02),
//                           Expanded(
//                             child: textformfiles(ContactnumbarController,
//                                 keyboardType: TextInputType.number,
//                                 labelText: "Contact Numbar"),
//                           ),
//                         ],
//                       ),
//                       SizedBox(height: Sizes.height * 0.02),
//                       textformfiles(splController, labelText: "Spl.Remarks"),
//                       SizedBox(height: Sizes.height * 0.02),
//                       textformfiles(RemarksController, labelText: "Remarks"),
//                       SizedBox(height: Sizes.height * 0.02),
//                       Row(
//                         children: [
//                           Expanded(
//                               child: dropdownTextfield(
//                             "Date",
//                             InkWell(
//                               onTap: () async {
//                                 FocusScope.of(context).requestFocus(FocusNode());
//                                 await showDatePicker(
//                                   context: context,
//                                   initialDate: DateTime.now(),
//                                   firstDate: DateTime(1900),
//                                   lastDate: DateTime.now(),
//                                 ).then((selectedDate) {
//                                   if (selectedDate != null) {
//                                     datepickar.text = DateFormat('dd-MM-yyyy')
//                                         .format(selectedDate);
//                                   }
//                                 });
//                               },
//                               child: Row(
//                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Text(
//                                     datepickar.text,
//                                     style: rubikTextStyle(
//                                         16, FontWeight.w500, AppColor.colBlack),
//                                   ),
//                                   Icon(Icons.edit_calendar,
//                                       color: AppColor.colBlack)
//                                 ],
//                               ),
//                             ),
//                           )),
//                           SizedBox(width: Sizes.width * 0.04),
//                           Expanded(
//                               child: dropdownTextfield(
//                             "Time",
//                             InkWell(
//                               onTap: () {
//                                 _selectTime1(context);
//                               },
//                               child: Center(
//                                 child: Text(
//                                   selectedTime1.format(context),
//                                   style: rubikTextStyle(
//                                       16, FontWeight.w500, AppColor.colBlack),
//                                 ),
//                               ),
//                             ),
//                           ))
//                         ],
//                       ),
//                       SizedBox(height: Sizes.height * 0.02),
//                       Row(
//                         children: [
//                           Expanded(
//                             child: dropdownTextfield(
//                               "Select Priority",searchDropDown('Select Priority', Prionaity.map((item) => DropdownMenuItem(
//                                         onTap: () {
//                                           selectedPrionaityId = item['id'];
//                                         },
//                                         value: item,
//                                         child: Row(
//                                           children: [
//                                             Text(
//                                               item['name'].toString(),
//                                               style: rubikTextStyle(
//                                                   16,
//                                                   FontWeight.w500,
//                                                   AppColor.colBlack),
//                                             ),
//                                           ],
//                                         ),
//                                       )).toList(), selectedValue, (value) {
//                                     setState(() {
//                                       selectedValue = value;
//                                     });
//                                   }, textEditingController,  (value) {
//                                           setState(() {
//                                             // Filter the Prionaity list based on the search value
//                                             Prionaity.where((item) => item['name']
//                                                     .toString()
//                                                     .toLowerCase()
//                                                     .contains(
//                                                         value.toLowerCase()))
//                                                 .toList();
//                                           });
//                                         }, 'Search for a priority...',  (isOpen) {
//                                     if (!isOpen) {
//                                       textEditingController.clear();
//                                     }
//                                   })
//                             ),
//                           ),
//                           SizedBox(width: Sizes.width * 0.02),
//                           addDefaultButton(
//                             () {
//                               Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                       builder: (context) => AddGroupScreen(
//                                             sourecID: 18,
//                                             name: "Priority",
//                                           )));
//                             },
//                           )
//                         ],
//                       ),
//                       SizedBox(height: Sizes.height * 0.02),
//                       Row(
//                         children: [
//                           Expanded(
//                             child: dropdownTextfield(
//                               "Select Follow Up",
//                               searchDropDown('Select Follow Up', Folowtype.map((item) => DropdownMenuItem(
//                                         onTap: () {
//                                           followupid = item['id'];
//                                         },
//                                         value: item,
//                                         child: Row(
//                                           children: [
//                                             Text(
//                                               item['name'].toString(),
//                                               style: rubikTextStyle(
//                                                   16,
//                                                   FontWeight.w500,
//                                                   AppColor.colBlack),
//                                             ),
//                                           ],
//                                         ),
//                                       )).toList(), selectedfollowupValue,(value) {
//                                     setState(() {
//                                       selectedfollowupValue = value;
//                                     });
//                                   }, FollowupController, (value) {
//                                           setState(() {
//                                             // Filter the Prionaity list based on the search value
//                                             Folowtype.where((item) => item['name']
//                                                     .toString()
//                                                     .toLowerCase()
//                                                     .contains(
//                                                         value.toLowerCase()))
//                                                 .toList();
//                                           });
//                                         }, 'Search for a Follow Up...', (isOpen) {
//                                     if (!isOpen) {
//                                       FollowupController.clear();
//                                     }
//                                   },
//                                 ),
//                               ),
//                             ),
//                           SizedBox(width: Sizes.width * 0.02),
//                           addDefaultButton(
//                             () {
//                               Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                       builder: (context) => AddGroupScreen(
//                                             sourecID: 18,
//                                             name: "Follow Up",
//                                           )));
//                             },
//                           )
//                         ],
//                       ),
//                       SizedBox(height: Sizes.height * 0.02),
//                       Row(
//                         children: [
//                           Expanded(
//                               child: dropdownTextfield(
//                             "Date",
//                             InkWell(
//                               onTap: () async {
//                                 FocusScope.of(context).requestFocus(FocusNode());
//                                 await showDatePicker(
//                                   context: context,
//                                   initialDate: DateTime.now(),
//                                   firstDate: DateTime(1900),
//                                   lastDate: DateTime.now(),
//                                 ).then((selectedDate) {
//                                   if (selectedDate != null) {
//                                     datepickar2.text = DateFormat('dd-MM-yyyy')
//                                         .format(selectedDate);
//                                   }
//                                 });
//                               },
//                               child: Row(
//                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Text(
//                                     datepickar2.text,
//                                     style: rubikTextStyle(
//                                         16, FontWeight.w500, AppColor.colBlack),
//                                   ),
//                                   Icon(Icons.edit_calendar,
//                                       color: AppColor.colBlack)
//                                 ],
//                               ),
//                             ),
//                           )),
//                           SizedBox(width: Sizes.width * 0.04),
//                           Expanded(
//                               child: dropdownTextfield(
//                             "Time",
//                             InkWell(
//                               onTap: () {
//                                 _selectTime2(context);
//                               },
//                               child: Center(
//                                 child: Text(
//                                   selectedTime2.format(context),
//                                   style: rubikTextStyle(
//                                       16, FontWeight.w500, AppColor.colBlack),
//                                 ),
//                               ),
//                             ),
//                           ))
//                         ],
//                       ),
//                       SizedBox(height: Sizes.height * 0.02),
//                       InkWell(
//                           onTap: () {
//                             postFollowUp(context);
//                             // updateTableValues();
//                             // ContactController.clear();
//                             // RemarksController.clear();
//                             // datepickar.clear();
//                           },
//                           child: Button("Save", AppColor.colPrimary)),
//                       SizedBox(
//                         height: Sizes.height * 0.02,
//                       ),
//                       Button("Delete", AppColor.colRideFare),
//                     ],
//                   ),
//                 ),
//               ),
//           ),
//     );
//   }

//   Future<void> prionaityDeta() async {
//     final url = Uri.parse(
//         'http://lms.muepetro.com/api/UserController1/GetMiscMaster?MiscTypeId=22');
//     try {
//       final response = await http.get(url);
//       if (response.statusCode == 200) {
//         final List<Goruppartmodel> goruppartmodelList =
//             grouppartmodelFromJson(response.body);

//         Prionaity.clear();
//         Prionaity.add({'id': 0, 'name': 'Prionaity'});
//         for (var item in goruppartmodelList) {
//           Prionaity.add({'id': item.id, 'name': item.name});
//         }
//         setState(() {});
//       } else {
//         print('Request failed with status: ${response.statusCode}');
//         print('Response Data: ${response.body}');
//       }
//     } catch (e) {
//       print('Error: $e');
//     }
//   }

//   Future<void> followtypeDeta() async {
//     final url = Uri.parse(
//         'http://lms.muepetro.com/api/UserController1/GetMiscMaster?MiscTypeId=18');
//     try {
//       final response = await http.get(url);
//       if (response.statusCode == 200) {
//         final List<Goruppartmodel> goruppartmodelList =
//             grouppartmodelFromJson(response.body);

//         // Folowtype.clear();
//         Folowtype.add({'id': 0, 'name': 'Follow type*'});
//         for (var item in goruppartmodelList) {
//           Folowtype.add({'id': item.id, 'name': item.name});
//         }
//         setState(() {});
//       } else {
//         print('Request failed with status: ${response.statusCode}');
//         print('Response Data: ${response.body}');
//       }
//     } catch (e) {
//       print('Error: $e');
//     }
//   }

//   Future<void> vixiter() async {
//     final response = await http.get(
//         Uri.parse('http://lms.muepetro.com/api/UserController1/GetProspect'));

//     if (response.statusCode == 200) {
//       final List<dynamic> decodedList = json.decode(response.body);
//       final List<Map<String, dynamic>> mappedList =
//           List<Map<String, dynamic>>.from(decodedList);

//       setState(() {
//         dateList = mappedList;
//         if (dateList.isNotEmpty) {
//           selectedVisitorName = dateList[0]['customer_Name'];
//           selectedVisitorId = dateList[0]['id'];
//         }
//       });
//     } else {
//       throw Exception('Failed to load data');
//     }
//   }

//   void postFollowUp(BuildContext context) async {
//     print(1);
//     final String apiUrl =
//         "http://lms.muepetro.com/api/UserController1/PostFollowUp";
//     Map<String, dynamic> followUpData = {
//       "Location_Id": 12,
//       "Prefix_Name": "online",
//       "Ref_No": int.parse(RefController.text),
//       "Customer_Name": ContactController.text.toString(),
//       "Contacted_Date": datepickar.text.toString(),
//       "Contacted_Time": "${selectedTime2.hour}:${selectedTime2.minute}",
//       "Follow_Type": followupid,
//       "Appointment_Date": datepickar2.text.toString(),
//       "Appointment_Time": "${selectedTime1.hour}:${selectedTime1.minute}",
//       "Remarks": RemarksController.text.toString(),
//       "Remark_Special": splController.text.toString(),
//       "ActionTaken": "ActionTaken",
//       "Priority": selectedPrionaityId,
//       "EnquiryStatus": 1,
//       "Reason": "Reason",
//       "VehiclePurchase": "VehiclePurchase"
//     };
//     print(followUpData);
//     print(2);
//     try {
//       final response = await http.post(
//         Uri.parse(apiUrl),
//         headers: {
//           "Content-Type": "application/json",
//         },
//         body: jsonEncode(followUpData),
//       );
//       print(3);
//       if (response.statusCode == 200) {
//         print("Follow-up posted successfully");
//         print(response.body);
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text("Follow-up posted successfully"),
//             backgroundColor: Colors.green,
//           ),
//         );
//         print(4);
//       } else {
//         print("Error posting follow-up: ${response.statusCode}");
//         print(response.body);
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text("Error posting follow-up: ${response.statusCode}"),
//             backgroundColor: Colors.red,
//           ),
//         );
//       }
//       print(5);
//     } catch (e) {
//       print("Exception during follow-up post: $e");
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text("Exception during follow-up post: $e"),
//           backgroundColor: Colors.red,
//         ),
//       );
//     }
//   }

//   Future<void> PrefixData() async {
//     print(1);
//     try {
//       final response = await http.get(
//         Uri.parse(
//           'http://lms.muepetro.com/api/UserController1/GetFollowUpData?prefix=Online&refno=${RefController.text}&locationid=2',
//         ),
//       );
//       print(2);

//       if (response.statusCode == 200) {
//         List<dynamic> dataList = json.decode(response.body);

//         if (dataList.isNotEmpty) {
//           Map<String, dynamic> data = dataList[0];

//           setState(() {
//             ContactController.text = data['customer_Name'] ?? '';
//             RemarksController.text = data['remarks'] ?? '';
//             splController.text = data['remark_Special'] ?? '';
//             selectedPrionaityId = data['priority'];
//             followupid = data['follow_Type'];
//             selectedValue = Prionaity.firstWhere(
//               (item) => item['id'] == selectedPrionaityId,
//               orElse: () => Prionaity[0],
//             );
//             selectedfollowupValue = Folowtype.firstWhere(
//               (item) => item['id'] == followupid,
//               orElse: () => Folowtype[0],
//             );
//             selectedvixiterValue = dateList.firstWhere(
//               (item) => item['id'] == selectedVisitorId,
//               orElse: () => dateList[0],
//             );

//             print(selectedPrionaityId);
//             print(3);
//           });
//         } else {
//           ContactController.clear();
//           RemarksController.clear();
//           splController.clear();

//           print("Empty data list");
//         }
//       } else {
//         throw Exception('Failed to load data');
//       }
//       print(4);
//     } catch (error) {
//       print('Error: $error');
//     }
//   }
// }
