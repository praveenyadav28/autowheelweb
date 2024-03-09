// ignore_for_file: file_names, non_constant_identifier_names, camel_case_types, prefer_const_constructors, unused_import, prefer_const_constructors_in_immutables

import 'dart:convert';

import 'package:autowheelweb/desktop/addqueries.dart';
import 'package:autowheelweb/desktop/searchProspect.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Components/Sidemenu.dart';
import '../Components/menuController.dart';
import '../Utils/mediaquery.dart';
import '../Utils/textstyle.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../Utils/Colors.dart';
import '../Utils/responsive.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final List<Map<String, dynamic>> dataList = [
    {
      "icon": Icon(Icons.person),
      "color": Colors.red.withOpacity(0.6),
      "title": "Enquery Punched Today",
      "users": "2"
    },
    {
      "icon": Icon(Icons.person),
      "color": Colors.blue.withOpacity(0.6),
      "title": "Tommarow Follow-ups",
      "users": "2"
    },
    {
      "icon": Icon(Icons.verified_user),
      "color": Colors.green.withOpacity(0.6),
      "title": "Today Follow-ups",
      "users": "3"
    },
    {
      "icon": Icon(Icons.info),
      "color": Colors.yellow.withOpacity(0.6),
      "title": "Total Leads",
      "users": "50"
    },
    // {
    //   "icon": Icon(Icons.no_accounts),
    //   "color": Colors.orange.withOpacity(0.6),
    //   "title": "Blocked",
    //   "users": "80"
    // },
  ];
  final List<Map<String, dynamic>> registrationList = [
    {
      "color": Colors.red.withOpacity(0.1),
      "title": "Today Register",
      "users": "163"
    },
    {
      "color": Colors.blue.withOpacity(0.1),
      "title": "Weakly Register",
      "users": "570"
    },
    {
      "color": Colors.green.withOpacity(0.1),
      "title": "Monthly Register",
      "users": "1280",
    },
  ];
  final List<Map<String, dynamic>> userList = [
    {
      "color": Colors.red.withOpacity(0.1),
      "title": "Male",
      "title2": "Female",
      "users": "1163",
      "user2": "1378",
      "icon": Icon(Icons.man),
      "icon2": Icon(Icons.woman),
    },
    {
      "color": Colors.blue.withOpacity(0.1),
      "title": "Android",
      "title2": "Iphone",
      "users": "1570",
      "user2": "992",
      "icon": Icon(Icons.phone_android),
      "icon2": Icon(Icons.phone_iphone),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( leading: (!Responsive.isDesktop(context))
            ? IconButton(
                onPressed: context.read<MenuControlle>().controlMenu,
                icon: const Icon(Icons.menu))
            : Container(),
            centerTitle: true,
        title: Text("Welcome Mohan", overflow: TextOverflow.ellipsis),
      ),
      backgroundColor: AppColor.colPrimary.withOpacity(.2),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: Sizes.width * 0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: Sizes.height * 0.05),
            Responsive(
              mobile: FileInfoCard(dataList: dataList, crossAxisCount: 2),
              desktop: FileInfoCard(dataList: dataList, childAspectRatio: Sizes.width < 1400 ? 1.1 : 1.4,crossAxisCount: 4,),
              tablet: FileInfoCard(dataList: dataList, crossAxisCount:  3 ),
            ),
            SizedBox(height: Sizes.height*0.03,),
            Text("    Search Prospect",style: rubikTextStyle(16, FontWeight.w500, AppColor.colBlack,)),
            SizedBox(height: Sizes.height*0.01,),
            InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => SearchProspect(),));
              },
              child: Container(
                height: 50,
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 5,horizontal: 7),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(30),color: AppColor.colWhite,border: Border.all(color: AppColor.colBlack,width: 2)),
                child: Row(
                  children: [
                    Icon(Icons.search_sharp,size: 30,color: AppColor.colGrey,),
                     Text("  Customer Name",style: rubikTextStyle(15, FontWeight.w500, AppColor.colBlack,)),
                     Spacer(),
                     Container( padding: EdgeInsets.symmetric(horizontal: 10),
                     height: double.infinity,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(30),color: AppColor.colPrimary.withOpacity(.3)),
               
                      child: Row(
                      children: [ Icon(Icons.search_sharp,size: 24,color: AppColor.colGrey,),
              
                     Text("   Mobile No.",style: rubikTextStyle(15, FontWeight.w500, AppColor.colBlack,)),],
                      ),
                     )
                         
                  ],),
              ),
            ), 

            SizedBox(height: Sizes.height*0.02,),
             Card(
            // width: double.infinity,
            // decoration: BoxDecoration(color: AppColor.colWhite,borderRadius: BorderRadius.circular(5)),
                        child: Padding(
                           padding: EdgeInsets.symmetric(vertical: Sizes.height*0.01,horizontal: Sizes.width*0.04),
                          child: Column(
                            children: [
  SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        width: Sizes.width*1.4,
                      child:    StackedColumnChart(),
                          ),),
                              GridView.count(
                                crossAxisCount: 2,
                                childAspectRatio: 4,
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                children: [
                                ListTile(dense:true,title: Text("Sales Colsed"), trailing: Container(height: 20,width: 20,decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),
                                              color: AppColor.colFbCircle,),),),
                                ListTile(dense:true,title: Text("Lost"),trailing: Container(height: 20,width: 20,decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),
                                        color: AppColor.colYellow,),),),
                                ListTile(dense:true,title: Text("In process"),trailing:  Container(height: 20,width: 20,decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),
                                            color: AppColor.colTeal,),) ),
                                ListTile(dense:true,title: Text("Not Interested"),trailing: Container(height: 20,width: 20,decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),
                                        color: AppColor.colRideFare,),),),
                              ],)
                            ],
                          ))),
          SizedBox(height: Sizes.height*0.02,),
            Card(
            // width: double.infinity,
            // decoration: BoxDecoration(color: AppColor.colWhite,borderRadius: BorderRadius.circular(5)),
                        child: Padding(
                           padding: EdgeInsets.symmetric(vertical: Sizes.height*0.01,horizontal: Sizes.width*0.04),
                          child: Column(
                            children: [ 
                               ListTile(
                               
                                title: Text("Enquery Type",style: rubikTextStyle(16, FontWeight.w500, AppColor.colBlack,)),
                                trailing: IconButton(
                  onPressed: (){

                  },
                   icon: Column(
                     children: [
                       Icon(Icons.filter_alt_outlined,color: AppColor.colPrimary,size: 20,),
                       Text("Filter",style: rubikTextStyle(10, FontWeight.w500, AppColor.colPrimary),)
                     ],
                   ),
                 ),
                                ),       
                         SfCircularChart(
                             series: <CircularSeries>[
                               DoughnutSeries<ChartData, String>(
                                 dataSource: <ChartData>[
                                   ChartData('Online', 10, color: AppColor.colPriLite),
                                   ChartData('Camping', 30, color: AppColor.colPrimary),
                                   ChartData('Call', 40, color: AppColor.colYellow),
                                   ChartData('Visit', 20, color: AppColor.colRideFare),
                                 ],
                                 pointColorMapper: (ChartData data, _) => data.color,
                                 xValueMapper: (ChartData data, _) => data.x,
                                 yValueMapper: (ChartData data, _) => data.y,
                                 dataLabelSettings: DataLabelSettings(
                                   isVisible: true,
                                   labelPosition: ChartDataLabelPosition.outside,
                                 ),
                                 dataLabelMapper: (ChartData data, _) => '${data.x}: ${data.y.toStringAsFixed(0)}%', // Customize label text
                               ),
                             ],
                           ),
                           ],
                          ),
                        ),
          ),
           // Responsive(
            //   mobile: Registration(registrationList: registrationList, crossAxisCount: 1),
            //   desktop: Registration(registrationList: registrationList, childAspectRatio: Sizes.width < 1400 ? 2 : 2.5,crossAxisCount: 3),
            //   tablet: Registration(registrationList: registrationList, crossAxisCount:2,childAspectRatio: Sizes.width < 1400 ? 2 : 2.5),
            // ),
            // SizedBox(height: Sizes.height * 0.05),
          ],
        ),
      ),
    );
  }
}

