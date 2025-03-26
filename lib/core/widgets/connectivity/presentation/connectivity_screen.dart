import 'package:flutter/material.dart';

class Connectivity extends StatelessWidget {
  const Connectivity({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      top: 0,
      child: Container(
        color: Colors.white,
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.perm_scan_wifi,
              color: Colors.grey,
              size: 55,
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              'No internet available!',
              style: TextStyle(
                fontSize: 15,
                color: Colors.grey,
                decoration: TextDecoration.none,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
