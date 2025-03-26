import 'dart:io';

import 'package:flutter/material.dart';

class AvatarPicker extends StatelessWidget {
  Function onAvatarSelect;
  AvatarPicker({super.key, required this.onAvatarSelect});

  final List<String> avatars = [
    'assets/images/avatars/avatar1.png',
    'assets/images/avatars/avatar2.png',
    'assets/images/avatars/avatar3.png',
    'assets/images/avatars/avatar4.png',
    'assets/images/avatars/avatar5.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4, // Number of columns
          crossAxisSpacing: 10, // Spacing between columns
          mainAxisSpacing: 10, // Spacing between rows
          childAspectRatio: 1, // Aspect ratio of each grid item
        ),
        itemCount: avatars.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: (){
              onAvatarSelect(avatars[index]);
            },
            child: ClipOval(
              child: Image.asset(
                avatars[index],
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      ),
    );
  }
}
