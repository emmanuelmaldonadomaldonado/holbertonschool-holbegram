import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class Search extends StatelessWidget {
  const Search({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Buscar")),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("posts").snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final docs = snapshot.data!.docs;

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: MasonryGridView.count(
              crossAxisCount: 2,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              itemCount: docs.length,
              itemBuilder: (context, index) {
                final post = docs[index];
                return ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(post['postUrl'], fit: BoxFit.cover),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
