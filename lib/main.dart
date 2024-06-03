// main.dart

import 'package:blog_assignment/BlogDetailScreen.dart';
import 'package:blog_assignment/add_post_screen.dart';
import 'package:blog_assignment/blog_list_screen.dart';
import 'package:blog_assignment/firebase_options.dart';
import 'package:blog_assignment/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  //initialize firebase with current platform
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => BlogProvider(),
      child: MaterialApp(
        title: 'Blog App',
        onGenerateRoute: (settings) {
          if (settings.name == BlogDetailScreen.routeName) {
            final String postId = settings.arguments as String;

            // You can then pass the `postId` to `BlogDetailScreen`
            return MaterialPageRoute(
              builder: (ctx) => BlogDetailScreen(postId: postId),
            );
          }
          // Handle other routes...
        },
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: BlogListScreen(),
        routes: {
          AddPostScreen.routeName: (context) => AddPostScreen(),
        },
      ),
    );
  }
}
