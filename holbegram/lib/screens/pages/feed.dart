import 'package:flutter/material.dart';
import '../../utils/posts.dart';

class Feed extends StatelessWidget {
  const Feed({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Holbegram',
          style: TextStyle(fontFamily: 'Lobster', fontSize: 32),
        ),
        actions: const [
          Icon(Icons.notifications),
          SizedBox(width: 10),
          Icon(Icons.send),
          SizedBox(width: 10),
        ],
      ),
      body: const Posts(),
    );
  }
}
