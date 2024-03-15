// ignore_for_file: file_names

import 'package:autowheelweb/Utils/colors.dart';
import 'package:autowheelweb/Utils/mediaquery.dart';
import 'package:autowheelweb/Utils/textfield.dart';
import 'package:flutter/material.dart';

class SearchProspect extends StatefulWidget {
  const SearchProspect({super.key});

  @override
  State<SearchProspect> createState() => _SearchProspectState();
}

class _SearchProspectState extends State<SearchProspect> {
  final TextEditingController _mobileController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
       appBar: AppBar( 
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: const Icon(Icons.arrow_back_ios)),
            centerTitle: true,
        title: const Text("Search Prospect", overflow: TextOverflow.ellipsis),
      ),
      backgroundColor: AppColor.colWhite,
      body: Container(
        height: Sizes.height,
        color: AppColor.colPrimary.withOpacity(.1),
        child: SingleChildScrollView(
           child: Padding(
            padding: EdgeInsets.symmetric(horizontal: Sizes.width * 0.05,vertical: Sizes.height*0.02),
             child: Column(children: [
              textformfiles(_mobileController,labelText: 'Mobile No. / Customer Name',prefixIcon: Icon(Icons.search,size: 30,color: AppColor.colBlack,)),
              SizedBox(height: Sizes.height*0.02),            
             ],),
           ),
         ),
      )
    );
  }
}