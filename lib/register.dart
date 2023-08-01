import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mental_health_tracker/DashboardPage.dart';
import 'package:mental_health_tracker/Main_page.dart';
import 'package:mental_health_tracker/spalsh.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'login_page.dart';
import 'config.dart';

class registerPage extends StatefulWidget {
  const registerPage({Key? key}) : super(key: key);

  @override
  State<registerPage> createState() => _registerPageState();
}

class _registerPageState extends State<registerPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();

  bool _isNotValidate = false;

  void registerUser() async {
    final supabase = Supabase.instance.client;
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    try {
      final response1 = await supabase.auth.signUp(
        email: email,
        password: password,
      );
      print('User created');
    } catch (error) {
      print('User creation failed');
    }
  }


  void clearText() {
    _emailController.clear();
    _nameController.clear();
    _passwordController.clear();
  }

  @override
  Widget build(BuildContext context) {
    Size mq = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
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
                      style: TextStyle(
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
                        SizedBox(height: mq.height * .03),
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.grey.shade500,
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 15),
                              child: TextField(
                                controller: _nameController,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Name',
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: mq.height * .001),
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.grey.shade500,
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 15),
                              child: TextField(
                                controller: _emailController,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Email Id',
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: mq.height * .00001),
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.grey.shade500,
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 15),
                              child: TextField(
                                controller: _passwordController,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Password',
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: mq.height * .01),
                        ElevatedButton.icon(
                          onPressed: () {
                            registerUser();
                            clearText();
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) => DashboardPage()));
                          },
                          label: const Text(
                            'REGISTER',
                            style: TextStyle(fontSize: 18),
                          ),
                          style: ElevatedButton.styleFrom(
                            shape: StadiumBorder(),
                            backgroundColor: const Color(0xff0E4393),
                            minimumSize: Size(mq.width * .6, mq.height * .075),
                          ),
                          icon: const Icon(
                            Icons.login,
                            size: 25,
                          ),
                        ),
                        SizedBox(height: mq.height * .02),
                        Padding(
                          padding: EdgeInsets.only(left: 100.0),
                          child: Row(
                            children: [
                              Text(
                                'Already have an account? ',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, '/third'
                                  );
                                },
                                child: Text(
                                  'SignIn',
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
