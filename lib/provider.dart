// provider.dart

import 'package:blog_assignment/blog_post.dart';
import 'package:flutter/foundation.dart';

class BlogProvider extends ChangeNotifier {
  List<BlogPost> _posts = [];

  List<BlogPost> get posts => _posts;

  void setPosts(List<BlogPost> posts) {
    _posts = posts;
    // ConnectionState

    notifyListeners();
  }

  void addPost(BlogPost post) {
    _posts.add(post);
    notifyListeners();
  }
}
