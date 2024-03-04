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
  TextEditingController RefController = TextEditingController();
  TextEditingController BlankController = TextEditingController();
  TextEditingController splController = TextEditingController();
  TextEditingController ActionController = TextEditingController();
  TextEditingController ContactController = TextEditingController();
  TextEditingController ContactnumbarController = TextEditingController();
  TextEditingController RemarksController = TextEditingController();
  TextEditingController _appointmentDate = TextEditingController(
    text: DateFormat('yyyy/MM/dd').format(DateTime.now()),
  );
  List<Map<String, dynamic>> dateList = [];
  String ? selectedVisitorName ;
  Map<String, dynamic>? selectedcustomerValue;
  // int customerId = 0;
  final TextEditingController customerController = TextEditingController();
  // int? selectedPrionaityId;
  int? selectedVisitorId;
  

//Priority
  List<Map<String, dynamic>> priorityList = [ {'id': 0, 'name': 'Cold'},{'id': 1, 'name': 'Normal'},{'id': 2, 'name': 'Hot'}];
  int selectedPriorityId = 0;
  String  selectedPriorityName  = 'Cold';
  //
  List<Map<String, dynamic>> Folowtype = [ ];
  // String? selectedFolowtypeName;
  // int? selectedFolowtypeId;
  Map<String, dynamic>? selectedfollowupValue;
  int? followupid;
  final TextEditingController FollowupController = TextEditingController();
  // int? selectedPrionaityId;
  //

  String conttact = "";
  String remark = "";
  String page = "";
  String time = '';
  List<Map<String, String>> dataList = [];
  @override

  // void updateTableValues() {
  //   setState(() {
  //     conttact = ContactController.text;
  //     remark = RemarksController.text;
  //     page = datepickar.text;
  //          Map<String, String> newData = {
  //       'Name': conttact,
  //       'Age': remark,
  //       'Page': page,
  //       'time': time
  //     };
  //     dataList.add(newData);
  //   });
  // }

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
    followtypeDeta();
    customer();
    PrefixData();
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      _selectedTime = TimeOfDay.now();
      startTimer();
      refreshData();
    });
    RefController.text = widget.refnom == null ? "" : widget.refnom.toString();
    
  }

  @override
  void dispose() {
    splController.clear();
    RemarksController.clear();

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
        child: dateList.isEmpty
                  ? Center(
          child: CircularProgressIndicator(),  )
                  :SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  vertical: Sizes.height * 0.02,
                  horizontal: Sizes.width * 0.04),
              child: Column(
                children: [
                  textformfiles(RefController,
                      keyboardType: TextInputType.number, onChanged: (e) {
                    setState(() {
                      PrefixData();
                    });
                  }, labelText: "Ref.No"),
                  SizedBox(height: Sizes.height * 0.02),
                     dropdownTextfield(
                          'Select customer',
                          searchDropDown(
                            'Select customer',
                            dateList
                                .map((item) => DropdownMenuItem(
                                      onTap: () {
                                        selectedVisitorId = item['id'];
                                      },
                                      value: item,
                                      child: Text(
                                        item['customer_Name'].toString(),
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ))
                                .toList(),
                            selectedcustomerValue,
                            (value) {
                              setState(() {
                                selectedcustomerValue = value;
                              });
                            },
                            customerController,
                            (value) {
                              setState(() {
                                // Filter the Prionaity list based on the search value
                                dateList
                                    .where((item) => item['customer_Name']
                                        .toString()
                                        .toLowerCase()
                                        .contains(value.toLowerCase()))
                                    .toList();
                              });
                            },
                            "Search for a customer...",
                            (isOpen) {
                              if (!isOpen) {
                                customerController.clear();
                              }
                            },
                          ),
                        ),
                          SizedBox(
                    height: Sizes.height * 0.02,
                  ),
                textformfiles(ContactnumbarController,keyboardType: TextInputType.number,labelText: "Contact Numbar",maxLength: 10),
                  SizedBox(height: Sizes.height * 0.02),
                  textformfiles(splController, labelText: "Spl.Remarks"),
                  SizedBox(height: Sizes.height * 0.02),
                  textformfiles(RemarksController, labelText: "Remarks"),
                  SizedBox(height: Sizes.height * 0.02),
                  dropdownTextfield(
                  "Priority",
                  DropdownButton<int>(
      value: selectedPriorityId,
      onChanged: (newValue) {
        setState(() {
          selectedPriorityId = newValue!;
        });
        // Call your API with the selected ID
        print('Selected ID: $selectedPriorityId');
      },
      items: priorityList.map<DropdownMenuItem<int>>((Map<String, dynamic> item) {
        return DropdownMenuItem<int>(
          value: item['id'],
          child: Text(item['name']),
        );
      }).toList(),
    )
           ),
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
                              firstDate: DateTime(1900),
                              lastDate: DateTime.now(),
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
                        // ContactController.clear();
                        // RemarksController.clear();
                        // datepickar.clear();
                      },
                      child: Button("Save", AppColor.colPrimary)),
                  SizedBox(
                    height: Sizes.height * 0.02,
                  ),
                  Button("Delete", AppColor.colRideFare),
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
        print('Request failed with status: ${response.statusCode}');
        print('Response Data: ${response.body}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> customer() async {
    final response = await http.get(
        Uri.parse('http://lms.muepetro.com/api/UserController1/GetProspect'));

    if (response.statusCode == 200) {
      final List<dynamic> decodedList = json.decode(response.body);
      final List<Map<String, dynamic>> mappedList =
          List<Map<String, dynamic>>.from(decodedList);

      setState(() {
        dateList = mappedList;
        if (dateList.isNotEmpty) {
          selectedVisitorName = dateList[0]['customer_Name'];
          selectedVisitorId = dateList[0]['id'];
        }
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  void postFollowUp(BuildContext context) async {
    print(1);
    final String apiUrl =
        "http://lms.muepetro.com/api/UserController1/PostFollowUp";
    Map<String, dynamic> followUpData = {
      "Location_Id": 12,
      "Prefix_Name": "online",
      "Ref_No": int.parse(RefController.text),
      "Customer_Name": ContactController.text.toString(),
      "Contacted_Date": DateFormat('yyyy/MM/dd').format(DateTime.now()),
      "Contacted_Time": "${TimeOfDay.now().hour}:${TimeOfDay.now().minute}",
      "Follow_Type": followupid,
      "Appointment_Date": _appointmentDate.text.toString(),
      "Appointment_Time": "${_selectedTime.hour}:${_selectedTime.minute}",
      "Remarks": RemarksController.text.toString(),
      "Remark_Special": splController.text.toString(),
      "ActionTaken": "ActionTaken",
      "Priority": selectedPriorityId,
      "EnquiryStatus": 1,
      "Reason": "Reason",
      "VehiclePurchase": "VehiclePurchase"
    };
    print(followUpData);
    print(2);
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode(followUpData),
      );
      print(3);
      if (response.statusCode == 200) {
        print(response.body);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(response.body),
            backgroundColor: Colors.green,
          ),
        );
        print(4);
      } else {
        print("Error posting follow-up: ${response.statusCode}");
        print(response.body);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Error posting follow-up: ${response.statusCode}"),
            backgroundColor: Colors.red,
          ),
        );
      }
      print(5);
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
    print(1);
    try {
      final response = await http.get(
        Uri.parse('http://lms.muepetro.com/api/UserController1/GetFollowUpData?prefix=Online&refno=${RefController.text}&locationid=2'),
      );

      if (response.statusCode == 200) {
        List<dynamic> dataList = json.decode(response.body);

        if (dataList.isNotEmpty) {
          Map<String, dynamic> data = dataList[0];

          setState(() {
            ContactController.text = data['customer_Name'] ?? '';
            ContactnumbarController.text = data['mob_No'] ?? '';
            RemarksController.text = data['remarks'] ?? '';
            splController.text = data['remark_Special'] ?? '';
            selectedPriorityId = data['priority'];
            followupid = data['follow_Type'];
            selectedVisitorId = 76;
            selectedPriorityName = priorityList.firstWhere(
              (item) => item['id'] == selectedPriorityId,
              orElse: () => priorityList[0],
            ) as String;
            selectedfollowupValue = Folowtype.firstWhere(
              (item) => item['id'] == followupid,
              orElse: () => Folowtype[0],
            );
            selectedcustomerValue = dateList.firstWhere(
              (item) => item['id'] == selectedVisitorId,
              orElse: () => dateList[0],
            );
          });
        } else {
          ContactController.clear();
          RemarksController.clear();
          splController.clear();
          print("Empty data list");
        }
      } else {
        throw Exception('Failed to load data');
      }
      print(4);
    } catch (error) {
      print('Error: $error');
    }
  }
}
