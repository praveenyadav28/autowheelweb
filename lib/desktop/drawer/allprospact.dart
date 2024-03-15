import 'dart:io';

import 'package:autowheelweb/Components/menuController.dart';
import 'package:autowheelweb/Utils/api.dart';
import 'package:autowheelweb/Utils/colors.dart';
import 'package:autowheelweb/Utils/mediaquery.dart';
import 'package:autowheelweb/Utils/responsive.dart';
import 'package:autowheelweb/Utils/textstyle.dart';
import 'package:autowheelweb/model/prospect_modal.dart';
import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:url_launcher/url_launcher.dart';

class AllProspacts extends StatefulWidget {
  const AllProspacts({super.key});

  @override
  State<AllProspacts> createState() => _AllProspactsState();
}

class _AllProspactsState extends State<AllProspacts> {

//Staff
List staffList = [];

//Priority
final List<Map<String, dynamic>> priorityDataList = [
    {'id': 1, 'name': 'Cold'},
    {'id': 2, 'name': 'Normal'},
    {'id': 3, 'name': 'Hot'},
  ];

//All Prospect Data List
  List<dynamic> dateList = [];


  @override
  void initState() {
    setState(() {
      staffModal();
      getallprospact().then((value) => setState(() {
        
      }));
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar( leading: (!Responsive.isDesktop(context))
            ? IconButton(
                onPressed: context.read<MenuControlle>().controlMenu,
                icon: const Icon(Icons.menu))
            : Container(),
            centerTitle: true, actions: [
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
        title: Text("All Prospect", overflow: TextOverflow.ellipsis),
      ),
      backgroundColor: AppColor.colPrimary.withOpacity(.1),      
      body: dateList.length==0?Center(child: Text("No Prospect Found"),) :SingleChildScrollView(
        child: Padding(
         padding:  EdgeInsets.symmetric(vertical: Sizes.height*0.02,horizontal: Sizes.width*.04),
          child: Column(children: [  Wrap(
                 children: List.generate(dateList.length, (index) {
        //Priority
    int priorityId = dateList[index]['priority'];
    String priorityName = priorityDataList
        .firstWhere((element) => element['id'] == priorityId)['name'];
                     return Container(width:
                          (!Responsive.isDesktop(context)) ? double.infinity : 400,
                      margin: EdgeInsets.symmetric(
                          vertical: Sizes.height * 0.01, horizontal: 10),
                      // padding: EdgeInsets.symmetric(
                      //     vertical: Sizes.height * 0.03),
                      decoration: BoxDecoration(
                        color: AppColor.colWhite,
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: [
                          BoxShadow(blurRadius: 2, color: AppColor.colGrey)
                        ],
                      ),
          child: ExpansionTile(
            tilePadding: EdgeInsets.zero,
            title: ListTile(
              
              minVerticalPadding: 0,
              horizontalTitleGap: 0,
              leading:  Container(padding: EdgeInsets.symmetric(vertical: 2,horizontal: 7.5),
              margin: EdgeInsets.only(right: 10),
                decoration: BoxDecoration(
                color: AppColor.colPrimary,borderRadius: BorderRadius.circular(30)),
                   child: Text(
              
                    '${dateList[index]?["ref_No"] ?? 'N/A'}',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: AppColor.colWhite,
                    ),
                               ),
                 ),
             title:    Text(
                  '${dateList[index]?["customer_Name"] ?? 'N/A'}',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: AppColor.colBlack,
                  ),
                ),
              trailing: Row(mainAxisSize: MainAxisSize.min,
                children: [
                  Text("${priorityName ?? 'N/A'}  "),
                  Container(width: 15,height: 15,decoration: BoxDecoration(color: priorityId==1?AppColor.colFbCircle:priorityId==2?AppColor.colYellow:  AppColor.colRideFare,borderRadius: BorderRadius.circular(3)),),
                  
                ],
              ),
            ),
            subtitle:  ListTile(
              minVerticalPadding: 0,
              title:  Row(
                 children: [
                  Icon(Icons.notifications_active_outlined,color: AppColor.colBlack,),
                   Text(
                    '  ${dateList[index]?["currentAppointmentDate"] ?? 'N/A'}'.substring(0, dateList[index]?["currentAppointmentDate"].length- 10),
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: AppColor.colFbCircle.withOpacity(.5),
                    ),
                  ),
                 ],
               ),
             trailing:    Text(
                  '${dateList[index]?["salesEx_id"] ?? 'N/A'}',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: AppColor.colBlack,
                  ),
                ),
              
            ),
            trailing: SizedBox(width: 0,height: 0,),
              children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  // crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    datastyle(
                        "Mobile No.:", '${dateList[index]?["mob_No"] ?? 'N/A'}'),
                  datastyle(
                        "Remark:", '${dateList[index]?["last_Remark"] ?? 'N/A'}'),
                  datastyle("Special Remark:",
                        '${dateList[index]?["remark_Special"] ?? 'N/A'}'),
                  datastyle("Action Taken:",
                        '${dateList[index]?["last_ActionTaken"] ?? 'N/A'}'),
                  datastyle("Enquery Type:",
                        '${dateList[index]?["remark_Special"] ?? 'N/A'}'),
                  datastyle(
                        "Product:", '${dateList[index]?["product"] ?? 'N/A'}'),
                  datastyle(
                        "City:", '${dateList[index]?["city"] ?? 'N/A'}'),
                  Padding(
      padding:  EdgeInsets.symmetric(vertical: Sizes.height*.01),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [ Text(
              "Punched Location:",
              style: rubikTextStyle(16, FontWeight.w500, AppColor.colBlack),
            ),
            SizedBox(width: Sizes.width*0.02,),
            InkWell(
              onTap: () {
                _location(context, "26.8468224", "75.8185984");
              },
              child: SizedBox(width: Sizes.width*.4,
                child: Text(
                  'Click for location',
                  style: rubikTextStyle(16, FontWeight.w500, AppColor.colFbCircle).copyWith(decoration: TextDecoration.underline),
                )
                        ),
            ),
        ],
      ),
    ),
                  datastyle("Last Contact Date:",
                        '${dateList[index]?["lastContact_Date"] ?? 'N/A'}'.substring(0, dateList[index]?["currentAppointmentDate"].length- 12)),
                 ],
                ),
              ),
            ],
          ),
              );
          }),
              )
               ],),
        ),
      ),
    );
  }
  
  
   datastyle(String title, String subtitle) {
    return Padding(
      padding:  EdgeInsets.symmetric(vertical: Sizes.height*.01),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [ Text(
              title,
              style: rubikTextStyle(16, FontWeight.w500, AppColor.colBlack),
            ),
            SizedBox(width: Sizes.width*0.02,),
            SizedBox(width: Sizes.width*.4,
              child: Text(
                subtitle,
                style: rubikTextStyle(16, FontWeight.w500, AppColor.colGrey),
              )
          ),
        ],
      ),
    );
  }
