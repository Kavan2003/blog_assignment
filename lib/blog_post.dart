// blog_post.dart

class BlogPost {
  final String id;
  final String title;
  final String summary;
  final String imageurl;

  BlogPost({
    required this.id,
    required this.title,
    required this.summary,
    required this.imageurl,
  });

  // Add a static factory constructor to create a BlogPost from Firestore data
  factory BlogPost.fromFirestore(Map<String, dynamic> data) => BlogPost(
        id: data['id'] ?? '',
        title: data['title'] ?? '',
        summary: data['summary'] ?? '',
        imageurl: data['imageurl'] ?? '',
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'title': title,
        'summary': summary,
        'imageurl': imageurl,
      };
}
