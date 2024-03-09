// ignore_for_file: prefer_const_declarations, override_on_non_overriding_member, non_constant_identifier_names, prefer_const_constructors, duplicate_ignore, must_be_immutable, avoid_print, use_build_context_synchronously

import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:autowheelweb/Components/menuController.dart';
import 'package:autowheelweb/Utils/colors.dart';
import 'package:autowheelweb/Utils/mediaquery.dart';
import 'package:autowheelweb/Utils/responsive.dart';
import 'package:autowheelweb/Utils/textfield.dart';
import 'package:autowheelweb/Utils/textstyle.dart';
import 'package:autowheelweb/model/group.dart';
import 'package:autowheelweb/model/prospect_modal.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class FollowUpScreen extends StatefulWidget {
  final String? refnom;
  bool value = true;
  FollowUpScreen({super.key, this.refnom, required this.value});
  @override
  State<FollowUpScreen> createState() => _FollowUpScreenState();
}

class _FollowUpScreenState extends State<FollowUpScreen> {
  final TextEditingController _refController = TextEditingController();
  final TextEditingController _splController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();
  final TextEditingController _contactnumberController = TextEditingController();
  final TextEditingController _remarksController = TextEditingController();
  final TextEditingController _appointmentDate = TextEditingController(
    text: DateFormat('yyyy/MM/dd').format(DateTime.now()),
  );
  // List<Map<String, dynamic>> customerdataList = [];
  // Map<String, dynamic>? selectedcustomerValue;
  // final TextEditingController customerController = TextEditingController();
  // int? selectedVisitorId;

  //Priority
   final List<Map<String, dynamic>> priorityDataList = [ {'id': 0, 'name': 'Cold'},{'id': 1, 'name': 'Normal'},{'id': 2, 'name': 'Hot'}];
  int selectedPriorityId = 0;

//Data
List getAllRemarkList = [];

  //Follow Type
  List<Map<String, dynamic>> Folowtype = [ ];
  Map<String, dynamic>? selectedfollowupValue;
  int? followupid;
  final TextEditingController FollowupController = TextEditingController();

  //


  List<Map<String, String>> dataList = [];
  late TimeOfDay _selectedTime = TimeOfDay.now();
  Future<void> contactTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  void startTimer() {
    // ignore: prefer_const_constructors
    Timer.periodic(Duration(minutes: 1), (Timer timer) {
      setState(() {
        _selectedTime = TimeOfDay.now();
      });
    });
  }