class Registration extends StatelessWidget {
  final List<Map<String, dynamic>> registrationList;
  final int crossAxisCount;
  final double childAspectRatio;

  const Registration({Key? key, required this.registrationList, this.crossAxisCount = 3, this.childAspectRatio = 2.5}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      itemCount: registrationList.length,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        childAspectRatio: childAspectRatio,
        crossAxisSpacing: Sizes.width * 0.015,
        crossAxisCount: crossAxisCount,
      ),
      itemBuilder: (context, index) => Card(
        elevation: 0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(registrationList[index]["title"]),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: registrationList[index]["color"],
              ),
              padding: EdgeInsets.all(Sizes.width * 0.02),
              child: Text(
                registrationList[index]["users"],
                style: TextStyle(),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FileInfoCard extends StatelessWidget {
  final List<Map<String, dynamic>> dataList;
  final int crossAxisCount;
  final double childAspectRatio;

  const FileInfoCard({Key? key, required this.dataList, this.crossAxisCount = 5, this.childAspectRatio = 1.4}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      itemCount: dataList.length,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        childAspectRatio: childAspectRatio,
        crossAxisSpacing: Sizes.width * 0.015,
        crossAxisCount: crossAxisCount,
      ),
      itemBuilder: (context, index) => InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => AddQueries(index: index,)));
              },
        child: Card(
        
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.all(7),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: dataList[index]["color"],
                      ),
                      child: dataList[index]["icon"],
                    ),
                 if (index==3) IconButton(
                  onPressed: (){

                  },
                   icon: Column(
                     children: [
                       Icon(Icons.filter_alt_outlined,color: AppColor.colPrimary,size: 20,),
                       Text("Filter",style: rubikTextStyle(10, FontWeight.w500, AppColor.colPrimary),)
                     ],
                   ),
                 ) else Container(),
                  ],
                ),
              ),
                  Text(dataList[index]["users"], overflow: TextOverflow.ellipsis,style: rubikTextStyle(25, FontWeight.w500, AppColor.colBlack),),
             Text(dataList[index]["title"], overflow: TextOverflow.ellipsis,style: rubikTextStyle(13, FontWeight.w500, AppColor.colBlack),),
                 
            ],
          ),
        ),
      ),
    );
  }
}

