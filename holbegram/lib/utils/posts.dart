import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';
import '../models/user.dart';
import '../screens/pages/methods/post_storage.dart';

class Posts extends StatefulWidget {
  const Posts({super.key});

  @override
  State<Posts> createState() => _PostsState();
}

class _PostsState extends State<Posts> {
  @override
  Widget build(BuildContext context) {
    final Userd user = Provider.of<UserProvider>(context).getUser;

    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('posts').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        final data = snapshot.data!.docs;

        return ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, index) {
            final post = data[index];
            return SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.all(8),
                height: 540,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 255, 255, 255),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: ClipOval(
                              child: Image.network(
                                post['profImage'],
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Text(post['username']),
                          const Spacer(),
                          if (post['uid'] == user.uid)
                            IconButton(
                              icon: const Icon(Icons.more_horiz),
                              onPressed: () async {
                                final messenger = ScaffoldMessenger.of(context);

                                await PostStorage().deletePost(
                                  post['postId'],
                                  '',
                                );

                                if (!mounted) return;

                                messenger.showSnackBar(
                                  const SnackBar(
                                    content: Text("Post eliminado"),
                                  ),
                                );
                              },
                            ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(post['caption']),
                    const SizedBox(height: 10),
                    Container(
                      width: 350,
                      height: 350,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(25),
                        child: Image.network(
                          post['postUrl'],
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: const [
                        SizedBox(width: 10),
                        Icon(Icons.favorite_border),
                        SizedBox(width: 10),
                        Icon(Icons.comment_outlined),
                        SizedBox(width: 10),
                        Icon(Icons.bookmark_border),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
