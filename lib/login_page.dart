import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mental_health_tracker/DashboardPage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Main_page.dart';
import 'config.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}
class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  late SharedPreferences prefs;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initSharedPref();
  }

  void initSharedPref() async {
    prefs = await SharedPreferences.getInstance();
  }

  void loginUser() async {
    if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
      var reqBody = {
        "email": emailController.text,
        "password": passwordController.text
      };
      var response = await http.post(Uri.parse(login),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(reqBody));

      var jsonResponse = jsonDecode(response.body);

      if (jsonResponse['status']) {
        var myToken = jsonResponse['token'];
        prefs.setString('token', myToken);
        Navigator.pushNamed(
            context, '/fourth');
      } else {
        print('Something went wrong');
      }
    }
  }

  void clearText() {
    emailController.clear();
    passwordController.clear();
  }

  @override
  Widget build(BuildContext context) {
    Size mq = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                child: Image.asset(
                  'images/landscape.jpeg',
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                alignment: Alignment.topCenter,
                child: Text(
                  'SLEEP TRACKER',
                  style:TextStyle(
                    height: 2.5,
                    color: Colors.black,
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: mq.height * 0.26),
                height: mq.height, // Set the height for the gradient area
                width: mq.width,
                decoration: BoxDecoration(
                  color: Color(0xff3C2177), // Replace the gradientColors with a single solid color
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(50),
                    topLeft: Radius.circular(50),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: mq.height * 0.35),
                child: Column(
                  children: [
                    SizedBox(height: mq.height * .04),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.grey.shade500,
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(15)),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: TextField(
                            controller: emailController,
                            decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Email-Id',
                                hintStyle: TextStyle(color: Colors.black)),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: mq.height * .03),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.grey.shade500,
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(15)),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: TextField(
                            controller: passwordController,
                            obscureText: true,
                            decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Password',
                                hintStyle: TextStyle(color: Colors.black)),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: mq.height * .015),
                    const Padding(
                      padding: EdgeInsets.only(left: 235.0),
                      child: Row(
                        children: [
                          Text(
                            'Forgot Password ? ',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: mq.height * .03),
                    ElevatedButton.icon(
                      onPressed: () {
                        loginUser();
                        clearText();
                      },
                      label: const Text(
                        'LOGIN',
                        style: TextStyle(fontSize: 18),
                      ),
                      style: ElevatedButton.styleFrom(
                          shape: StadiumBorder(),
                          backgroundColor: Color(0xff0E4393),
                          minimumSize: Size(mq.width * .6, mq.height * .075)),
                      icon: const Icon(
                        Icons.login,
                        size: 25,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 8.0),
                      child: Text(
                        'OR',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(height: mq.height * .020),
                    ElevatedButton.icon(
                      onPressed: () {},
                      label: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Text(
                          'Login with Google',
                          style: TextStyle(
                              fontSize: 20, color: Colors.grey.shade500),
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                          backgroundColor: Colors.white,
                          padding: const EdgeInsets.all(8),
                          minimumSize: Size(mq.width * .6, mq.height * .075)),
                      icon: Padding(
                        padding: const EdgeInsets.only(left: 25),
                        child: Image.asset('images/google.png',
                            height: mq.height * .038),
                      ),
                    ),
                    SizedBox(height: mq.height * .03),
                    ElevatedButton.icon(
                      onPressed: () {},
                      label: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          'Login with Facebook',
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                          backgroundColor: Colors.blue.shade700,
                          padding: const EdgeInsets.all(8),
                          minimumSize: Size(mq.width * .6, mq.height * .075)),
                      icon: Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: Image.asset('images/facebook.png',
                            height: mq.height * .04),
                      ),
                    ),
                    const SizedBox(height: 15),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

