import 'package:flutter/material.dart';
import 'package:messenger_x/services/auth/auth_service.dart';
import 'package:messenger_x/components/button.dart';
import 'package:messenger_x/components/textfield.dart';

class Register extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  final void Function()? onTap;

  Register({super.key, this.onTap});

  register(BuildContext context) {
    final authService = AuthService();

    try {
      authService.signUpWithEmailPassword(
          _emailController.text, _passwordController.text, context, _nameController.text);
    } catch (e) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text(e.toString()),
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.messenger_sharp,
                size: 60, color: Theme.of(context).colorScheme.primary),
            const SizedBox(height: 20),
            Text(
              "Let's create an account",
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 20),
            TextFieldX(
              hintText: 'name',
              obscureText: false,
              controller: _nameController,
            ),
            const SizedBox(height: 20),
            TextFieldX(
              hintText: 'email',
              obscureText: false,
              controller: _emailController,
            ),
            const SizedBox(height: 20),
            TextFieldX(
              hintText: 'password',
              obscureText: true,
              controller: _passwordController,
            ),
            const SizedBox(height: 40),
            ButtonX(
              name: 'Register',
              onTap: () => register(context),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Already have an account? ",
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold),
                ),
                GestureDetector(
                  onTap: onTap,
                  child: const Text(
                    "Login",
                    style: TextStyle(
                        color: Colors.blue, fontWeight: FontWeight.bold),
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
