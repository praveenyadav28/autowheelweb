// ignore_for_file: unused_import, unnecessary_import, unnecessary_type_check, unnecessary_null_comparison, unused_local_variable, prefer_const_constructors_in_immutables, non_constant_identifier_names, prefer_typing_uninitialized_variables, avoid_print, use_build_context_synchronously, empty_catches
import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:autowheelweb/Components/menuController.dart';
import 'package:autowheelweb/Utils/Colors.dart';
import 'package:autowheelweb/Utils/api.dart';
import 'package:autowheelweb/Utils/mediaquery.dart';
import 'package:autowheelweb/Utils/responsive.dart';
import 'package:autowheelweb/Utils/textfield.dart';
import 'package:autowheelweb/Utils/textstyle.dart';
import 'package:autowheelweb/model/group.dart';
import 'package:autowheelweb/model/prospect_modal.dart';
import 'package:csc_picker/csc_picker.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';

class ProspectScreen extends StatefulWidget {
  ProspectScreen({super.key});
  @override
  State<ProspectScreen> createState() => _ProspectScreenState();
}

class _ProspectScreenState extends State<ProspectScreen> {
  String countryValue = "";
  String stateValue = "";
  String cityValue = "";
  var ischack = false;
  final TextEditingController _customernameController = TextEditingController();
  final TextEditingController _sonoffController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _pinController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _schemeController = TextEditingController();
  final TextEditingController _incomeController = TextEditingController();
  final TextEditingController _intrestedremarksController = TextEditingController();
  final TextEditingController _lastRemarkController = TextEditingController();
  final TextEditingController _testRemarkController = TextEditingController();
  final TextEditingController _specialRemarkController = TextEditingController();


//Date
  TextEditingController refDatePicker = TextEditingController(
    text: DateFormat('M/d/yyyy').format(DateTime.now()),
  );
  TextEditingController dobDatePicker = TextEditingController(
    text: DateFormat('M/d/yyyy').format(DateTime.now()),
  );

  TextEditingController rideDatePickar = TextEditingController(
    text: DateFormat('M/d/yyyy').format(DateTime.now()),
  );
  TextEditingController appointmentDatePickar = TextEditingController(
    text: DateFormat('M/d/yyyy').format(DateTime.now()),
  );


  List<Map<String, dynamic>> drop = [  ];
  int? selecteddropId;
  Map<String, dynamic>? selecteddropValue;
  final TextEditingController dropController = TextEditingController();

  List<Map<String, dynamic>> color = [  ];
  int? selectedcolorsId;
  Map<String, dynamic>? selectedcolorValue;
  final TextEditingController colorController = TextEditingController();
  final TextEditingController color2Controller = TextEditingController();

  List<Map<String, dynamic>> Enqtype = [  ];
  int? selectedEnqtypeId;
  Map<String, dynamic>? selectedEnqtypeValue;
  final TextEditingController EnqtypeController = TextEditingController();

  List<Map<String, dynamic>> Occuption = [  ];
  int? selectedOccuptionId;
  Map<String, dynamic>? selectedOccuptionValue;
  final TextEditingController OccuptionController = TextEditingController();

final TextEditingController testController = TextEditingController();


  List<Map<String, dynamic>> Prionaity = [  ];
  int? selectedPrionaityId;
  String? selectedPrionaityName;
  // final TextEditingController priorityController = TextEditingController();
  List<Map<String, dynamic>> product = [  ];
  String? selectedproductName;
  int? selectedproductId;
  List<Map<String, dynamic>> Test = [  ];
  Map<String, dynamic>? selectedtestValue;
  int? testId;

  List<Map<String, dynamic>> title = [ {'id': 0, 'name': 'Mr.'},{'id': 1, 'name': 'Mrs.'},{'id': 2, 'name': 'Dr.'},{'id': 3, 'name': 'M/S'}];
  String selectedtitleName = "Mr.";
  int selectedtitleId = 0;

  List<String> options = [];
  List<Staffmodel> staffList = [];
  String staffName = "John Doe";
  String selectedStaffId = '';


