import 'package:flutter/material.dart';

class Favorite extends StatelessWidget {
  const Favorite({super.key});

  @override
  Widget build(BuildContext context) {
    // Aquí puedes conectar con Firestore para mostrar solo posts guardados
    return const Scaffold(
      body: Center(
        child: Text(
          'No tienes publicaciones guardadas todavía.',
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
