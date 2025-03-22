import 'package:flutter/material.dart';
import '../../widgets/text_field.dart';
import 'upload_image_screen.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final emailController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordConfirmController = TextEditingController();
  bool _passwordVisible = false;

  @override
  void initState() {
    super.initState();
    _passwordVisible = false;
  }

  @override
  void dispose() {
    emailController.dispose();
    usernameController.dispose();
    passwordController.dispose();
    passwordConfirmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 28),
            const Text(
              'Holbegram',
              style: TextStyle(fontFamily: 'Billabong', fontSize: 50),
            ),
            const SizedBox(height: 12),
            Image.asset(
              'assets/images/holbegram_logo.png',
              width: 80,
              height: 60,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  const SizedBox(height: 28),
                  TextFieldInput(
                    controller: emailController,
                    isPassword: false,
                    hintText: 'Email',
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 24),
                  TextFieldInput(
                    controller: usernameController,
                    isPassword: false,
                    hintText: 'Username',
                    keyboardType: TextInputType.text,
                  ),
                  const SizedBox(height: 24),
                  TextFieldInput(
                    controller: passwordController,
                    isPassword: !_passwordVisible,
                    hintText: 'Password',
                    keyboardType: TextInputType.visiblePassword,
                    suffixIcon: IconButton(
                      icon: Icon(
                        _passwordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _passwordVisible = !_passwordVisible;
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 24),
                  TextFieldInput(
                    controller: passwordConfirmController,
                    isPassword: !_passwordVisible,
                    hintText: 'Confirm Password',
                    keyboardType: TextInputType.visiblePassword,
                    suffixIcon: IconButton(
                      icon: Icon(
                        _passwordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _passwordVisible = !_passwordVisible;
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 28),
                  SizedBox(
                    height: 48,
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          const Color.fromARGB(218, 226, 37, 24),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) => AddPicture(
                                  email: emailController.text.trim(),
                                  username: usernameController.text.trim(),
                                  password: passwordController.text.trim(),
                                ),
                          ),
                        );
                      },
                      child: const Text(
                        'Sign up',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Already have an account? "),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          'Log in',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(218, 226, 37, 24),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
