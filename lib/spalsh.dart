import 'package:flutter/material.dart';
import 'package:mental_health_tracker/register.dart';

class firstPage extends StatefulWidget {
  const firstPage({Key? key}) : super(key: key);

  @override
  State<firstPage> createState() => _firstPageState();
}

class _firstPageState extends State<firstPage> {
  late Size mq;

  @override
  Widget build(BuildContext context) {
    Size mq = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xff3C2177),
      body: Center(
          child: Padding(
        padding:
            EdgeInsets.only(bottom: mq.height * .015, top: mq.height * .095),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.alarm,
              size: 250,
              color: Colors.white,
            ),
            const SizedBox(height: 50),
            const Text(
              'SLEEP TRACKER',
              style: TextStyle(
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                  fontSize: 35),
            ),
            const SizedBox(height: 5),
            const Text(
              'To get you a better sleep',
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                  fontSize: 15),
            ),
            const SizedBox(height: 30),
            const Padding(
              padding: EdgeInsets.all(24.0),
              child: Text(
                'This app is used to track your sleeping routines and based on that it give you a score',
                style: TextStyle(
                    fontWeight: FontWeight.w300,
                    color: Colors.white,
                    fontSize: 13),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const registerPage()));
              },
              label: const Text(
                'Get Started',
                style: TextStyle(fontSize: 18),
              ),
              style: ElevatedButton.styleFrom(
                  shape: const StadiumBorder(),
                  backgroundColor: const Color(0xff0E4393),
                  minimumSize: Size(mq.width * .6, mq.height * .075)),
              icon: const Icon(
                Icons.east_outlined,
                size: 25,
              ),
            ),
            SizedBox(height: 100),
          ],
        ),
      )),
    );
  }
}
