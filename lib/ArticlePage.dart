import 'package:flutter/material.dart';
import 'package:mental_health_tracker/DashboardPage.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

class ArticlePage extends StatelessWidget {
  final List<BlogPost> blogPosts = [
    BlogPost(
      imageUrl:
      'https://res.cloudinary.com/ddkjyc5pn/image/upload/v1688995679/two-ladies_lek1j6.jpg',
      title: 'Image Blog Post',
      description:
      'This is an image blog post. Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
    ),
    BlogPost(
      imageUrl:
      'https://res.cloudinary.com/ddkjyc5pn/image/upload/v1688991008/cld-sample-5_lt9o4s.jpg',
      title: 'Image Blog Post',
      description:
      'This is an image blog post. Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
    ),
    BlogPost(
      imageUrl:
      'https://res.cloudinary.com/ddkjyc5pn/image/upload/v1688996165/cld-sample-3_im25a4.jpg',
      title: 'Image Blog Post',
      description:
      'This is an image blog post. Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
    ),
    BlogPost(
      videoUrl:
      'https://res.cloudinary.com/ddkjyc5pn/video/upload/v1688981677/samples/sea-turtle.mp4',
      title: 'Video Blog Post',
      description:
      'This is a video blog post. Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
    ),
    BlogPost(
      imageUrl:
      'https://res.cloudinary.com/ddkjyc5pn/image/upload/v1688981687/cld-sample.jpg',
      title: 'Image Blog Post',
      description:
      'This is an image blog post. Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
    ),
    BlogPost(
      imageUrl:
      'https://res.cloudinary.com/ddkjyc5pn/image/upload/v1688981685/samples/balloons.jpg',
      title: 'Image Blog Post',
      description:
      'This is an image blog post. Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Blog Page',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurple,
          title: Text(
            'Blog Post',
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
            return Container(
              width: double.infinity,
              height: 300,
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (blogPost.imageUrl != null)
                    Expanded(
                      child: Image.network(
                        blogPost.imageUrl!,
                        fit: BoxFit.cover,
                      ),
                    ),
                  if (blogPost.videoUrl != null)
                    Expanded(
                      child: Chewie(
                        controller: ChewieController(
                          videoPlayerController:
                          VideoPlayerController.networkUrl(
                              Uri.parse(blogPost.videoUrl!)),
                          autoPlay: false,
                          looping: false,
                        ),
                      ),
                    ),
                  SizedBox(height: 8),
                  Text(
                    blogPost.title,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  Text(
                    blogPost.description,
                    style: TextStyle(fontSize: 16),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class BlogPost {
  final String? imageUrl;
  final String? videoUrl;
  final String title;
  final String description;

  BlogPost({
    this.imageUrl,
    this.videoUrl,
    required this.title,
    required this.description,
  });
}
