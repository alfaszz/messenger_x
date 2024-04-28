import 'package:flutter/material.dart';

class ButtonX extends StatelessWidget {
  final String name;
  final void Function()? onTap;
  const ButtonX({super.key, required this.name, required this.onTap});

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: w / 2,
        padding: const EdgeInsets.all(15),
        //margin: const EdgeInsets.symmetric(horizontal: 25),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            name,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary),
          ),
        ),
      ),
    );
  }
}
