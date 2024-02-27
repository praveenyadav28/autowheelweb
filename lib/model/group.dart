// ignore_for_file: body_might_complete_normally_nullable, must_be_immutable, non_constant_identifier_names, use_build_context_synchronously, avoid_print
import 'dart:convert';
import 'package:autowheelweb/Utils/Colors.dart';
import 'package:autowheelweb/Utils/mediaquery.dart';
import 'package:autowheelweb/Utils/textfield.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddGroupScreen extends StatefulWidget {
  int? sourecID;
  String? name;
  AddGroupScreen({super.key,  this.sourecID,required this.name});

  @override
  State<AddGroupScreen> createState() => _AddGroupScreenState();
}

class _AddGroupScreenState extends State<AddGroupScreen> {
  var Groupcontroller = TextEditingController();
  bool isSearchMode = false;

  @override
  void initState() {
    super.initState();
    // postData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Add ${widget.name}"),
        iconTheme: IconThemeData(color: AppColor.colWhite),
        elevation: 2,
        backgroundColor: AppColor.colPrimary,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context, "refresh");
            },
            icon: const Icon(Icons.arrow_back_ios)),
      ),
      backgroundColor: AppColor.colWhite,
      body: Container(
        height: double.infinity,
        color: AppColor.colPrimary.withOpacity(.1),
        padding:  EdgeInsets.symmetric(vertical: Sizes.height*0.04, horizontal: Sizes.width*.04),
        child: SingleChildScrollView(
          child: Column(
            children: [
              textformfiles(Groupcontroller,
                  validator: (p0) {},
                  label: const Text("Group"),
                  prefixIcon: Icon(
                    Icons.code,
                    color: AppColor.colGrey,
                  )),
              SizedBox(height:Sizes.height*0.1),
              InkWell(
                  onTap: () {
                    postData();
                  },
                  child: Button("Save",AppColor.colPrimary)),

              // redButton(delettxt)
            ],
          ),
        ),
      ),
    );
  }

  Future<void> postData() async {
    final url =
        Uri.parse('http://lms.muepetro.com/api/UserController1/PostMiscMaster');
    final data = {
      "Name": Groupcontroller.text,
      "LocationId": 12,
      "MiscMasterId": widget.sourecID,
    };
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(data),
      );
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        if (responseData['result'] == true) {
           ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content:Text ("Details saved successfully"),
              backgroundColor: Colors.green,
             ));
          Navigator.pop(context);
        } else if (responseData['message'] == "Name already exists") {
             ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content:Text ("Name already exists. Please use a different name."),
              backgroundColor: Colors.red,
             ));
        } else {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content:Text ("An error occurred while saving the details"),
              backgroundColor: Colors.red,
             ));
        }
      } else {
        print('Request failed with status: ${response.statusCode}');
        print('Response Data: ${response.body}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }
}