Future getallprospact()async{
var response = await ApiService.fetchData("GetProspect");

dateList = response;
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

//   Future<void> generateExcel() async {
//     // Excel excel = Excel();
//     Excel excel = Excel.createExcel();

//     Sheet sheetObject =
//         excel['Sheet1']; // Replace 'Sheet1' with your desired sheet name

//     // Add headers to the Excel sheet
//     List<String> headers = [
//       'Customer Name',
//       'Sales Person',
//       'Product',
//       'Reference No.',
//       'Mobile No.',
//       'Appointment Date',
//       'Remark',
//       'Special Remark',
//       'Action Taken',
//       'Last Contact Date',
//       'Priority'
//     ];
//     for (var i = 0; i < headers.length; i++) {
//       sheetObject.cell(CellIndex.indexByString("${getColumnName(i)}1")).value =
//           headers[i] as CellValue?;
//     }

//     // Add data to the Excel sheet
//     for (var index = 0; index < dateList.length; index++) {
//       // sheetObject.cell(CellIndex.indexByString("A${index + 2}")).value =
//       //     dateList[index]?["customer_Name"] ?? 'N/A';
//       // sheetObject.cell(CellIndex.indexByString("B${index + 2}")).value =
//       //     dateList[index]?["salesPerson"] ?? 'N/A';
//       // sheetObject.cell(CellIndex.indexByString("C${index + 2}")).value =
//       //     dateList[index]?["product"] ?? 'N/A';
//       // sheetObject.cell(CellIndex.indexByString("D${index + 2}")).value =
//       //     dateList[index]?["ref_No"] ?? 'N/A';
//       // sheetObject.cell(CellIndex.indexByString("E${index + 2}")).value =
//       //     dateList[index]?["mob_No"] ?? 'N/A';
//       // sheetObject.cell(CellIndex.indexByString("F${index + 2}")).value =
//       //     dateList[index]?["currentAppointmentDate"] ?? 'N/A';
//       // sheetObject.cell(CellIndex.indexByString("G${index + 2}")).value =
//       //     dateList[index]?["last_Remark"] ?? 'N/A';
//       // sheetObject.cell(CellIndex.indexByString("H${index + 2}")).value =
//       //     dateList[index]?["remark_Special"] ?? 'N/A';
//       // sheetObject.cell(CellIndex.indexByString("I${index + 2}")).value =
//       //     dateList[index]?["last_ActionTaken"] ?? 'N/A';
//       // sheetObject.cell(CellIndex.indexByString("J${index + 2}")).value =
//       //     dateList[index]?["lastContact_Date"] ?? 'N/A';
//       // sheetObject.cell(CellIndex.indexByString("K${index + 2}")).value =
//       //     dateList[index]?["priority"] ?? 'N/A';
//       sheetObject.cell(CellIndex.indexByString("A${index + 2}"))
//     .value = dateList[index]?["customer_Name"] ?? 'N/A';
// sheetObject.cell(CellIndex.indexByString("B${index + 2}"))
//     .value = dateList[index]?["salesPerson"] ?? 'N/A';
//     }

//     // Save the Excel file
//     // List<int>? excelBytes = excel.encode();
//     // File('example.xlsx').writeAsBytesSync(excelBytes!);

//     // print('Excel saved to: example.xlsx');
//        List<int>? excelBytes = excel.encode();
//     File('example.xlsx').writeAsBytesSync(excelBytes!);

//     print('Excel saved to: example.xlsx');  
//   }

  // String getColumnName(int index) {
  //   const String alphabet = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
  //   return index < alphabet.length
  //       ? alphabet[index]
  //       : '${getColumnName(index ~/ alphabet.length - 1)}${alphabet[index % alphabet.length]}';
  // }


  Future<void> staffModal() async {
    try {
      final data = await ApiService.fetchData('GetStaff');
      
     staffList = data;
    } catch (e) {
      print('Error fetching location data: $e');
    }
  }

  Future _location(BuildContext context,String latitude,String longitude) async{
     if (!await launchUrl(
      Uri.parse("https://www.google.com/maps/search/?api=1&query=$latitude,$longitude"),
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch ');
    }
  }

}