// blog_list_screen.dart

import 'package:blog_assignment/BlogDetailScreen.dart';
import 'package:blog_assignment/add_post_screen.dart';
import 'package:blog_assignment/firebase_service.dart';
import 'package:blog_assignment/provider.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class BlogListScreen extends StatefulWidget {
  @override
  _BlogListScreenState createState() => _BlogListScreenState();
}

class _BlogListScreenState extends State<BlogListScreen> {
  Future<void> _getPosts() async {
    final provider = Provider.of<BlogProvider>(context, listen: false);
    final posts = await FirebaseService().getPosts();
    provider.setPosts(posts);
  }

  @override
  void initState() {
    super.initState();
    _getPosts();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<BlogProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Blog List'),
      ),
      body: FutureBuilder(
          future: _getPosts(),
          initialData: const CircularProgressIndicator(),
          builder: (context, snapshot) {
            return ListView.builder(
              itemCount: provider.posts.length,
              itemBuilder: (context, index) {
                final post = provider.posts[index];
                // Build the blog post widget
                return InkWell(
                  onTap: () => Navigator.pushNamed(
                    context,
                    BlogDetailScreen.routeName,
                    arguments: post.id,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.network(
                            post.imageurl,
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: 16.0),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                post.title,
                                style: const TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4.0),
                              Text(
                                post.summary,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 8.0),
                              ElevatedButton(
                                onPressed: () {
// got to                                   BlogDetailScreen(postId: post.id),

                                  Navigator.pushNamed(
                                    context,
                                    BlogDetailScreen.routeName,
                                    arguments: post.id,
                                  );
                                },
                                child: const Text('Read More'),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, AddPostScreen.routeName),
        child: const Icon(Icons.add),
      ),
    );
  }
}
