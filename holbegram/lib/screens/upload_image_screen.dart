import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../methods/auth_methods.dart';
import '../screens/home.dart';

class UploadImageScreen extends StatefulWidget {
  final String email;
  final String password;
  final String username;

  const UploadImageScreen({
    super.key,
    required this.email,
    required this.password,
    required this.username,
  });

  @override
  State<UploadImageScreen> createState() => _UploadImageScreenState();
}

class _UploadImageScreenState extends State<UploadImageScreen> {
  Uint8List? _image;

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

  void signUp() async {
    String res = await AuthMethode().signUpUser(
      email: widget.email,
      password: widget.password,
      username: widget.username,
      file: _image!,
    );

    if (res == "success") {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Registro exitoso")));
      Navigator.of(
        context,
      ).pushReplacement(MaterialPageRoute(builder: (_) => const Home()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Foto de perfil")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _image != null
                ? CircleAvatar(
                  backgroundImage: MemoryImage(_image!),
                  radius: 50,
                )
                : const Icon(Icons.account_circle, size: 100),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: selectImageFromGallery,
              child: const Text("Seleccionar desde galería"),
            ),
            ElevatedButton(
              onPressed: selectImageFromCamera,
              child: const Text("Tomar foto"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _image != null ? signUp : null,
              child: const Text("Continuar"),
            ),
          ],
        ),
      ),
    );
  }
}
