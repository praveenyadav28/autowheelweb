// ignore_for_file: file_names
import 'package:flutter/material.dart';
import '../desktop/dashboardScreen.dart';

class MenuControlle extends ChangeNotifier {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;
  void controlMenu() {
    if (!_scaffoldKey.currentState!.isDrawerOpen) {
      _scaffoldKey.currentState?.openDrawer();
    }
  }
}

dynamic klass = const DashboardScreen();

class Classvaluechange extends ChangeNotifier {
  onChanged(Object? cangedclass, BuildContext context) {
    klass = cangedclass;
    notifyListeners();
    Navigator.pop(context);
  }
}
