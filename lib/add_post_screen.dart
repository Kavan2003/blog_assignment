// add_post_screen.dart

import 'package:blog_assignment/blog_post.dart';
import 'package:blog_assignment/firebase_service.dart';
import 'package:flutter/material.dart';

class AddPostScreen extends StatefulWidget {
  static const String routeName = '/add-post';

  @override
  _AddPostScreenState createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _summaryController = TextEditingController();
  final _imageurlController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _summaryController.dispose();
    _imageurlController.dispose();
    super.dispose();
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      final post = BlogPost(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: _titleController.text,
        summary: _summaryController.text,
        imageurl: _imageurlController.text,
      );
      await FirebaseService().addPost(post);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Post'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(labelText: 'Title'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _summaryController,
                decoration: InputDecoration(labelText: 'Summary'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a summary';
                  }
                  return null;
                },
                maxLines: 5,
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _imageurlController,
                decoration: InputDecoration(labelText: 'Image URL'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter an image URL';
                  }
                  return null;
                },
                keyboardType: TextInputType.url,
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text('Add Post'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
