// ignore_for_file: file_names, non_constant_identifier_names, prefer_typing_uninitialized_variables

import 'package:autowheelweb/desktop/dashboardScreen.dart';
import 'package:autowheelweb/desktop/followup.dart';
import 'package:autowheelweb/desktop/prospect.dart';
import 'package:autowheelweb/desktop/report.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../Utils/Colors.dart';
import '../onboarding/Login.dart';
import 'menuController.dart';

class SideMenu extends StatefulWidget {
  const SideMenu({super.key});

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  @override
  Widget build(BuildContext context) {
    return Consumer<Classvaluechange>(builder: (context, value, child) {
      return Drawer(
        backgroundColor: AppColor.colWhite,
        child: SingleChildScrollView(
          child: Column(
            children: [
              DrawerHeader(child: Image.asset("assets/autowheellogo2.png",)),
              DrawerListtile(
                onTap: () {
                  // value.onChanged( DashboardScreen(),context);
                },
                Title: "My Account",
              ),
              DrawerListtile(
                onTap: () {
                  value.onChanged( DashboardScreen(),context);
                },
                Title: "Dashboard",
              ),
              DrawerListtile(
                onTap: () {
                  value.onChanged( ProspectScreen(),context);
                },
                Title: "Prospect",
              ),
              DrawerListtile(
                onTap: () {
                  value.onChanged(const ReportScreen(),context);
                },
                Title: "Scheduled Report",
              ),
              DrawerListtile(
                onTap: () {
                  value.onChanged( FollowUpScreen(value: true,),context);
                },
                Title: "Follow Up",
              ),
              DrawerListtile(
                onTap: () {
                  // value.onChanged(const ReportedUsers());
                },
                Title: "Closed Sale",
              ),
             DrawerListtile(
                onTap: () {
                  // value.onChanged(const AdminUsers());
                },
                Title: "Terms & Conditions",
              ),
              DrawerListtile(
                onTap: () {
                  // value.onChanged(const Message());
                },
                Title: "Contact Us",
              ),
              
            
              DrawerListtile(
                onTap: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginScreen(),
                      ),
                      (route) => false);
                },
                Title: "Logout",
                style:  TextStyle(
                    color: AppColor.colRideFare, fontWeight: FontWeight.w800),
              ),
            ],
          ),
        ),
      );
    });
  }
}

class DrawerListtile extends StatelessWidget {
  const DrawerListtile({
    required this.Title,
    required this.onTap,
    this.style,
    super.key,
  });
  final String Title;
  final style;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      title: Text(
        Title,
        style: style,
      ),
    );
  }
}
