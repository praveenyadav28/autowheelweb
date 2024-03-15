// ignore_for_file: file_names, non_constant_identifier_names, prefer_typing_uninitialized_variables

import 'package:autowheelweb/desktop/drawer/allprospact.dart';
import 'package:autowheelweb/desktop/drawer/contactus.dart';
import 'package:autowheelweb/desktop/dashboardScreen.dart';
import 'package:autowheelweb/desktop/drawer/myaccount.dart';
import 'package:autowheelweb/desktop/followup.dart';
import 'package:autowheelweb/desktop/prospect.dart';
import 'package:autowheelweb/desktop/drawer/terms_conditions.dart';
import 'package:flutter/material.dart';
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
                  value.onChanged( const MyAccount(),context);
                },
                Title: "My Account",
              ),
              DrawerListtile(
                onTap: () {
                  value.onChanged( const DashboardScreen(),context);
                },
                Title: "Dashboard",
              ),
              DrawerListtile(
                onTap: () {
                  value.onChanged( ProspectScreen(),context);
                },
                Title: "Add Prospect",
              ),
              DrawerListtile(
                onTap: () {
                  value.onChanged( const AllProspacts(),context);
                },
                Title: "All Prospect",
              ),
              DrawerListtile(
                onTap: () {
                  value.onChanged( FollowUpScreen(value: true,),context);
                },
                Title: "Follow Up",
              ),
              DrawerListtile(
                onTap: () {
                  value.onChanged(const TermsConditions(),context);
                },
                Title: "Terms & Conditions",
              ),
              DrawerListtile(
                onTap: () {
                  value.onChanged(const ContactUs(),context);
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
