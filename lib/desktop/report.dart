// ignore_for_file: use_build_context_synchronously, unused_import, unused_local_variable, non_constant_identifier_names, prefer_const_constructors, avoid_print, prefer_const_declarations

import 'dart:convert';

import 'package:autowheelweb/Components/menuController.dart';
import 'package:autowheelweb/Utils/api.dart';
import 'package:autowheelweb/Utils/colors.dart';
import 'package:autowheelweb/Utils/mediaquery.dart';
import 'package:autowheelweb/Utils/responsive.dart';
import 'package:autowheelweb/Utils/textfield.dart';
import 'package:autowheelweb/Utils/textstyle.dart';
import 'package:autowheelweb/desktop/followup.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:excel/excel.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  List<dynamic> dateList = [];

  TextEditingController datepickar1 = TextEditingController(
    text: DateFormat('M/d/yyyy').format(DateTime.now()),
  );
  TextEditingController datepickar2 = TextEditingController(
    text: DateFormat('M/d/yyyy').format(DateTime.now()),
  );
  int selectedId3 = 0;
  int? loctionid; // Change type to int?
  List<Map<String, dynamic>> Loctionshow = [];

  @override
  void initState() {
    super.initState();
    // Call getLocation in initState
    getLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: (!Responsive.isDesktop(context))
            ? IconButton(
                onPressed: context.read<MenuControlle>().controlMenu,
                icon: const Icon(Icons.menu))
            : Container(),
        title: Text("Report", overflow: TextOverflow.ellipsis),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              icon: Icon(Icons.picture_as_pdf, color: AppColor.colWhite),
              onPressed: () async {
                generatePDF();
              },
            ),
          )
        ],
      ),
      backgroundColor: AppColor.colPrimary.withOpacity(.1),
       body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: Sizes.height * 0.04, horizontal: Sizes.width * 0.04),
          child: Column(
            children: [
              dropdownTextfield(
                'Location',
                localDropdownButton("Location",
                  context,
                  selectedId3,
                  Loctionshow.map((item) {
                    return DropdownMenuItem<Object>(
                      value: item['id'],
                      child: Text(item['location_Name'],
                          style: rubikTextStyle(
                              16, FontWeight.w500, AppColor.colBlack)),
                    );
                  }).toList(),
                  (value) {
                    setState(() {
                      selectedId3 = value as int;
                      // Update the loctionid variable
                      loctionid = value as int?;
                    });
                  },
                ),
              ),
              SizedBox(height: Sizes.height * 0.04),
              Row(
                children: [
                  Expanded(
                    child: dropdownTextfield(
                      "From Date",
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
                              datepickar1.text =
                                  DateFormat('M/d/yyyy').format(selectedDate);
                            }
                          });
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              datepickar1.text,
                              style: rubikTextStyle(
                                  16, FontWeight.w500, AppColor.colBlack),
                            ),
                            Icon(Icons.edit_calendar, color: AppColor.colBlack)
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: Sizes.width * 0.03),
                  Expanded(
                    child: dropdownTextfield(
                      "To Date",
                      InkWell(
                        onTap: () async {
                          FocusScope.of(context).requestFocus(FocusNode());
                          await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1900),
                            lastDate: DateTime(2050),
                          ).then((selectedDate) {
                            if (selectedDate != null) {
                              datepickar2.text =
                                  DateFormat('M/d/yyyy').format(selectedDate);
                            }
                          });
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              datepickar2.text,
                              style: rubikTextStyle(
                                  16, FontWeight.w500, AppColor.colBlack),
                            ),
                            Icon(Icons.edit_calendar, color: AppColor.colBlack)
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: Sizes.height * 0.05),
              InkWell(
                onTap: () {
                  if (loctionid == null || loctionid == 0) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Please select a location."),
                      backgroundColor: Colors.red,
                    ));
                  } else {
                    allReportData(
                      dateFrom: datepickar1.text,
                      dateTo: datepickar2.text,
                      locationId: loctionid!,
                    );
                  }
                },
                child: Button("Get Data", AppColor.colPrimary),
              ),
              SizedBox(height: Sizes.height * 0.02),
              Wrap(
                  children: List.generate(dateList.length, (index) {
                return Container(
                  width:
                      (!Responsive.isDesktop(context)) ? double.infinity : 400,
                  margin: EdgeInsets.symmetric(
                      vertical: Sizes.height * 0.01, horizontal: 10),
                  decoration: BoxDecoration(
                    color: AppColor.colWhite,
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: [
                      BoxShadow(blurRadius: 2, color: AppColor.colGrey)
                    ],
                  ),
                  child: Column(children: [
                    datastyle("Customer Name :",
                        ' ${dateList[index]?["customer_Name"] ?? 'N/A'}'),
                    datastyle("Sales Person :",
                        ' ${dateList[index]?["salesPerson"] ?? 'N/A'}'),
                    datastyle("Product :",
                        ' ${dateList[index]?["product"] ?? 'N/A'}'),
                    datastyle("Reference No. :",
                        ' ${dateList[index]?["ref_No"] ?? 'N/A'}'),
                    datastyle("Mobile No. :",
                        ' ${dateList[index]?["mob_No"] ?? 'N/A'}'),
                    datastyle("Appointment Date :",
                        ' ${dateList[index]?["currentAppointmentDate"] ?? 'N/A'}'),
                    datastyle("Remark :",
                        ' ${dateList[index]?["last_Remark"] ?? 'N/A'}'),
                    datastyle("Special Remark :",
                        ' ${dateList[index]?["remark_Special"] ?? 'N/A'}'),
                    // datastyle("Action Taken :",
                    //     ' ${dateList[index]?["last_ActionTaken"] ?? 'N/A'}'),
                    datastyle("Last Contact Date :",
                        ' ${dateList[index]?["lastContact_Date"] ?? 'N/A'}'),
                    datastyle("Priority :",
                        ' ${dateList[index]?["priority"] ?? 'N/A'}'),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => FollowUpScreen(
                                  refnom: "${dateList[index]?["ref_No"]}",
                                  value: false,
                                ),
                              ));
                        },
                        child: Text("View Details"))
                  ]),
                );
              }))
            ],
          ),
        ),
      ),
    );
  }

  datastyle(String title, String subtitle) {
    return ListTile(
      dense: true,
      title: Text(
        title,
        style: rubikTextStyle(16, FontWeight.w500, AppColor.colBlack),
      ),
      trailing: Text(
        subtitle,
        style: rubikTextStyle(16, FontWeight.w500, AppColor.colGrey),
      ),
    );
  }

 Future<void> allReportData({
    required String dateFrom,
    required String dateTo,
    required int locationId,
  }) async {
    try {
      final formattedDateFrom = DateFormat('M/d/yyyy').format(
        DateFormat('M/d/yyyy').parse(dateFrom),
      );
      final formattedDateTo = DateFormat('M/d/yyyy').format(
        DateFormat('M/d/yyyy').parse(dateTo),
      );

      final response = await ApiService.fetchData(
        'GetScheduleReport?datefrom=$formattedDateFrom&dateto=$formattedDateTo&locationid=$locationId',
      );

      // Assuming dateList is a property of the class
      setState(() {
        dateList = response;
      });

      if (dateList.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content:
                Text('No reports found between $dateFrom to $dateTo'),
          ),
        );
      } else {
        print("Data fetched successfully");
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('$error'),
        ),
      );
    }
  }