  refreshData() async {
    await
    followtypeDeta();
    // customer();
    PrefixData();
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      _selectedTime = TimeOfDay.now();
      startTimer();
      followtypeDeta();
      // customer();
      refreshData();
    });
    _refController.text = widget.refnom == null ? "" : widget.refnom.toString();
    // Prionaity.clear();
    // Prionaity.add({'id': 0, 'name': 'Prionaity'});
    // prionaityDeta().then((_) {
    //   setState(() {
    //     selectedValue = Prionaity.firstWhere(
    //       (item) => item['id'] == selectedPrionaityId,
    //       orElse: () => Prionaity[0],
    //     );
      // });
    // });
  }

  @override
  void dispose() {
    _splController.clear();
    _remarksController.clear();
    _contactnumberController.clear();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: widget.value
            ? (!Responsive.isDesktop(context))
                ? IconButton(
                    onPressed: context.read<MenuControlle>().controlMenu,
                    icon: const Icon(Icons.menu),
                  )
                : Container()
            : IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back_ios_new)),
        centerTitle: true,
        backgroundColor: AppColor.colPrimary,
        title: Text(
          "Follow Up",
          style: TextStyle(color: AppColor.colWhite),
        ),
        ),
      backgroundColor: AppColor.colWhite,
      body:  Container(
        height: Sizes.height,
        color: AppColor.colPrimary.withOpacity(.1),
        child: 
        // customerdataList.isEmpty
        //           ? Center(
        //   child: CircularProgressIndicator(),  )
                  // :
                  SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  vertical: Sizes.height * 0.02,
                  horizontal: Sizes.width * 0.04),
              child: Column(
                children: [
                  textformfiles(_refController,
                      keyboardType: TextInputType.number, onChanged: (e) {
                    setState(() {
                      PrefixData();
                    });
                  }, labelText: "Ref.No"),
                  SizedBox(height: Sizes.height * 0.02),
                    //  dropdownTextfield(
                    //       'Select customer',
                    //       searchDropDown(
                    //         'Select customer',
                    //         customerdataList
                    //             .map((item) => DropdownMenuItem(
                    //                   onTap: () {
                    //                     selectedVisitorId = item['id'];
                    //                   },
                    //                   value: item,
                    //                   child: Text(
                    //                     item['customer_Name'].toString(),
                    //                     style: const TextStyle(
                    //                         fontSize: 16,
                    //                         fontWeight: FontWeight.bold),
                    //                   ),
                    //                 ))
                    //             .toList(),
                    //         selectedcustomerValue,
                    //         (value) {
                    //           setState(() {
                    //             selectedcustomerValue = value;
                    //           });
                    //         },
                    //         customerController,
                    //         (value) {
                    //           setState(() {
                    //             // Filter the Prionaity list based on the search value
                    //             customerdataList
                    //                 .where((item) => item['customer_Name']
                    //                     .toString()
                    //                     .toLowerCase()
                    //                     .contains(value.toLowerCase()))
                    //                 .toList();
                    //           });
                    //         },
                    //         "Search for a customer...",
                    //         (isOpen) {
                    //           if (!isOpen) {
                    //             customerController.clear();
                    //           }
                    //         },
                    //       ),
                    //     ),
                       textformfiles(_contactController,labelText: "Customer Name",maxLength: 10),
               
                          SizedBox(
                    height: Sizes.height * 0.02,
                  ),
                textformfiles(_contactnumberController,keyboardType: TextInputType.number,labelText: "Contact Number",maxLength: 10),
                  SizedBox(height: Sizes.height * 0.02),
                  textformfiles(_splController, labelText: "Special Remarks"),
                  SizedBox(height: Sizes.height * 0.02),
                  textformfiles(_remarksController, labelText: "Remarks"),
                  SizedBox(height: Sizes.height * 0.02),
                dropdownTextfield(
                  "Priority",
                 DropdownButton<Map<String, dynamic>>(
                underline: Container(),
                value: priorityDataList.firstWhere((item) => item['id'] == selectedPriorityId),
              items: priorityDataList.map((data) {
                return DropdownMenuItem<Map<String, dynamic>>(
                  value: data,
                  child: Text(data['name'],
        style: rubikTextStyle(16, FontWeight.w500, AppColor.colBlack),),
                );
              }).toList(), icon: Icon(
      Icons.keyboard_arrow_down_outlined
    ),
    isExpanded: true,
    
              onChanged: (selectedId) {
                setState(() {
                  selectedPriorityId = selectedId!['id'];
                  log(selectedPriorityId.toString());
                  // Call function to make API request
                });
              },
            ),  ),
                   SizedBox(height: Sizes.height * 0.02),
                  Row(
                    children: [
                       Expanded(
                              child: dropdownTextfield(
                                "Select Follow Up",
                                searchDropDown('Select Follow Up', Folowtype.map((item) => DropdownMenuItem(
                                          onTap: () {
                                            followupid = item['id'];
                                          },
                                          value: item,
                                          child: Text(
                                            item['name'].toString(),
                                            style: rubikTextStyle(
                                                16,
                                                FontWeight.w500,
                                                AppColor.colBlack),
                                          ),
                                        )).toList(), selectedfollowupValue,(value) {
                                      setState(() {
                                        selectedfollowupValue = value;
                                      });
                                    }, FollowupController, (value) {
                                            setState(() {
                                              // Filter the Prionaity list based on the search value
                                              Folowtype.where((item) => item['name']
                                                      .toString()
                                                      .toLowerCase()
                                                      .contains(
                                                          value.toLowerCase()))
                                                  .toList();
                                            });
                                          }, 'Search for a Follow Up...', (isOpen) {
                                      if (!isOpen) {
                                        FollowupController.clear();
                                      }
                                    },
                                  ),
                                ),
                              ),
                           SizedBox(width: Sizes.width * 0.02),
                      addDefaultButton(
                        () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AddGroupScreen(
                                        sourecID: 18,
                                        name: "Follow Up",
                                      ))).then((value) => refreshData());
                        },
                      )
                    ],
                  ),
                  SizedBox(height: Sizes.height * 0.02),
                  Row(
                    children: [
                      Expanded(
                          child: dropdownTextfield(
                        "Appointment Date",
                        InkWell(
                          onTap: () async {
                            FocusScope.of(context).requestFocus(FocusNode());
                            await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime.now(),
                              lastDate: DateTime(2100),
                            ).then((selectedDate) {
                              if (selectedDate != null) {
                                _appointmentDate.text = DateFormat('dd-MM-yyyy')
                                    .format(selectedDate);
                              }
                            });
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                _appointmentDate.text,
                                style: rubikTextStyle(
                                    16, FontWeight.w500, AppColor.colBlack),
                              ),
                              Icon(Icons.edit_calendar,
                                  color: AppColor.colBlack)
                            ],
                          ),
                        ),
                      )),
                      SizedBox(width: Sizes.width * 0.04),
                      Expanded(
                          child: dropdownTextfield(
                        "Appointment Time",
                        InkWell(
                          onTap: () {
                            contactTime(context);
                          },
                          child: Center(
                            child: Text(
                              _selectedTime.format(context),
                              style: rubikTextStyle(
                                  16, FontWeight.w500, AppColor.colBlack),
                            ),
                          ),
                        ),
                      ))
                    ],
                  ),
                  SizedBox(height: Sizes.height * 0.02),
                  InkWell(
                      onTap: () {
                        postFollowUp(context);
                        // updateTableValues();
                        // _contactController.clear();
                        // _remarksController.clear();
                        // datepickar.clear();
                      },
                      child: Button("Save", AppColor.colPrimary)),
                  SizedBox(
                    height: Sizes.height * 0.02
                  ),
                  Button("Delete", AppColor.colRideFare),
                   SizedBox(
                    height: Sizes.height * 0.02
                  ),
                ...List.generate(getAllRemarkList.length, (index) {
                  return ListTile(
            leading:Text("${index+1}"),
            title:Text("Last Remark : ${getAllRemarkList[index]['remarks']}"),
            trailing: Text('${getAllRemarkList[index]['contacted_Date']}'.substring(0, getAllRemarkList[index]['lastContact_Date'].length!=null?getAllRemarkList[index]['lastContact_Date'].length - 12:0)),
                  );
                })
                ],
              ),
            ),
          ),
      ),
    );
  }

  Future<void> followtypeDeta() async {
    final url = Uri.parse(
        'http://lms.muepetro.com/api/UserController1/GetMiscMaster?MiscTypeId=18');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final List<Goruppartmodel> goruppartmodelList =
            grouppartmodelFromJson(response.body);

          Folowtype.clear();
        for (var item in goruppartmodelList) {
          Folowtype.add({'id': item.id, 'name': item.name});
        }
        setState(() {});
      } else {
        print('Response Data: ${response.body}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  // Future<void> customer() async {
  //   final response = await http.get(
  //       Uri.parse('http://lms.muepetro.com/api/UserController1/GetProspect'));

  //   if (response.statusCode == 200) {
  //     final List<dynamic> decodedList = json.decode(response.body);
      
  //     getAlldataList = decodedList;
  //     final List<Map<String, dynamic>> mappedList =
  //         List<Map<String, dynamic>>.from(decodedList);

  //     setState(() {
  //       customerdataList = mappedList;
  //       if (customerdataList.isNotEmpty) {
  //         // selectedVisitorName = customerdataList[0]['customer_Name'];
  //         selectedVisitorId = customerdataList[0]['id'];
  //       }
  //     });
  //   } else {
  //     throw Exception('Failed to load data');
  //   }
  // }


  void postFollowUp(BuildContext context) async {
    final String apiUrl =
        "http://lms.muepetro.com/api/UserController1/PostFollowUp";
    Map<String, dynamic> followUpData = {
      "Location_Id": 12,
      "Prefix_Name": "online",
      "Ref_No": int.parse(_refController.text),
      "Customer_Name": _contactController.text.toString(),
      "Contacted_Date": DateFormat('yyyy/MM/dd').format(DateTime.now()),
      "Contacted_Time": "${TimeOfDay.now().hour}:${TimeOfDay.now().minute}",
      "Follow_Type": followupid,
      "Appointment_Date": _appointmentDate.text.toString(),
      "Appointment_Time": "${_selectedTime.hour}:${_selectedTime.minute}",
      "Remarks": _remarksController.text.toString(),
      "Remark_Special": _splController.text.toString(),
      "ActionTaken": "Not Set Yet",
      "Priority": selectedPriorityId,
      "EnquiryStatus": 1,
      "Reason": "Not Set Yet",
      "VehiclePurchase": "Not Set Yet"
    };
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode(followUpData),
      );
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(response.body),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Error posting follow-up: ${response.statusCode}"),
            backgroundColor: Colors.red,
          ),
        );
      }
        } catch (e) {
      print("Exception during follow-up post: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Exception during follow-up post: $e"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> PrefixData() async {
    try {
      final response = await http.get(
        Uri.parse('http://lms.muepetro.com/api/UserController1/GetFollowUpData?prefix=Online&refno=${_refController.text}&locationid=1'),
      );

      if (response.statusCode == 200) {
        List<dynamic> dataList = json.decode(response.body);

        if (dataList.isNotEmpty) {
               getAllRemarkList = dataList;
          Map<String, dynamic> data = dataList[0];

          setState(() {
            _contactController.text = data['customer_Name'] ?? '';
            _contactnumberController.text = data['mob_No'] ?? '';
            _remarksController.text = data['remarks'] ?? '';
            _splController.text = data['remark_Special'] ?? '';
            selectedPriorityId = int.parse(data['priority'])??0;
            followupid = data['follow_Type'];
            // selectedVisitorId = 76;
            selectedfollowupValue = Folowtype.firstWhere(
              (item) => item['id'] == followupid,
              orElse: () => Folowtype[0],
            );
            // selectedcustomerValue = customerdataList.firstWhere(
            //   (item) => item['id'] == selectedVisitorId,
            //   orElse: () => customerdataList[0],
            // );
          });
        } else {
          _contactController.clear();
          _remarksController.clear();
          _splController.clear();
          _contactnumberController.clear();
        }
      } else {
        throw Exception('Failed to load data');
      }
    } catch (error) {
      print('Error: $error');
    }
  }
}
