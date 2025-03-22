import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../methods/auth_methods.dart';
import 'methods/user_storage.dart';

class AddPicture extends StatefulWidget {
  final String email;
  final String password;
  final String username;

  const AddPicture({
    super.key,
    required this.email,
    required this.password,
    required this.username,
  });

  @override
  State<AddPicture> createState() => _AddPictureState();
}

class _AddPictureState extends State<AddPicture> {
  Uint8List? _image;

  void selectImageFromGallery() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      final bytes = await pickedFile.readAsBytes();
      setState(() {
        _image = bytes;
      });
    }
  }

  void selectImageFromCamera() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
    );
    if (pickedFile != null) {
      final bytes = await pickedFile.readAsBytes();
      setState(() {
        _image = bytes;
      });
    }
  }

  void handleSignUp() async {
    String result = await AuthMethods().signUpUser(
      email: widget.email,
      username: widget.username,
      password: widget.password,
      file: _image,
    );

    if (result == "success") {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Success")));
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(result)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Upload Profile Picture")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _image != null
              ? CircleAvatar(radius: 80, backgroundImage: MemoryImage(_image!))
              : const CircleAvatar(
                radius: 80,
                backgroundImage: AssetImage("assets/images/holbegram_logo.png"),
              ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: selectImageFromGallery,
                icon: const Icon(Icons.photo_library),
              ),
              IconButton(
                onPressed: selectImageFromCamera,
                icon: const Icon(Icons.camera_alt),
              ),
            ],
          ),
          const SizedBox(height: 20),
          ElevatedButton(onPressed: handleSignUp, child: const Text("Next")),
        ],
      ),
    );
  }
}
