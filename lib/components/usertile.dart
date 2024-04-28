import 'package:flutter/material.dart';
import 'package:messenger_x/models/user.dart';

class UserTile extends StatelessWidget {
  final void Function()? onTap;
  final UserModel user;
  const UserTile({super.key, required this.user, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(12),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            const Icon(Icons.person),
            const SizedBox(
              width: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.name,
                ),
                const SizedBox(
                  height: 1,
                ),
                Text(
                  user.email,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
