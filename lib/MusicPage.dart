import 'package:flutter/material.dart';
import 'package:mental_health_tracker/AnalysisPage.dart';
import 'package:mental_health_tracker/ArticlePage.dart';
import 'package:mental_health_tracker/DashboardPage.dart';
import 'package:mental_health_tracker/Main_page.dart';
import 'package:video_player/video_player.dart';

class MusicPage extends StatefulWidget {
  @override
  _MusicPageState createState() => _MusicPageState();
}

class _MusicPageState extends State<MusicPage> {
  final List<BlogPost> blogPosts = [
    BlogPost(
      musicUrl:
      'https://res.cloudinary.com/ddkjyc5pn/video/upload/v1689147946/Zihaal_e_Miskin_320_PagalWorld.com.se_tw4zif.mp3',
      title: 'Music Blog Post 1',
    ),
    BlogPost(
      musicUrl:
      'https://res.cloudinary.com/ddkjyc5pn/video/upload/v1689101441/Tu_Hai_To_Mujhe_Phir_Aur_Kya_Chahiye_320_PagalWorld.com.se_1_lk25pp.mp3',
      title: 'Music Blog Post 2',
    ),
  ];

  late VideoPlayerController _videoPlayerController;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _videoPlayerController =
        VideoPlayerController.networkUrl(Uri.parse(blogPosts[0].musicUrl));
    _videoPlayerController.initialize().then((_) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  int _currentPlayingIndex = -1;

  void _playPauseMusic(int index) {
    setState(() {
      if (_currentPlayingIndex == index) {
        if (_videoPlayerController.value.isPlaying) {
          _videoPlayerController.pause();
          _isPlaying = false;
        } else {
          _videoPlayerController.play();
          _isPlaying = true;
        }
      } else {
        // Stop the currently playing song
        if (_currentPlayingIndex != -1) {
          _videoPlayerController.pause();
          _isPlaying = false;
        }

        // Start playing the new song
        _currentPlayingIndex = index;
        _videoPlayerController = VideoPlayerController.networkUrl(
            Uri.parse(blogPosts[index].musicUrl));
        _videoPlayerController.initialize().then((_) {
          _videoPlayerController.play();
          _isPlaying = true;
          setState(() {});
        });
      }
    });
  }

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff3C2177),
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
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text(
          'Musics',
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
      body: ListView.builder(
        itemCount: blogPosts.length,
        itemBuilder: (context, index) {
          final blogPost = blogPosts[index];
          return Card(
            color: Colors.white,
            child: ListTile(
              title: Text(
                blogPost.title,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              trailing: IconButton(
                icon: Icon(
                  _currentPlayingIndex == index && _isPlaying
                      ? Icons.pause
                      : Icons.play_arrow,
                  size: 32,
                ),
                onPressed: () => _playPauseMusic(index),
              ),
            ),
          );
        },
      ),
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

class BlogPost {
  final String musicUrl;
  final String title;

  BlogPost({
    required this.musicUrl,
    required this.title,
  });
}