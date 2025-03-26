// import 'package:flutter/material.dart';
//
// void showErrorToast(BuildContext context, String message) {
//   final overlay = Overlay.of(context);
//   final overlayEntry = OverlayEntry(
//     builder: (context) => Positioned(
//       top: MediaQuery.of(context).padding.top + 8, // Position it below the status bar
//       left: 16,
//       right: 16,
//       child: Material(
//         color: Colors.transparent,
//         child: Container(
//           padding: const EdgeInsets.all(16),
//           decoration: BoxDecoration(
//             color: Colors.red,
//             borderRadius: BorderRadius.circular(8),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black.withOpacity(0.2),
//                 blurRadius: 8,
//                 offset: Offset(0, 2),
//               ),
//             ],
//           ),
//           child: Row(
//             children: [
//               const Icon(Icons.error, color: Colors.white),
//               const SizedBox(width: 8),
//               Expanded(
//                 child: Text(
//                   message,
//                   style: Theme.of(context).textTheme.bodyMedium?.copyWith(
//                     color: Colors.white,
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     ),
//   );
//
//   overlay.insert(overlayEntry);
//
//   // Remove the toast after the duration
//   Future.delayed(const Duration(seconds: 4), () {
//     overlayEntry.remove();
//   });
// }
//
