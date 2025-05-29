import 'package:flutter/material.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        Icon(Icons.note),
        SizedBox(width: 8),
        Icon(Icons.image),
        SizedBox(width: 8),
        Icon(Icons.attach_file),
        SizedBox(width: 8),
        Icon(Icons.alternate_email),
        SizedBox(width: 8),
        Icon(Icons.list),
        SizedBox(width: 8),
        Icon(Icons.code),
        SizedBox(width: 8),
        Icon(Icons.format_quote),
      ],
    );
  }
}
