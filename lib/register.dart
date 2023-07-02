import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mental_health_tracker/Main_page.dart';
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
    if (_emailController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty &&
        _nameController.text.isNotEmpty) {
      var regBody = {
        "name": _nameController.text,
        "email": _emailController.text,
        "password": _passwordController.text,
      };
      var response = await http.post(Uri.parse(registration),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(regBody));
      var jsonResponse = jsonDecode(response.body);
      print(jsonResponse['status']);
      if (jsonResponse['status']) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const MainPage()));
      } else {
        print('Something went wrong');
      }
    } else {
      setState(() {
        _isNotValidate = true;
      });
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
    return Scaffold(
      backgroundColor: const Color(0xff3C2177),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset('images/landscape.jpeg'),
            SizedBox(height: mq.height * .08),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.grey.shade500,
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(15)),
                child: Padding(
                  padding: EdgeInsets.only(left: 20.0),
                  child: TextField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Name',
                        hintStyle: TextStyle(color: Colors.black)),
                  ),
                ),
              ),
            ),
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
                    controller: _emailController,
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Email-Id',
                        hintStyle: TextStyle(color: Colors.black)),
                  ),
                ),
              ),
            ),
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
                  child: TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Password',
                        hintStyle: TextStyle(color: Colors.black)),
                  ),
                ),
              ),
            ),
            SizedBox(height: mq.height * .05),
            ElevatedButton.icon(
              onPressed: () {
                registerUser();
                clearText();
              },
              label: const Text(
                'REGISTER',
                style: TextStyle(fontSize: 18),
              ),
              style: ElevatedButton.styleFrom(
                  shape: const StadiumBorder(),
                  backgroundColor: const Color(0xff0E4393),
                  minimumSize: Size(mq.width * .6, mq.height * .075)),
              icon: const Icon(
                Icons.login,
                size: 25,
              ),
            ),
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.only(left: 120.0),
              child: Row(
                children: [
                  const Text(
                    'Already registerd ? ',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginPage()));
                    },
                    child: const Text(
                      ' Sign In',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.blue),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
