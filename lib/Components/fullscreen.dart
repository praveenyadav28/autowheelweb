// ignore_for_file: file_names

import 'package:autowheelweb/Components/menuController.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Utils/responsive.dart';
import 'Sidemenu.dart';

class FullScreen extends StatefulWidget {
  const FullScreen({super.key});

  @override
  State<FullScreen> createState() => _FullScreenState();
}

class _FullScreenState extends State<FullScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<Classvaluechange>(builder: (context, cangedclass, child) {
      return Scaffold(
          key: context.read<MenuControlle>().scaffoldKey,
          drawer: const SideMenu(),
          body: SafeArea(
            child: Row(
              children: [
                if (Responsive.isDesktop(context))
                  const Expanded(child: SideMenu()),
                Expanded(flex: 5, child: klass)
              ],
            ),
          ));
    });
  }
}
