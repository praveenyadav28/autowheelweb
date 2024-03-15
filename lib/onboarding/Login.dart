// ignore_for_file: non_constant_identifier_names, file_names, use_full_hex_values_for_flutter_colors, prefer_const_constructors

import 'package:autowheelweb/Utils/mediaquery.dart';
import 'package:autowheelweb/Utils/textfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/fullscreen.dart';
import '../components/menuController.dart';
import '../Utils/Colors.dart';
import '../Utils/responsive.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController licenseController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: !Responsive.isMobile(context)
            ? AppColor.colPrimary.withOpacity(.2)
            : AppColor.colWhite,
        body: !Responsive.isMobile(context)
            ? Form(
                key: _formKey,
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                      width: 500, 
                        alignment: Alignment.center,
                        padding: EdgeInsets.symmetric(horizontal: Sizes.width * 0.04, vertical: 35),
                        color: AppColor.colPrimary.withOpacity(0.2),
                        child: Loginmain(),
                      ),
                    ],
                  ),
                ),
              )
            : Form(
                key: _formKey,
                child: Container(
                    width: Sizes.width * 1,
                    color: AppColor.colWhite,
                    height: Sizes.height * 1,
                    child: SingleChildScrollView(
                        child: Padding(
                      padding: EdgeInsets.only(left:Sizes.width * 0.04,right: Sizes.width * 0.04, top:Sizes.height * 0.15 ),
                      child: Loginmain(),
                    ))),
              ));
  }

  Column Loginmain() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset("assets/autowheellogo2.png",height: Sizes.height*.2,),
        const SizedBox(
          height: 50,
        ),
        TextFormField(
          controller: licenseController,
          style:  TextStyle(color: AppColor.colBlack, fontSize: 20),
          validator: (value) {
            if (value!.isEmpty) {
              return "Please enter license";
            } else if (licenseController.text != "123456") {
              return "Please enter valid license id";
            }
            return null;
          },
          keyboardType: TextInputType.number,
          decoration:  InputDecoration(
            contentPadding:
                EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            hintText: "License Id",
            hintStyle: TextStyle(color: AppColor.colBlack, fontSize: 20),
            filled: true,
            suffixIcon: Icon(Icons.person),
            fillColor: AppColor.colWhite,
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColor.colPrimary, width: 1.0),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColor.colPrimary, width: 1.0),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: AppColor.colPrimary, width: 0.01),
            ),
          ),
        ),
        SizedBox(
          height: Sizes.height * 0.04,
        ),
        TextFormField(
          obscureText: _isObscure,
          controller: passwordController,
          validator: (value) {
            if (value!.isEmpty) {
              return "Please enter password";
            } else if (passwordController.text != "abc123") {
              return "Please enter correct password";
            }
            return null;
          },
          style:  TextStyle(color: AppColor.colBlack, fontSize: 20),
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(10),
            hintText: "Passwoard",
            hintStyle:  TextStyle(color: AppColor.colBlack, fontSize: 20),
            filled: true,
            suffixIcon: IconButton(
                icon: Icon(
                    _isObscure ? Icons.visibility_off : Icons.visibility),
                onPressed: () {
                  setState(() {
                    _isObscure = !_isObscure;
                  });
                }),
            fillColor: AppColor.colWhite,
            focusedBorder:  OutlineInputBorder(
              borderSide: BorderSide(color: AppColor.colPrimary, width: 1.0),
            ),
            errorBorder:  OutlineInputBorder(
              borderSide: BorderSide(color: AppColor.colPrimary, width: 1.0),
            ),
            border:  OutlineInputBorder(
              borderSide: BorderSide(color: AppColor.colPrimary, width: 0.01),
            ),
          ),
        ),
        SizedBox(
          height: Sizes.height * 0.04,
        ),
        InkWell(
          onTap: () {
            if (_formKey.currentState!.validate()) {
             Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MultiProvider(
                      providers: [
                        ChangeNotifierProvider<Classvaluechange>(
                            create: (_) => Classvaluechange()),
                        ChangeNotifierProvider(
                            create: (context) => MenuControlle())
                      ],
                      child: const FullScreen(),
                    ),
                  ));
            }
          },
          child: Button(
              'Login',AppColor.colPrimary
          ),
        )
      ],
    );
  }
}
