import 'package:flutter/material.dart';
import 'package:mental_health_tracker/DashboardPage.dart';
import 'package:mental_health_tracker/login_page.dart';
import 'package:mental_health_tracker/main_page.dart';
import 'package:mental_health_tracker/register.dart';
import 'package:mental_health_tracker/spalsh.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://mbjdmispevhzhoisxbic.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im1iamRtaXNwZXZoemhvaXN4YmljIiwicm9sZSI6ImFub24iLCJpYXQiOjE2OTA4MDE1ODEsImV4cCI6MjAwNjM3NzU4MX0.fT9UPegVwdpuhkKId25xBfvqEsQIHMiRuGgo_GsMkfc',
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => MainPage(),
        '/second': (context) => registerPage(),
        '/third': (context) => LoginPage(),
        '/fourth': (context) => DashboardPage(),
      },
    );
  }
}
