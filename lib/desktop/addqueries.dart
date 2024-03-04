import 'package:autowheelweb/Utils/api.dart';
import 'package:autowheelweb/Utils/colors.dart';
import 'package:autowheelweb/Utils/mediaquery.dart';
import 'package:autowheelweb/Utils/responsive.dart';
import 'package:autowheelweb/Utils/textstyle.dart';
import 'package:autowheelweb/desktop/followup.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class AddQueries extends StatefulWidget {
   AddQueries({
    required this.index,
    super.key});
int index = 0;
  @override
  State<AddQueries> createState() => _AddQueriesState();
}

class _AddQueriesState extends State<AddQueries>with SingleTickerProviderStateMixin { 
  late TabController _tabController;
  List<dynamic> dateList = [];

  String datepickar1 =  DateFormat('M/d/yyyy').format(DateTime.now());
  String datepickar2 = DateFormat('M/d/yyyy').format(DateTime.now());
  @override
  void initState() {
    super.initState();
     datepickar2 = widget.index==2? DateFormat('M/d/yyyy').format(DateTime.now()):DateFormat('M/d/yyyy').format(DateTime.now().add(Duration(days: 1)));
    datepickar1 = widget.index==2? DateFormat('M/d/yyyy').format(DateTime.now()):DateFormat('M/d/yyyy').format(DateTime.now().add(Duration(days: 1)));
   
    allReportData(dateFrom:datepickar1.toString(), dateTo: datepickar2.toString()).then((value) {
      setState(() {
        
      });
    });
    _tabController = TabController(length: 4, vsync: this,initialIndex: widget.index);
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar( 
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back_ios)),
            centerTitle: true,
        title: Text('Add Enquiries', overflow: TextOverflow.ellipsis), bottom: TabBar(
          isScrollable: true,
          controller: _tabController,
          tabs: [
            Tab(text: 'Enquiry Punched Today',icon: Icon(Icons.calendar_month),),
            Tab(text: 'Tomarrow Follow-ups',icon: Icon(Icons.person),),
            Tab(text: "Today's Follow-ups",icon:  Icon(Icons.verified_user),),
            Tab(text: 'Toatal Leads',icon: Icon(Icons.info),),
          ],
        ),
      ),
      backgroundColor: AppColor.colWhite,
      body: TabBarView(
        controller: _tabController,
        children: [  
       totalenquery(context),
       totalenquery(context),
       totalenquery(context),
       totalenquery(context),
                  ],
      ),
    
    );
  }

  Wrap totalenquery(BuildContext context) {
    return Wrap( children:  
         List.generate(dateList.length, (index) {
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
    leading:  CircleAvatar(
      backgroundColor: AppColor.colPrimary,
      maxRadius: 15,
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
        Text("Hot "),
        Container(width: 13,height: 13,color: AppColor.colRideFare,),
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
        '${dateList[index]?["salesPerson"] ?? 'N/A'}',
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [ 
              
             InkWell(
    child:   Image.asset("assets/google-messages-icon.png",height: 40,),
    onTap :() { _sendMessage(context,'${dateList[index]?["mob_No"] ?? 'N/A'}','Hi ${dateList[index]?["customer_Name"] ?? 'N/A'}');},
            ),
            InkWell(
    child: Image.asset("assets/phone-call.png",height: 30,),
    onTap: () => _makeCall(context,'${dateList[index]?["mob_No"] ?? 'N/A'}'),
            ),
            InkWell(
    child: Image.asset("assets/WhatsApp_icon.png",height: 45,),
    onTap: () => _openWhatsApp(context,'${dateList[index]?["mob_No"] ?? 'N/A'}','Hi ${dateList[index]?["customer_Name"] ?? 'N/A'}'),
            ),
          ],),
          SizedBox(height: Sizes.height*0.02,),
        datastyle(
              "Mobile No.:", ' ${dateList[index]?["mob_No"] ?? 'N/A'}'),
        datastyle(
              "Remark:", ' ${dateList[index]?["last_Remark"] ?? 'N/A'}'),
        datastyle("Special Remark:",
              ' ${dateList[index]?["remark_Special"] ?? 'N/A'}'),
        datastyle(
              "Product:", ' ${dateList[index]?["product"] ?? 'N/A'}'),
        datastyle(
              "Punched Location:", 'N/A'),
        datastyle("Last Contact Date:",
              ' ${dateList[index]?["lastContact_Date"] ?? 'N/A'}'.substring(0, dateList[index]?["currentAppointmentDate"].length- 10)),
       TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FollowUpScreen(
                    refnom: "${dateList[index]?["ref_No"]}",
                    value: false,
                  ),
                ),
              );
            },
            child: Text("View Details"),
          ),
        ],
      ),
    ),
            ],
          ),
        );
      }),
    );
  }
  
  Future _sendMessage(BuildContext context,String phoneNumber,String name) async{
     if (!await launchUrl(
      Uri.parse("sms:$phoneNumber?body=$name"),
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch ');
    }
  }

  Future _makeCall(BuildContext context,String phoneNumber) async{
     if (!await launchUrl(
      Uri.parse("tel:$phoneNumber"),
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch ');
    }
    
  }

  Future _openWhatsApp(BuildContext context,String phoneNumber,String name) async{
     if (!await launchUrl(
      Uri.parse("https://wa.me/+91$phoneNumber?text=$name"),
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch ');
    }
  }
  datastyle(String title, String subtitle) {
    return Padding(
      padding:  EdgeInsets.symmetric(vertical: Sizes.height*.01),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [ Text(
              title,
              style: rubikTextStyle(16, FontWeight.w500, AppColor.colBlack),
            ),
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

   Future<void> allReportData({
    required String dateFrom,
    required String dateTo
  }) async {
    try {
      final formattedDateFrom = DateFormat('M/d/yyyy').format(
        DateFormat('M/d/yyyy').parse(dateFrom),
      );
      final formattedDateTo = DateFormat('M/d/yyyy').format(
        DateFormat('M/d/yyyy').parse(dateTo),
      );

      final response = await ApiService.fetchData(
        'GetScheduleReport?datefrom=$formattedDateFrom&dateto=$formattedDateTo&locationid=2',
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

}