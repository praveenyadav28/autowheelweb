// ignore_for_file: constant_identifier_names

import 'package:autowheelweb/Components/menuController.dart';
import 'package:autowheelweb/Utils/api.dart';
import 'package:autowheelweb/Utils/colors.dart';
import 'package:autowheelweb/Utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUs extends StatefulWidget {
  const ContactUs({super.key});

  @override
  State<ContactUs> createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  Map<String, dynamic> _data = {};

  @override
  void initState() {
    super.initState();
    fetchData();
  }


  Future<void> fetchData() async {
    try {
      final data = await ApiService.fetchData('GetContactUs');
      setState(() {
        _data = data;
      });
    } catch (e) {
      // Handle error
     }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( leading: (!Responsive.isDesktop(context))
            ? IconButton(
                onPressed: context.read<MenuControlle>().controlMenu,
                icon: const Icon(Icons.menu))
            : Container(),
            centerTitle: true,
        title: const Text("Contact US", overflow: TextOverflow.ellipsis),
      ),
      backgroundColor: AppColor.colPrimary.withOpacity(.1),
      body: _data.isNotEmpty
          ? Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                ListTile(leading: const Icon(Icons.person), title: const Text("Name:"), subtitle: Text('${_data['name']}'),),
                ListTile(
                  onTap: (){
                    showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Choose Type'),
                content:  Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [ 
              
             InkWell(
              child:   Image.asset("assets/google-messages-icon.png",height: 40,),
              onTap: (){_openLink(context, '${_data['mobileno']}', LinkType.Message);},
            ),
            InkWell(
              child: Image.asset("assets/phone-call.png",height: 30,),
              onTap: () {_openLink(context, '${_data['mobileno']}', LinkType.Call);},
            ),
            InkWell(
              child: Image.asset("assets/WhatsApp_icon.png",height: 45,),
              onTap: (){_openLink(context, '${_data['mobileno']}', LinkType.WhatsApp);},
            ),
          ],),
                   
                actions: <Widget>[
                  TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Closes the dialog
          },
          child: const Text('Close'),
                  ),
                ],
              ),
            );
                  },
                  leading: Icon(Icons.phone,color: AppColor.colPrimary), title: const Text("Mobile No:"),  subtitle: Text('${_data['mobileno']}'),),
                ListTile(
                  onTap: (){_openLink(context, '${_data['emailid']}', LinkType.Mail);},
                  leading: Icon(Icons.email,color: AppColor.colPrimary), title: const Text("Email ID:"),  subtitle: Text('${_data['emailid']}'),),
                ListTile(
                  onTap: (){_openLink(context, '${_data['website']}', LinkType.Website);},
                  leading: Icon(Icons.language,color: AppColor.colPrimary,), title: const Text("Website:"),  subtitle: Text('${_data['website']}'),),
            
              ],
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }
  Future<void> _openLink(BuildContext context, String value, LinkType type,) async {
    String url;
    switch (type) {
      case LinkType.WhatsApp:
        url = "https://wa.me/+91$value?text=Hello";
        break;
      case LinkType.Mail:
        url = "mailto:$value?subject=Subject&body=Body";
        break;
      case LinkType.Website:
        url = "http://$value";
        break;
      case LinkType.Call:
        url = "tel:1414805106";
        break;
      case LinkType.Message:
        url = "sms:$value?body=Hello";
        break;
    }
     if (!await launchUrl(
      Uri.parse(url),
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch ');
    }
  }
}

enum LinkType {
  WhatsApp,
  Mail,
  Website,
  Call,
  Message,
}
