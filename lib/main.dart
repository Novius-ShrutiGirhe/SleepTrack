

import 'package:flutter/material.dart';
import 'package:mental_health_tracker/DashboardPage.dart';
import 'package:mental_health_tracker/login_page.dart';
import 'package:mental_health_tracker/main_page.dart';
import 'package:mental_health_tracker/register.dart';
import 'package:mental_health_tracker/spalsh.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => DashboardPage(),
      '/second': (context) => registerPage(),
      '/third': (context) => LoginPage(),
      '/fourth':(context) => DashboardPage(),
    },
  ));
}
