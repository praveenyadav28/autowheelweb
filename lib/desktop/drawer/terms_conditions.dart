import 'package:autowheelweb/Components/menuController.dart';
import 'package:autowheelweb/Utils/api.dart';
import 'package:autowheelweb/Utils/colors.dart';
import 'package:autowheelweb/Utils/mediaquery.dart';
import 'package:autowheelweb/Utils/responsive.dart';
import 'package:autowheelweb/Utils/textstyle.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TermsConditions extends StatefulWidget {
  const TermsConditions({super.key});

  @override
  State<TermsConditions> createState() => _TermsConditionsState();
}

class _TermsConditionsState extends State<TermsConditions> {
  Map<String, dynamic> _data = {};

  @override
  void initState() {
    super.initState();
    fetchData();
  }


  Future<void> fetchData() async {
    try {
      final data = await ApiService.fetchData('GetTerms');
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
        title: const Text("Terms & Conditions", overflow: TextOverflow.ellipsis),
      ),
      backgroundColor: AppColor.colPrimary.withOpacity(.1),
      body: _data.isNotEmpty
          ?Padding(
            padding:  EdgeInsets.symmetric(vertical: Sizes.height*.02,horizontal: Sizes.width*0.04),
            child: Text('${_data['details']}',style: rubikTextStyle(18, FontWeight.w400, AppColor.colBlack),),
          ):const Center(child: CircularProgressIndicator(),));}}
