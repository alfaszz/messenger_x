import 'package:flutter/material.dart';
import 'package:messenger_x/services/auth/auth_service.dart';
import 'package:messenger_x/components/button.dart';
import 'package:messenger_x/components/textfield.dart';

class Login extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final void Function()? onTap;

  Login({super.key, required this.onTap});

  //login function
  login(BuildContext context) {
    final authService = AuthService();

    try {
      authService.signInWithEmailPassword(
          _usernameController.text, _passwordController.text, context);
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
              'Login to your Account',
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 20),
            TextFieldX(
              hintText: 'username',
              obscureText: false,
              controller: _usernameController,
            ),
            const SizedBox(height: 20),
            TextFieldX(
              hintText: 'password',
              obscureText: true,
              controller: _passwordController,
            ),
            const SizedBox(height: 40),
            ButtonX(name: 'Login', onTap: () => login(context)),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "No account yet? ",
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold),
                ),
                GestureDetector(
                  onTap: onTap,
                  child: const Text(
                    "Register",
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
