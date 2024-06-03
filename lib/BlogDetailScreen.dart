// blog_detail_screen.dart

import 'package:blog_assignment/blog_post.dart';
import 'package:blog_assignment/firebase_service.dart';
import 'package:flutter/material.dart';

class BlogDetailScreen extends StatefulWidget {
  static const String routeName = '/blog-detail';

  final String postId;

  BlogDetailScreen({required this.postId});

  @override
  _BlogDetailScreenState createState() => _BlogDetailScreenState();
}

class _BlogDetailScreenState extends State<BlogDetailScreen> {
  late Future<BlogPost?> _post;

  @override
  void initState() {
    super.initState();

    _post = FirebaseService()
        .getPosts()
        .then((posts) => posts.firstWhere((post) => post.id == widget.postId,
            orElse: () => BlogPost(
                  id: '',
                  title: '',
                  summary: '',
                  imageurl: '',
                )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Blog Detail'),
      ),
      body: FutureBuilder<BlogPost?>(
        future: _post,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final post = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.network(
                      post.imageurl,
                      width: double.infinity,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    post.title,
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(post.summary),
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
