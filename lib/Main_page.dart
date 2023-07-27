import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    List<Color> gradientColors = [
      Color(0xFF9D74F3),
      Color(0xFF623DB0),
      Color(0xFF3C2177),
      Color(0xFF17043E),
    ];
    Color buttonColor = Color(0xFF0E4393);
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: gradientColors,
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          Positioned(
            top: -30,
            left: 20,
            child: Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white30,
                border: Border.all(
                  color: Colors.white30,
                  width:1,
                ),
              ),
            ),
          ),
          Positioned(
            top: 40,
            left:-50,
            child: Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white30,
                border: Border.all(
                  color: Colors.white30,
                  width: 1,
                ),
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.alarm,
                  size: 200,
                  color: Colors.white,
                ),
                SizedBox(height: 10),
                Text(
                  'SLEEP TRACKER',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'To get you a better sleep',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
                SizedBox(height: 150),
                ElevatedButton(
                  child: const Text('Get Started'),
                  onPressed: () {
                    Navigator.pushNamed(context, '/second');
                  },
                  style: ElevatedButton.styleFrom(
                    textStyle: TextStyle(fontSize: 20),
                    minimumSize: Size(200, 50),
                    primary: buttonColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
