import 'package:flutter/material.dart';
import '../widgets/text_field.dart';
import 'upload_image_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  bool _passwordVisible = true;

  @override
  void dispose() {
    emailController.dispose();
    usernameController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _passwordVisible = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFieldInput(
              controller: emailController,
              hintText: 'Email',
              isPassword: false,
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16),
            TextFieldInput(
              controller: usernameController,
              hintText: 'Username',
              isPassword: false,
              keyboardType: TextInputType.name,
            ),
            const SizedBox(height: 16),
            TextFieldInput(
              controller: passwordController,
              hintText: 'Password',
              isPassword: !_passwordVisible,
              keyboardType: TextInputType.visiblePassword,
              suffixIcon: IconButton(
                icon: Icon(
                  _passwordVisible ? Icons.visibility : Icons.visibility_off,
                ),
                onPressed: () {
                  setState(() {
                    _passwordVisible = !_passwordVisible;
                  });
                },
              ),
            ),
            const SizedBox(height: 16),
            TextFieldInput(
              controller: confirmPasswordController,
              hintText: 'Confirm Password',
              isPassword: true,
              keyboardType: TextInputType.visiblePassword,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder:
                        (_) => UploadImageScreen(
                          email: emailController.text,
                          password: passwordController.text,
                          username: usernameController.text,
                        ),
                  ),
                );
              },
              child: const Text("Sign Up"),
            ),
          ],
        ),
      ),
    );
  }
}
