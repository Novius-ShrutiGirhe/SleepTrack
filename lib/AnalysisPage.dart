import 'package:flutter/material.dart';
import 'package:mental_health_tracker/ArticlePage.dart';
import 'package:mental_health_tracker/DashboardPage.dart';
import 'package:mental_health_tracker/MusicPage.dart';

class AnalysisPage extends StatefulWidget {
  const AnalysisPage({super.key});

  @override
  State<AnalysisPage> createState() => _analysisState();
}

class _analysisState extends State<AnalysisPage> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text(
          'Analysis',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) =>DashboardPage()),
            );
          },
          icon: Icon(Icons.arrow_back),
          color: Colors.white,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) => _onTabTapped(context, index),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white60,
        selectedFontSize: 15,
        showUnselectedLabels: true,
        backgroundColor: Color(0xFF3C2177),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home_filled,
              color: Colors.white,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.analytics,
              color: Colors.white,
            ),
            label: 'Analaysis',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.article, color: Colors.white),
            label: 'Articles',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.music_note, color: Colors.white),
            label: 'Music',
          ),
        ],
      ),
      body: Center(child: Text('Analysis')),
    );
  }
  void _onTabTapped(BuildContext context, int index) {
    setState(() {
      currentIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.push(context, MaterialPageRoute(builder: (context) =>DashboardPage()));
        break;
      case 1:
        Navigator.push(context, MaterialPageRoute(builder: (context) =>AnalysisPage()));
        break;
      case 2:
        Navigator.push(context, MaterialPageRoute(builder: (context) =>ArticlePage()));
        break;
      case 3:
        Navigator.push(context, MaterialPageRoute(builder: (context) =>MusicPage()));
        break;
      default:
        break;
    }
  }
}