Future<void> getLocation() async {
    try {
      final response = await ApiService.fetchData('GetLocation');
      List<dynamic> data = response;
      // Assuming Loctionshow and setState are accessible
      setState(() {
        Loctionshow.add({'id': 0, 'location_Name': 'Select a Location'});
        Loctionshow.addAll(data.cast<Map<String, dynamic>>());
      });
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> generatePDF() async {
    final pdf = pw.Document();

    // Define page size and orientation
    final pageFormat = PdfPageFormat.a4;

    for (var index = 0; index < dateList.length; index++) {
      final customerName =
          'Customer Name: ${dateList[index]?["customer_Name"] ?? 'N/A'}';
      final salesPerson =
          'Sales Person: ${dateList[index]?["salesPerson"] ?? 'N/A'}';
      final product = 'Product: ${dateList[index]?["product"] ?? 'N/A'}';
      final referenceNo =
          'Reference No.: ${dateList[index]?["ref_No"] ?? 'N/A'}';
      final mobileNo = 'Mobile No.: ${dateList[index]?["mob_No"] ?? 'N/A'}';
      final appointmentDate =
          'Appointment Date: ${dateList[index]?["currentAppointmentDate"] ?? 'N/A'}';
      final remark = 'Remark: ${dateList[index]?["last_Remark"] ?? 'N/A'}';
      final specialRemark =
          'Special Remark: ${dateList[index]?["remark_Special"] ?? 'N/A'}';
      final actionTaken =
          'Action Taken: ${dateList[index]?["last_ActionTaken"] ?? 'N/A'}';
      final lastContactDate =
          'Last Contact Date: ${dateList[index]?["lastContact_Date"] ?? 'N/A'}';
      final priority = 'Priority: ${dateList[index]?["priority"] ?? 'N/A'}';
      final refNo = dateList[index]?["ref_No"] ?? '';

      pdf.addPage(
        pw.Page(
          pageFormat: pageFormat,
          build: (context) => pw.Container(
            padding: const pw.EdgeInsets.all(20),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                _buildText(customerName),
                _buildText(salesPerson),
                _buildText(product),
                _buildText(referenceNo),
                _buildText(mobileNo),
                _buildText(appointmentDate),
                _buildText(remark),
                _buildText(specialRemark),
                _buildText(actionTaken),
                _buildText(lastContactDate),
                _buildText(priority),
              ],
            ),
          ),
        ),
      );
    }

    final output = await Printing.layoutPdf(
      onLayout: (format) async => pdf.save(),
    );

    final file = File('example.pdf');
    await file.writeAsBytes(await pdf.save());

    print('PDF saved to: ${file.path}');
  }

  pw.Widget _buildText(String text) {
    return pw.Padding(
      padding: const pw.EdgeInsets.only(bottom: 10),
      child: pw.Text(
        text,
        style: const pw.TextStyle(fontSize: 14),
      ),
    );
  }

  Future<void> generateExcel() async {
    // Excel excel = Excel();
    Excel excel = Excel.createExcel();

    Sheet sheetObject =
        excel['Sheet1']; // Replace 'Sheet1' with your desired sheet name

    // Add headers to the Excel sheet
    List<String> headers = [
      'Customer Name',
      'Sales Person',
      'Product',
      'Reference No.',
      'Mobile No.',
      'Appointment Date',
      'Remark',
      'Special Remark',
      'Action Taken',
      'Last Contact Date',
      'Priority'
    ];
    for (var i = 0; i < headers.length; i++) {
      sheetObject.cell(CellIndex.indexByString("${getColumnName(i)}1")).value =
          headers[i] as CellValue?;
    }

    // Add data to the Excel sheet
    for (var index = 0; index < dateList.length; index++) {
      // sheetObject.cell(CellIndex.indexByString("A${index + 2}")).value =
      //     dateList[index]?["customer_Name"] ?? 'N/A';
      // sheetObject.cell(CellIndex.indexByString("B${index + 2}")).value =
      //     dateList[index]?["salesPerson"] ?? 'N/A';
      // sheetObject.cell(CellIndex.indexByString("C${index + 2}")).value =
      //     dateList[index]?["product"] ?? 'N/A';
      // sheetObject.cell(CellIndex.indexByString("D${index + 2}")).value =
      //     dateList[index]?["ref_No"] ?? 'N/A';
      // sheetObject.cell(CellIndex.indexByString("E${index + 2}")).value =
      //     dateList[index]?["mob_No"] ?? 'N/A';
      // sheetObject.cell(CellIndex.indexByString("F${index + 2}")).value =
      //     dateList[index]?["currentAppointmentDate"] ?? 'N/A';
      // sheetObject.cell(CellIndex.indexByString("G${index + 2}")).value =
      //     dateList[index]?["last_Remark"] ?? 'N/A';
      // sheetObject.cell(CellIndex.indexByString("H${index + 2}")).value =
      //     dateList[index]?["remark_Special"] ?? 'N/A';
      // sheetObject.cell(CellIndex.indexByString("I${index + 2}")).value =
      //     dateList[index]?["last_ActionTaken"] ?? 'N/A';
      // sheetObject.cell(CellIndex.indexByString("J${index + 2}")).value =
      //     dateList[index]?["lastContact_Date"] ?? 'N/A';
      // sheetObject.cell(CellIndex.indexByString("K${index + 2}")).value =
      //     dateList[index]?["priority"] ?? 'N/A';
      sheetObject.cell(CellIndex.indexByString("A${index + 2}"))
    ..value = dateList[index]?["customer_Name"] ?? 'N/A';
sheetObject.cell(CellIndex.indexByString("B${index + 2}"))
    ..value = dateList[index]?["salesPerson"] ?? 'N/A';
    }

    // Save the Excel file
    // List<int>? excelBytes = excel.encode();
    // File('example.xlsx').writeAsBytesSync(excelBytes!);

    // print('Excel saved to: example.xlsx');
       List<int>? excelBytes = excel.encode();
    File('example.xlsx').writeAsBytesSync(excelBytes!);

    print('Excel saved to: example.xlsx');  
  }

  // ... (unchanged code)

  String getColumnName(int index) {
    const String alphabet = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    return index < alphabet.length
        ? alphabet[index]
        : '${getColumnName(index ~/ alphabet.length - 1)}${alphabet[index % alphabet.length]}';
  }
}
