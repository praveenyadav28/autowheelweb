// ignore_for_file: file_names, non_constant_identifier_names, camel_case_types, prefer_const_constructors, unused_import, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Components/Sidemenu.dart';
import '../Components/menuController.dart';
import '../Utils/mediaquery.dart';
import '../Utils/textstyle.dart';
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
      "color": Colors.red.withOpacity(0.1),
      "title": "Active",
      "users": "1263"
    },
    {
      "icon": Icon(Icons.person),
      "color": Colors.blue.withOpacity(0.1),
      "title": "Online",
      "users": "704"
    },
    {
      "icon": Icon(Icons.verified_user),
      "color": Colors.green.withOpacity(0.1),
      "title": "Verified",
      "users": "800"
    },
    {
      "icon": Icon(Icons.info),
      "color": Colors.yellow.withOpacity(0.1),
      "title": "Reported",
      "users": "100"
    },
    {
      "icon": Icon(Icons.no_accounts),
      "color": Colors.orange.withOpacity(0.1),
      "title": "Blocked",
      "users": "80"
    },
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
        padding: EdgeInsets.symmetric(horizontal: Sizes.height * 0.03),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: Sizes.height * 0.05),
            Responsive(
              mobile: FileInfoCard(dataList: dataList, crossAxisCount: 2),
              desktop: FileInfoCard(dataList: dataList, childAspectRatio: Sizes.width < 1400 ? 1.1 : 1.4),
              tablet: FileInfoCard(dataList: dataList, crossAxisCount: Sizes.width < 1100 ? 3 : 5),
            ),
            SizedBox(height: Sizes.height * .1),
            Responsive(
              mobile: Registration(registrationList: registrationList, crossAxisCount: 1),
              desktop: Registration(registrationList: registrationList, childAspectRatio: Sizes.width < 1400 ? 2 : 2.5,crossAxisCount: 3),
              tablet: Registration(registrationList: registrationList, crossAxisCount:2,childAspectRatio: Sizes.width < 1400 ? 2 : 2.5),
            ),
            SizedBox(height: Sizes.height * 0.05),
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
      itemBuilder: (context, index) => Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(Sizes.width * 0.01),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: dataList[index]["color"],
              ),
              child: dataList[index]["icon"],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(dataList[index]["title"], overflow: TextOverflow.ellipsis),
                Text(dataList[index]["users"], overflow: TextOverflow.ellipsis),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