  //Time
  late TimeOfDay selectedTimeRefence;
  late TimeOfDay selectedTimeAppointment;
  Future<void> _selectTimeReference(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTimeRefence,
    );
    if (picked != null && picked != selectedTimeRefence) {
      setState(() {
        selectedTimeRefence = picked;
      });
    }
  }
  Future<void> _selectTimeAppointment(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTimeAppointment,
    );
    if (picked != null && picked != selectedTimeAppointment) {
      setState(() {
        selectedTimeAppointment = picked;
      });
    }
  }
  void startTimer() {
    Timer.periodic(const Duration(minutes: 1), (Timer timer) {
      setState(() {
        selectedTimeRefence = TimeOfDay.now();
        selectedTimeAppointment = TimeOfDay.now();
      });
    });
  }


  List<String> datailsList1 = [];
  bool isLoading = false;
  TextEditingController refController = TextEditingController();
  int ? locationId;
  List<Map<String, dynamic>> locationList = [];
  @override
  void initState() {
    super.initState();
    selectedTimeRefence = TimeOfDay.now();
    selectedTimeAppointment = TimeOfDay.now();
    startTimer();
    location();
    staff();
    sourceData();
    colorData();
    enqtypeData();
    occuptionData();
    prionaityData();
    productData();
    testData();
    _fetchRefNo();
  }

  refreshData() {
    sourceData();
    colorData();
    enqtypeData();
    occuptionData();
    prionaityData();
    productData();
    testData();
    _fetchRefNo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(  leading:
         (!Responsive.isDesktop(context))
            ? IconButton(
                onPressed: context.read<MenuControlle>().controlMenu,
                icon:   const Icon(Icons.menu))
            :  Container(),
        centerTitle: true,
        backgroundColor: AppColor.colPrimary,
        title: Text(
          "Prospect Masters",
          style: TextStyle(color: AppColor.colWhite),
        ),
      ),
      backgroundColor: AppColor.colPrimary.withOpacity(.1),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: Sizes.height * 0.02, horizontal: Sizes.width * 0.04),
          child: Column(
            children: [
              dropdownTextfield(
                "Select Location",
                localDropdownButton("Select a Location",
                  context,
                  locationId,
                  locationList.map((value) {
                    return DropdownMenuItem(
                      value: value['id'],
                      child: Text(
                        '${value['location_Name']}',
                        style: rubikTextStyle(
                            16, FontWeight.w500, AppColor.colBlack),
                      ),
                    );
                  }).toList(),
                  (value) {
                    setState(() {
                      locationId = value as int;
                      _fetchRefNo(); // Fetch reference number after location selection
                    });
                  },
                ),
              ),
              SizedBox(height: Sizes.height * 0.02),
              textformfiles(
                refController,
                keyboardType: TextInputType.number,
                readOnly: true,
                labelText: "Reference No",
              ),
              SizedBox(height: Sizes.height * 0.02),
              Row(
                children: [
                  Expanded(
                      child: dropdownTextfield(
                    "Date of Reference",
                    InkWell(
                      onTap: () async {
                        DateTime date = DateTime(1900);
                        FocusScope.of(context).requestFocus(FocusNode());
                        await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1900),
                          lastDate: DateTime.now(),
                        ).then((selectedDate) {
                          if (selectedDate != null) {
                            refDatePicker.text =
                                DateFormat('M/d/yyyy').format(selectedDate);
                          }
                        });
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            refDatePicker.text,
                            style: rubikTextStyle(
                                16, FontWeight.w500, AppColor.colBlack),
                          ),
                          Icon(Icons.edit_calendar, color: AppColor.colBlack)
                        ],
                      ),
                    ),
                  )),
                  SizedBox(width: Sizes.width * 0.04),
                  Expanded(
                      child: dropdownTextfield(
                    "Time of Reference",
                    InkWell(
                      onTap: () {
                        _selectTimeReference(context);
                      },
                      child: Center(
                        child: Text(
                          selectedTimeRefence.format(context),
                          style: rubikTextStyle(
                              16, FontWeight.w500, AppColor.colBlack),
                        ),
                      ),
                    ),
                  ))
                ],
              ),
              SizedBox(height: Sizes.height * 0.02),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: dropdownTextfield(
                        "Title",
                        localDropdownButton("",
                            context,
                            selectedtitleName,
                            title.map((item) {
                              return DropdownMenuItem(
                                value: item['name'],
                                child: Text(
                                  item['name'],
                                  style: rubikTextStyle(
                                      16, FontWeight.w500, AppColor.colBlack),
                                ),
                              );
                            }).toList(), (value) {
                          setState(() {
                            selectedtitleName = value.toString();
                            selectedtitleId = title
                                    .firstWhere((item) => item['name'] == value)
                                    .containsKey('id')
                                ? title.firstWhere(
                                    (item) => item['name'] == value)['id']
                                : null;
                            log(selectedtitleId.toString());
                          });
                        })),
                  ),
                  SizedBox(width: Sizes.width * 0.04),
                  Expanded(
                    flex: 5,
                    child:
                        textformfiles(_customernameController, labelText: "Customer Name"),
                  ),
                ],
              ),
              SizedBox(height: Sizes.height * 0.02),
              textformfiles(_sonoffController, labelText: "S/o"),
              SizedBox(height: Sizes.height * 0.02),
              textformfiles(_addressController, labelText: "Address"),
              SizedBox(height: Sizes.height * 0.02),
              CSCPicker(
                showStates: true,
                showCities: true,
                defaultCountry: CscCountry.India,
                dropdownDecoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                    color: AppColor.colWhite,
                    border: Border.all(
                      width: 1,
                      color: AppColor.colBlack
                    )),
                disabledDropdownDecoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                    color: AppColor.colWhite,
                    border: Border.all(color: AppColor.colBlack, width: 1)),
                countryDropdownLabel: "Select Country",
                stateDropdownLabel: "Select State",
                cityDropdownLabel: "Select City",
                selectedItemStyle:
                    rubikTextStyle(16, FontWeight.w500, AppColor.colBlack),
                dropdownHeadingStyle: TextStyle(
                    color: AppColor.colBlack,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
                dropdownItemStyle: TextStyle(
                  color: AppColor.colBlack,
                  fontSize: 14,
                ),
                dropdownDialogRadius: 10.0,
                searchBarRadius: 10.0,
                onCountryChanged: (value) {
                  setState(() {
                    cityValue;
                    cityValue;
                    "City";
                    countryValue = value;
                  });
                },
                onStateChanged: (value) {
                  setState(() {
                    stateValue = stateValue;
                  });
                },
                onCityChanged: (value) {
                  setState(() {
                    cityValue = countryValue;
                  });
                },
              ),
              SizedBox(height: Sizes.height * 0.02),
              textformfiles(_pinController,
                  labelText: "Pin Code", keyboardType: TextInputType.number),
              SizedBox(height: Sizes.height * 0.02),
              textformfiles(_mobileController,
                  labelText: "Mobile Number", keyboardType: TextInputType.number),
              SizedBox(height: Sizes.height * 0.02),
              textformfiles(_emailController,
                  keyboardType: TextInputType.emailAddress, labelText: "Email"),
              SizedBox(height: Sizes.height * 0.02),
              dropdownTextfield(
                "Date of Birth",
                InkWell(
                  onTap: () async {
                    DateTime date = DateTime(1900);
                    FocusScope.of(context).requestFocus(FocusNode());
                    await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1900),
                      lastDate: DateTime.now(),
                    ).then((selectedDate) {
                      if (selectedDate != null) {
                        dobDatePicker.text =
                            DateFormat('M/d/yyyy').format(selectedDate);
                      }
                    });
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        dobDatePicker.text,
                        style: rubikTextStyle(
                            16, FontWeight.w500, AppColor.colBlack),
                      ),
                      Icon(Icons.edit_calendar, color: AppColor.colBlack)
                    ],
                  ),
                ),
              ),
              SizedBox(height: Sizes.height * 0.02),
              Row(
                children: [
                  Expanded(
                    child: dropdownTextfield(
                        'Select Enquery Type',
                        searchDropDown(
                            'Select Enquery Type',
                            Enqtype.map((item) => DropdownMenuItem(
                                  onTap: () {
                                    selectedEnqtypeId = item['id'];
                                  },
                                  value: item,
                                  child: Row(
                                    children: [
                                      Text(
                                        item['name'].toString(),
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                )).toList(),
                            selectedEnqtypeValue,
                            (value) {
                              setState(() {
                                selectedEnqtypeValue = value;
                              });
                            },
                            EnqtypeController,
                            (value) {
                              setState(() {
                                // Filter the Prionaity list based on the search value
                                Enqtype.where((item) => item['name']
                                    .toString()
                                    .toLowerCase()
                                    .contains(value.toLowerCase())).toList();
                              });
                            },
                            'Search for a Enqtype...',
                            (isOpen) {
                              if (!isOpen) {
                                EnqtypeController.clear();
                              }
                            })),
                  ),
                  SizedBox(width: Sizes.width * 0.04),
                  addDefaultButton(() {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AddGroupScreen(
                                  sourecID: 18,
                                  name: "Enquiry Type",
                                ))).then((value) => refreshData());
                  })
                ],
              ),
              SizedBox(height: Sizes.height * 0.02),
              Row(
                children: [
                  Expanded(
                    child: dropdownTextfield(
                      "Select Occuption",
                      DropdownButtonHideUnderline(
                          child: searchDropDown(
                              "Select Occuption",
                              Occuption.map((item) => DropdownMenuItem(
                                    onTap: () {
                                      selectedOccuptionId = item['id'];
                                    },
                                    value: item,
                                    child: Row(
                                      children: [
                                        Text(
                                          item['name'].toString(),
                                          style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  )).toList(),
                              selectedOccuptionValue,
                              (value) {
                                setState(() {
                                  selectedOccuptionValue = value;
                                });
                              },
                              OccuptionController,
                              (value) {
                                setState(() {
                                  // Filter the Prionaity list based on the search value
                                  Occuption.where((item) => item['name']
                                      .toString()
                                      .toLowerCase()
                                      .contains(value.toLowerCase())).toList();
                                });
                              },
                              'Search for a Occuption...',
                              (isOpen) {
                                if (!isOpen) {
                                  OccuptionController.clear();
                                }
                              })),
                    ),
                  ),
                  SizedBox(width: Sizes.width * 0.04),
                  addDefaultButton(
                    () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AddGroupScreen(
                                    sourecID: 23,
                                    name: "Occupation",
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
                      "Staff",
                      Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: localDropdownButton( "Select Staff",
                              context,
                              selectedStaffId,
                              options.map<DropdownMenuItem<String>>(
                                (String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(
                                      value,
                                      style: rubikTextStyle(16, FontWeight.w500,
                                          AppColor.colBlack),
                                    ),
                                  );
                                },
                              ).toList(), (var newValue) {
                            setState(() {
                              selectedStaffId = newValue.toString();
                            });
                          })),
                    ),
                  ),
                  SizedBox(width: Sizes.width * 0.04),
                  addDefaultButton(
                    () {
                      showDialog<void>(
                        context: context,
                        barrierDismissible: false, // user must tap button!
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title:
                                const Text('This is no feature to add staff.'),
                            content: const SingleChildScrollView(
                              child: ListBody(
                                children: <Widget>[
                                  Text(
                                      'It will work after some time. For more datails you can contect us'),
                                ],
                              ),
                            ),
                            actions: <Widget>[
                              TextButton(
                                child: const Text('Ok'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                      // Navigator.push(context, MaterialPageRoute(builder: (context) => AddGroupScreen()))
                      //       .then((value) => refreshData());
                    },
                  ),
                ],
              ),
              SizedBox(height: Sizes.height * 0.02),
              Row(
                children: [
                  Expanded(
                    child: dropdownTextfield(
                        "Select Source",
                        searchDropDown(
                            "Select Source",
                            drop
                                .map((item) => DropdownMenuItem(
                                      onTap: () {
                                        selecteddropId = item['id'];
                                      },
                                      value: item,
                                      child: Row(
                                        children: [
                                          Text(
                                            item['name'].toString(),
                                            style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ))
                                .toList(),
                            selecteddropValue,
                            (value) {
                              setState(() {
                                selecteddropValue = value;
                              });
                            },
                            dropController,
                            (value) {
                              setState(() {
                                // Filter the Prionaity list based on the search value
                                drop
                                    .where((item) => item['name']
                                        .toString()
                                        .toLowerCase()
                                        .contains(value.toLowerCase()))
                                    .toList();
                              });
                            },
                            'Search for a Source...',
                            (isOpen) {
                              if (!isOpen) {
                                dropController.clear();
                              }
                            })),
                  ),
                  SizedBox(width: Sizes.width * 0.04),
                  addDefaultButton(
                    () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AddGroupScreen(
                                    sourecID: 10,
                                    name: 'Source',
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
                          "Priority",
                         localDropdownButton( "Select Priority",
                                  context,
                                  selectedPrionaityName,
                                  Prionaity.map((item) {
                                    return DropdownMenuItem(
                                      value: item['name'],
                                      
                                      child: Text(
                                        item['name'],
                                        style: rubikTextStyle(16,
                                            FontWeight.w500, AppColor.colBlack),
                                      ),
                                    );
                                  }).toList(), (value) {
                                setState(() {
                                  selectedPrionaityName = value.toString();
                                  selectedPrionaityId = Prionaity.firstWhere(
                                              (item) => item['name'] == value)
                                          .containsKey('id')
                                      ? Prionaity.firstWhere(
                                          (item) => item['name'] == value)['id']
                                      : null;
                                  log(selectedPrionaityId.toString());
                                });
                              })
                          )),
               
                  SizedBox(width: Sizes.width * 0.04),
                  addDefaultButton(
                    () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AddGroupScreen(
                                    sourecID: 22,
                                    name: 'Priority',
                                  ))).then((value) => refreshData());
                    },
                  )
                ],
              ),
              SizedBox(height: Sizes.height * 0.02),
              textformfiles(_schemeController, labelText: "Scheme"),
              SizedBox(height: Sizes.height * 0.02),
              textformfiles(_incomeController, labelText: "Income"),
              SizedBox(height: Sizes.height * 0.05),
              Text(
                "Intersted in following product",
                style: rubikTextStyle(18, FontWeight.bold, AppColor.colBlack),
              ),
              SizedBox(height: Sizes.height * 0.02),
              Row(
                children: [
                  Expanded(
                      child: dropdownTextfield(
                    "Product",
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: localDropdownButton( "Select Product",
                        context,
                        selectedproductName,
                        product.map((item) {
                          return DropdownMenuItem(
                            value: item['name'],
                            child: Text(
                              item['name'],
                              style: rubikTextStyle(
                                  16, FontWeight.w500, AppColor.colBlack),
                            ),
                          );
                        }).toList(),
                        (value) {
                          setState(() {
                            selectedproductName = value.toString();
                            selectedproductId = product
                                    .firstWhere((item) => item['name'] == value)
                                    .containsKey('id')
                                ? product.firstWhere(
                                    (item) => item['name'] == value)['id']
                                : null;
                            log(selectedproductId.toString());
                          });
                        },
                      ),
                    ),
                  )),
                  SizedBox(width: Sizes.width * 0.04),
                  addDefaultButton(
                    () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AddGroupScreen(
                                    sourecID: 19,
                                    name: 'Product',
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
                      "Select Color",
                      searchDropDown(
                        "Select Color",
                        color
                            .map((item) => DropdownMenuItem(
                                  onTap: () {
                                    selectedcolorsId = item['id'];
                                  },
                                  value: item,
                                  child: Row(
                                    children: [
                                      Text(
                                        item['name'].toString(),
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ))
                            .toList(),
                        selectedcolorValue,
                        (value) {
                          setState(() {
                            selectedcolorValue = value;
                          });
                        },
                        color2Controller,
                        (value) {
                          setState(() {
                            // Filter the Prionaity list based on the search value
                            color
                                .where((item) => item['name']
                                    .toString()
                                    .toLowerCase()
                                    .contains(value.toLowerCase()))
                                .toList();
                          });
                        },
                        'Search for a color...',
                        (isOpen) {
                          if (!isOpen) {
                            colorController.clear();
                          }
                        },
                      ),
                    ),
                  ),
                  SizedBox(width: Sizes.width * 0.04),
                  addDefaultButton(
                    () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AddGroupScreen(
                                    sourecID: 17,
                                    name: 'Color',
                                  ))).then((value) => refreshData());
                    },
                  )
                ],
              ),
              SizedBox(height: Sizes.height * 0.02),
              textformfiles(_intrestedremarksController, labelText: "Remarks"),
              SizedBox(height: Sizes.height * 0.05),
              Text(
                "Test Ride",
                style: rubikTextStyle(18, FontWeight.bold, AppColor.colBlack),
              ),
              SizedBox(height: Sizes.height * 0.02),
              Row(
                children: [
                  Expanded(
                    child: dropdownTextfield(
                      "Select Test",
                      searchDropDown(
                          'Select Test',
                          Test.map((item) => DropdownMenuItem(
                                onTap: () {
                                  testId = item['id'];
                                },
                                value: item,
                                child: Row(
                                  children: [
                                    Text(
                                      item['name'].toString(),
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              )).toList(),
                          selectedtestValue,
                          (value) {
                            setState(() {
                              selectedtestValue = value;
                            });
                          },
                          testController,
                          (value) {
                            setState(() {
                              // Filter the Prionaity list based on the search value
                              Test.where((item) => item['name']
                                  .toString()
                                  .toLowerCase()
                                  .contains(value.toLowerCase())).toList();
                            });
                          },
                          'Search for a Test...',
                          (isOpen) {
                            if (!isOpen) {
                              testController.clear();
                            }
                          }),
                    ),
                  ),
                  SizedBox(width: Sizes.width * 0.04),
                  addDefaultButton(
                    () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AddGroupScreen(
                                    sourecID: 21,
                                    name: 'Test',
                                  ))).then((value) => refreshData());
                    },
                  )
                ],
              ),
              SizedBox(height: Sizes.height * 0.02),
              dropdownTextfield(
                "Test Ride Date",
                InkWell(
                  onTap: () async {
                    FocusScope.of(context).requestFocus(FocusNode());
                    await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2200),
                    ).then((selectedDate) {
                      if (selectedDate != null) {
                        rideDatePickar.text =
                            DateFormat('M/d/yyyy').format(selectedDate);
                      }
                    });
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        rideDatePickar.text,
                        style: rubikTextStyle(
                            16, FontWeight.w500, AppColor.colBlack),
                      ),
                      Icon(Icons.edit_calendar, color: AppColor.colBlack)
                    ],
                  ),
                ),
              ),
              SizedBox(height: Sizes.height * 0.02),
              textformfiles(_testRemarkController, labelText: "Remarks"),
              SizedBox(height: Sizes.height * 0.05),
              Text(
                "Appointment Date and Time*",
                style: rubikTextStyle(18, FontWeight.bold, AppColor.colBlack),
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
                            lastDate: DateTime(2200),
                          ).then((selectedDate) {
                            if (selectedDate != null) {
                              appointmentDatePickar.text =
                                  DateFormat('M/d/yyyy').format(selectedDate);
                            }
                          });
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              appointmentDatePickar.text,
                              style: rubikTextStyle(
                                  16, FontWeight.w500, AppColor.colBlack),
                            ),
                            Icon(Icons.edit_calendar, color: AppColor.colBlack)
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: Sizes.width * 0.04),
                  Expanded(
                      child: dropdownTextfield(
                    "Appointment Time",
                    InkWell(
                      onTap: () {
                        _selectTimeAppointment(context);
                      },
                      child: Center(
                        child: Text(
                          selectedTimeAppointment.format(context),
                          style: rubikTextStyle(
                              16, FontWeight.w500, AppColor.colBlack),
                        ),
                      ),
                    ),
                  ))
                ],
              ),
              SizedBox(height: Sizes.height * 0.02),
              textformfiles(_lastRemarkController, labelText: "Last Remarks"),
             SizedBox(height: Sizes.height * 0.02),
              textformfiles(_specialRemarkController, labelText: "Special Remarks"),
              Row(
                children: [
                  SizedBox(
                    width: 30,
                    child: Checkbox(
                        activeColor: AppColor.colPrimary,
                        value: ischack,
                        onChanged: (e) {
                          setState(() {
                            ischack = !ischack;
                          });
                        }),
                  ),
                  Text(
                    "Sent an SMS after Save",
                    style:
                        rubikTextStyle(16, FontWeight.w500, AppColor.colBlack),
                  )
                ],
              ),
              SizedBox(height: Sizes.height * 0.02),
              InkWell(
                  onTap: () {
                    postProspect();
                    getLocation();
                  },
                  child: Button("Save", AppColor.colPrimary)),
              SizedBox(height: Sizes.height * 0.02),
              Button("Delete", AppColor.colRideFare),
              SizedBox(height: Sizes.height * 0.02),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> location() async {
    try {
      final data = await ApiService.fetchData('GetLocation');
      if (data != null && data is List<dynamic>) {
        setState(() {
          // locationList.add({'id': 0, 'location_Name': 'Select a Location'});
          locationList.addAll(data.cast<Map<String, dynamic>>());
        });
      } else {
        print('Invalid location data received');
      }
    } catch (e) {
      print('Error fetching location data: $e');
    }
  }

  Future<void> staff() async {
    try {
      final data = await ApiService.fetchData('GetStaff');
      if (data != null && data is List<dynamic>) {
        staffList = data.map((map) => Staffmodel.fromJson(map)).toList();
        if (staffList.isEmpty) {
        } else {
          setState(() {
            options = staffList.map((staff) => staff.staffName).toList();
            selectedStaffId =
                staffList.first.staffName; // Set the default selected staff ID
          });
        }
      } else {
        print('Invalid location data received');
      }
    } catch (e) {
      print('Error fetching location data: $e');
    }
  }

  Future<void> fetchDataByMiscTypeId(int miscTypeId,
      List<Map<String, dynamic>> listToUpdate) async {
    final url = Uri.parse(
        'http://lms.muepetro.com/api/UserController1/GetMiscMaster?MiscTypeId=$miscTypeId');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final List<Goruppartmodel> goruppartmodelList =
            grouppartmodelFromJson(response.body);
        listToUpdate.clear();
        for (var item in goruppartmodelList) {
          listToUpdate.add({'id': item.id, 'name': item.name});
        }
        setState(() {});
      } else {
        // Handle error if needed
      }
    } catch (e) {
      // Handle error if needed
    }
  }

  Future<void> sourceData() async {
    await fetchDataByMiscTypeId(10, drop,);
  }

  Future<void> colorData() async {
    await fetchDataByMiscTypeId(17, color,);
  }

  Future<void> enqtypeData() async {
    await fetchDataByMiscTypeId(18, Enqtype,);
  }

  Future<void> occuptionData() async {
    await fetchDataByMiscTypeId(23, Occuption,);
  }

  // Future<void> prionaityData() async {
  //   await fetchDataByMiscTypeId(22, Prionaity,);
  // }
    Future<void> prionaityData() async {
    final url = Uri.parse(
        'http://lms.muepetro.com/api/UserController1/GetMiscMaster?MiscTypeId=22');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final List<Goruppartmodel> goruppartmodelList =
            grouppartmodelFromJson(response.body);
            Prionaity.clear();
        for (var item in goruppartmodelList) {
          Prionaity.add({'id': item.id, 'name': item.name});
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


  Future<void> productData() async {
    await fetchDataByMiscTypeId(19, product,);
  }

  Future<void> testData() async {
    await fetchDataByMiscTypeId(21, Test,);
  }

  void postProspect() async {
    const String apiUrl =
        'http://lms.muepetro.com/api/UserController1/PostProspect';
    Map<String, dynamic> postData = {
      "Location_Id": locationId,
      "Prefix_Name": "online",
      "Ref_No": int.tryParse(refController.text),
      "Ref_Date": refDatePicker.text,
      "Ref_Time": "${selectedTimeRefence.hour}:${selectedTimeRefence.minute}",
      "Title_id": selectedtitleId,
      "Gender_Name": "Not Set Yet",
      "Customer_Name": _customernameController.text.toString(),
      "Contact_Name": "Not Set Yet",
      "SanOff_Name": _sonoffController.text.toString(),
      "Address_Datails": _addressController.text.toString(),
      "City_Id": "1",
      "City": cityValue,
      "Pin_Code": _pinController.text.toString(),
      "Mob_No": _mobileController.text.toString(),
      "Phon_No":"Not Set Yet",
      "Std_Code": "Not Set Yet",
      "Fax_No": "Not Set Yet",
      "Email_Id": _emailController.text.toString(),
      "Birthday_Date": dobDatePicker.text,
      "Anniversary_Date": dobDatePicker.text,
      "Enq_Type": selectedEnqtypeId,
      "Mode_Type": "Not Set Yet",
      "Occupation": selectedOccuptionId,
      "Income": _incomeController.text.toString(),
      "EnqGenBy_Id": staffList
          .firstWhere((staff) => staff.staffName == selectedStaffId,
              orElse: () => Staffmodel(id: 0, staffName: ''))
          .id,
      "SalesEx_id": staffList
          .firstWhere((staff) => staff.staffName == selectedStaffId,
              orElse: () => Staffmodel(id: 0, staffName: ''))
          .id,
      "Source_Id": selecteddropId,
      "NoOfVisitor": "Not Set Yet",
      "Scheme": _schemeController.text.toString(),
      "Priority": selectedPrionaityId,
      "InterestIn": "Not Set Yet",
      "Model_Id": selectedproductId,
      "Colour_Id": selectedcolorsId,
      "Remark_interest": _intrestedremarksController.text.toString(),
      "ModelTest_Id": testId,
      "ModelTest_Date": rideDatePickar.text.toString(),
      "Remark_ModelTest": _testRemarkController.text.toString(),
      "Appointment_Date": appointmentDatePickar.text,
      "Appointment_Time": "${selectedTimeRefence.hour}:${selectedTimeRefence.minute}",
      "Remark_Appointment": _lastRemarkController.text.toString(),
      "Remark_Special": _specialRemarkController.text.toString(),
      "CurrentAppointmentDate": appointmentDatePickar.text,
      "EnquiryStatus": 1,
      "Last_Remark": _lastRemarkController.text.toString(),
      "LastContact_Date": appointmentDatePickar.text,
    };
    // log(message)
    String jsonString = jsonEncode(postData);
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonString,
      );
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(" ${ data}"),
          backgroundColor: Colors.green,
        ));
      } else {
        var data = jsonDecode(response.body);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content:
              Text("Failed to post data. Status code: ${response.statusCode}"),
          backgroundColor: Colors.red,
        ));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("An error occurred: $e"),
        backgroundColor: Colors.red,
      ));
    }
  }

  Future<void> _fetchRefNo() async {
    setState(() {
      isLoading = true;
    });
    try {
      dynamic data = await autoperfixnumbar();
      if (data is int) {
        setState(() {
          refController.text = data.toString();
          datailsList1.add(data.toString());
        });
      } else if (data is Map<String, dynamic>) {
        setState(() {
          String refNo = data['Ref_No'].toString();
          refController.text = refNo;
          datailsList1.add(refNo);
        });
      } else {
        throw Exception('Unexpected response type');
      }
    } catch (e) {
      print('Error fetching reference number: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<dynamic> autoperfixnumbar() async {
    final response = await http.get(
      Uri.parse(
          'http://lms.muepetro.com/api/UserController1/GetInvoiceNo?Tblname=Prospect&Fldname=Ref_No&transdatefld=Ref_Date&varprefixtblname=Prefix_Name&prefixfldnText=%27Online%27&varlocationid=$locationId'),
      headers: {
        "Content-Type": "application/json",
      },
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load reference number');
    }
  }

  void getLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      setState(() {});
    } catch (e) {}
  }
}
