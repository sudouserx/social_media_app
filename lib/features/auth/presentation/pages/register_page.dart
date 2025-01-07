import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:social_media_app/features/auth/presentation/components/my_button.dart';
import 'package:social_media_app/features/auth/presentation/components/my_textfield.dart';
import 'package:social_media_app/features/auth/presentation/cubits/auth_cubit.dart';

class RegisterPage extends StatefulWidget {
  void Function()? onTap;

  RegisterPage({super.key, required this.onTap});
  // RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // text editing controllers
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  void register() async {
    final String name = nameController.text;
    final String email = emailController.text;
    final String pw = passwordController.text;
    final String cpw = confirmPasswordController.text;

    // auth cubit
    final AuthCubit authCubit = context.read<AuthCubit>();

    // check the email and password fields aren't empty
    if (email.isNotEmpty && pw.isNotEmpty & name.isNotEmpty && cpw.isNotEmpty) {
      if (pw == cpw) {
        await authCubit.register(name, email, pw);
      } else {
        // show error of field empty
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Passwords do not match!")));
      }
    } else {
      // show error of field empty
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please complete all fields!")));
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // logo
            Lottie.asset(
              'assets/loginanimation.json',
              height: 200,
              width: 200,
            ),
            const SizedBox(height: 25),
            //message , app slogan
            Text(
              "Let's Create an Account for you",
              style: TextStyle(
                fontSize: 16,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
            ),

            const SizedBox(
              height: 25,
            ),

            // name textfield
            MyTextField(
                controller: nameController,
                hintText: "Name",
                obscureText: false),
            const SizedBox(
              height: 25,
            ),

            // email textfield
            MyTextField(
                controller: emailController,
                hintText: "Email",
                obscureText: false),
            const SizedBox(
              height: 25,
            ),

            // password textfield
            MyTextField(
                controller: passwordController,
                hintText: "Password",
                obscureText: true),
            const SizedBox(
              height: 25,
            ),

            // confirm password textfield
            MyTextField(
                controller: confirmPasswordController,
                hintText: "Confirm password",
                obscureText: true),
            const SizedBox(
              height: 25,
            ),

            // register button
            MyButton(onTap: register, text: "Register"),
            const SizedBox(
              height: 25,
            ),

            // already have an account? Login here
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Already have an account?",
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.inversePrimary),
                ),
                const SizedBox(
                  width: 4,
                ),
                GestureDetector(
                  onTap: widget.onTap,
                  // onTap: () {},
                  child: Text(
                    "Login now",
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.inversePrimary,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
