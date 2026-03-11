import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';

class StackDetailAvatar extends StatelessWidget {
  final String amountMax;
  final String amountCurrent;

  const StackDetailAvatar({
    super.key,
    required this.amountMax,
    required this.amountCurrent,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Stack(
          children: [
            CoreAvatar.network(
              size: const Size(30, 30),
              placeholder: Text('J'),
              'https://app.requestly.io/delay/2000/avatars.githubusercontent.com/u/124598?v=3',
            ),

            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: CoreAvatar.network(
                size: const Size(30, 30),
                placeholder: Text('J'),
                'https://app.requestly.io/delay/2000/avatars.githubusercontent.com/u/124597?v=3',
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(left: 30),
              child: CoreAvatar.network(
                size: const Size(30, 30),
                placeholder: Text('J'),
                'https://app.requestly.io/delay/2000/avatars.githubusercontent.com/u/124599?v=3',
              ),
            ),
          ],
        ),
        const SizedBox(width: 12),
        Text(
          "$amountCurrent / $amountMax",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}


class StackAvatar extends StatelessWidget {
  const StackAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Stack(
          children: [
            CoreAvatar.network(
              size: const Size(30, 30),
              placeholder: Text('J'),
              'https://app.requestly.io/delay/2000/avatars.githubusercontent.com/u/124598?v=3',
            ),

            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: CoreAvatar.network(
                size: const Size(30, 30),
                placeholder: Text('J'),
                'https://app.requestly.io/delay/2000/avatars.githubusercontent.com/u/124597?v=3',
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(left: 30),
              child: CoreAvatar.network(
                size: const Size(30, 30),
                placeholder: Text('J'),
                'https://app.requestly.io/delay/2000/avatars.githubusercontent.com/u/124599?v=3',
              ),
            ),
          ],
        ),
      ],
    );
  }
}