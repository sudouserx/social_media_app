import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:social_media_app/features/auth/presentation/components/my_button.dart';
import 'package:social_media_app/features/auth/presentation/components/my_textfield.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Text editing controllers
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Variables for typing speed calculation
  late DateTime _lastChangeTime = DateTime.now();
  double _typingSpeed = 0.0;

  @override
  void initState() {
    super.initState();
    emailController.addListener(() {
      final currentTime = DateTime.now();
      final timeDiff = currentTime.difference(_lastChangeTime).inMilliseconds;

      // Calculate typing speed, with a floor value of 0 and a cap of 100.
      if (timeDiff > 0) {
        _typingSpeed = (1000 / timeDiff) * emailController.text.characters.length;
        _typingSpeed = _typingSpeed.clamp(0, 100);
      }

      _lastChangeTime = currentTime;

      setState(() {});
    });
  }

  @override
  void dispose() {
    // Dispose of controllers to prevent memory leaks
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  // Login method
  void login() async {
    // Future implementation for login logic
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Lottie animation with dynamic frame rate adjustment
            Lottie.asset(
              'assets/3d.json',
              // height: 120,
              // width: 120,
              // frameRate: FrameRate(30.0 + (_typingSpeed / 2)), // Adjust frame rate dynamically
              // frameRate: FrameRate(600.0), // Adjust frame rate dynamically

            ),
            const SizedBox(height: 25),

            // App slogan
            Text(
              "ከፍታውን ይዞ ከጨረቃ ጋር ይገናኙ! 🚀🌙",
              style: TextStyle(
                fontSize: 16,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
            ),
            const SizedBox(height: 25),

            // Email text field
            MyTextField(
              controller: emailController,
              hintText: "Email",
              obscureText: false,
            ),
            const SizedBox(height: 25),

            // Password text field
            MyTextField(
              controller: passwordController,
              hintText: "Password",
              obscureText: true,
            ),
            const SizedBox(height: 25),

            // Sign in button
            MyButton(onTap: login, text: "Sign In"),
            const SizedBox(height: 25),

            // "Not a member?" text with Register link
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Not a member?",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
                ),
                const SizedBox(width: 4),
                GestureDetector(
                  onTap: () {
                    // Navigation logic to register page
                  },
                  child: Text(
                    "Register now?",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.inversePrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
