import 'package:flutter/material.dart';
import 'package:messenger_x/components/usertile.dart';
import 'package:messenger_x/models/user.dart';
import 'package:messenger_x/pages/chat.dart';
import 'package:messenger_x/services/auth/auth_service.dart';
import 'package:messenger_x/pages/settings.dart';
import 'package:messenger_x/services/chat/chat_service.dart';

class Home extends StatelessWidget {
  Home({super.key});

//logout
  void logout() {
    final authService = AuthService();
    authService.signOut();
  }

  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const Text(
          'home',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          PopupMenuButton<int>(
              iconColor: Colors.white,
              onSelected: (item) => onSelected(context, item),
              itemBuilder: (context) => [
                    const PopupMenuItem(value: 0, child: Text('Settings')),
                    const PopupMenuItem(value: 1, child: Text('Logout')),
                  ]),
        ],
      ),
      body: _buildUserList(),
    );
  }

//popup menu ontap function
  onSelected(BuildContext context, int item) {
    switch (item) {
      case 0:
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const Settings()));
        break;
      case 1:
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              backgroundColor: Theme.of(context).colorScheme.tertiary,
              title: const Text("Confirm Logout"),
              content: const Text("Are you sure you want to logout?"),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Cancel"),
                ),
                TextButton(
                  onPressed: () {
                    logout();
                    Navigator.pop(context); // Close the dialog
                  },
                  child: const Text("Logout"),
                ),
              ],
            );
          },
        );
        break;
    }
  }

//userlist stream
  Widget _buildUserList() {
    return StreamBuilder(
        stream: _chatService.getUserStream(),
        builder: ((context, snapshot) {
          //error
          if (snapshot.hasError) {
            return const Text('error occured');
          }

          //loading
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          //list
          final List<UserModel> users = snapshot.data ?? [];
          return ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                final UserModel user = users[index];
                if (user.email != _authService.getCurrentUser()!.email) {
                  return UserTile(
                    user: user,
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Chat(
                                    receiver: user,
                                  )));
                    },
                  );
                } else {
                  return Container();
                }
              });
        }));
  }
}
