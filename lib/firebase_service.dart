// firebase_service.dart

import 'package:blog_assignment/blog_post.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  final CollectionReference _postsCollection =
      FirebaseFirestore.instance.collection('blog');

  Future<List<BlogPost>> getPosts() async {
    final snapshot = await _postsCollection.get();
    return snapshot.docs
        .map((doc) =>
            BlogPost.fromFirestore(doc.data()! as Map<String, dynamic>))
        .toList();
  }

  Future<void> addPost(BlogPost post) async {
    //current date time in milliseconds as a string

    await _postsCollection.add(post.toMap());
  }
}