class ChartData {
  final String x;
  final double y;
  final Color color;

  ChartData(this.x, this.y, {this.color = Colors.blue});
}


class StackedColumnChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      primaryXAxis: CategoryAxis(
        // initialZoomFactor: .6,
    maximumLabelWidth: 200, // Adjust label width as needed
  ),
      series: <CartesianSeries>[
        StackedColumnSeries<SkillData, String>(
          color: AppColor.colFbCircle,
          dataSource: <SkillData>[
            
            SkillData('Person 1', 20, 30, 40, 30),
            SkillData('Person 2', 30, 40, 25, 30),
            SkillData('Person 3', 25, 35, 30, 30),
            SkillData('Person 4', 35, 25, 40, 30),
            SkillData('Person 5', 40, 20, 35, 30),
            SkillData('Person 6', 40, 20, 35, 30),
            SkillData('Person 7', 40, 20, 35, 30),
          ],
          xValueMapper: (SkillData skill, _) => skill.person,
      yValueMapper: (SkillData skill, _) => skill.skill1,
      dataLabelSettings: DataLabelSettings(isVisible: true),
      width: 0.8,
    
        ),
        StackedColumnSeries<SkillData, String>(
          color: AppColor.colTeal,
          dataSource: <SkillData>[

            SkillData('Person 1', 20, 30, 40,30),
            SkillData('Person 2', 30, 40, 25,30),
            SkillData('Person 3', 25, 35, 30,30),
            SkillData('Person 4', 35, 25, 40,30),
            SkillData('Person 5', 40, 20, 35,30),
            SkillData('Person 6', 40, 20, 35,30),
            SkillData('Person 7', 40, 20, 35,30),
          ],
          xValueMapper: (SkillData skill, _) => skill.person,
          yValueMapper: (SkillData skill, _) => skill.skill2,
          dataLabelSettings: DataLabelSettings(isVisible: true),
          width: 0.8,
        ),
        
        StackedColumnSeries<SkillData, String>(
          color: AppColor.colRideFare,
          dataSource: <SkillData>[
            
            SkillData('Person 1', 20, 30, 40, 30),
            SkillData('Person 2', 30, 40, 25, 30),
            SkillData('Person 3', 25, 35, 30, 30),
            SkillData('Person 4', 35, 25, 40, 30),
            SkillData('Person 5', 40, 20, 35, 30),
            SkillData('Person 6', 40, 20, 35, 30),
            SkillData('Person 7', 40, 20, 35, 30),
          ],
          xValueMapper: (SkillData skill, _) => skill.person,
          yValueMapper: (SkillData skill, _) => skill.skill3,
          dataLabelSettings: DataLabelSettings(isVisible: true),
          width: 0.8,
        ),
      
        StackedColumnSeries<SkillData, String>(
          color: AppColor.colYellow,
          dataSource: <SkillData>[
            
            SkillData('Person 1', 10, 30, 40, 25),
            SkillData('Person 2', 30, 40, 25, 40),
            SkillData('Person 3', 25, 35, 30, 50),
            SkillData('Person 4', 35, 25, 40, 30),
            SkillData('Person 5', 40, 20, 35, 25),
            SkillData('Person 6', 40, 20, 35, 35),
            SkillData('Person 7', 40, 20, 35, 30),
          ],
          xValueMapper: (SkillData skill, _) => skill.person,
          yValueMapper: (SkillData skill, _) => skill.skill4,
          dataLabelSettings: DataLabelSettings(isVisible: true),
          width: 0.8,
        ),
      
      ],
    );
  }
}

class SkillData {
  final String person;
  final int skill1;
  final int skill2;
  final int skill3;
  final int skill4;

  SkillData(this.person, this.skill1, this.skill2, this.skill3,this.skill4);
}