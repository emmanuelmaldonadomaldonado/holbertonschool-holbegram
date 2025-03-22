import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../providers/user_provider.dart';
import '../pages/methods/post_storage.dart';
import '../home.dart';

class AddImage extends StatefulWidget {
  const AddImage({super.key});

  @override
  State<AddImage> createState() => _AddImageState();
}

class _AddImageState extends State<AddImage> {
  Uint8List? _image;
  final TextEditingController _captionController = TextEditingController();

  void selectImageFromGallery() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked != null) {
      final bytes = await picked.readAsBytes();
      setState(() {
        _image = bytes;
      });
    }
  }

  void selectImageFromCamera() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.camera);
    if (picked != null) {
      final bytes = await picked.readAsBytes();
      setState(() {
        _image = bytes;
      });
    }
  }

  void postImage() async {
    final user = Provider.of<UserProvider>(context, listen: false).getUser;
    String res = await PostStorage().uploadPost(
      _captionController.text,
      user.uid,
      user.username,
      user.photoUrl,
      _image!,
    );

    if (res == "Ok") {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Post publicado")));
      Navigator.of(
        context,
      ).pushReplacement(MaterialPageRoute(builder: (_) => const Home()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Nueva publicación"),
        actions: [
          TextButton(
            onPressed: _image != null ? postImage : null,
            child: const Text("Post", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
      body:
          _image == null
              ? Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.photo_camera),
                      onPressed: selectImageFromCamera,
                      iconSize: 40,
                    ),
                    const SizedBox(width: 20),
                    IconButton(
                      icon: const Icon(Icons.photo_library),
                      onPressed: selectImageFromGallery,
                      iconSize: 40,
                    ),
                  ],
                ),
              )
              : Column(
                children: [
                  const SizedBox(height: 10),
                  CircleAvatar(
                    backgroundImage: MemoryImage(_image!),
                    radius: 50,
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: _captionController,
                      decoration: const InputDecoration(
                        hintText: "Escribe un caption...",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ],
              ),
    );
  }
}
