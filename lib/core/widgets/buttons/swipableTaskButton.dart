import 'package:flutter/material.dart';

// Assuming TaskItemData is defined in this path
import '../../model/task_item_data.dart';
import '../cards/squircle_container.dart';
// Assuming SquircleMaterialContainer is in a separate file or defined above in the same file
// For example: import 'path_to/squircle_material_container.dart';

class SwipableTaskButton extends StatelessWidget {
  final TaskItemData taskData;
  final VoidCallback onSwipeLeftToRight;
  final VoidCallback onSwipeRightToLeft;
  final double buttonHeight;
  final double cornerRadius;

  const SwipableTaskButton({
    Key? key,
    required this.taskData,
    required this.onSwipeLeftToRight,
    required this.onSwipeRightToLeft,
    this.buttonHeight = 80.0,
    this.cornerRadius = 24.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const Color leftActionColor = Color(0xFF2C2C2E);
    const Color rightActionColor = Color(0xFFE91E63);
    const Color mainContentColor = Colors.white;
    const Color iconColorOnDark = Colors.white;
    const Color iconColorOnPink = Colors.white;

    const IconData leftActionIcon = Icons.close;
    const IconData rightActionIcon = Icons.flag_outlined;

    const IconData timeIcon = Icons.schedule;
    const IconData dateIcon = Icons.calendar_today_outlined;

    return Dismissible(
      key: Key(taskData.id),
      background: _buildActionBackground(
        color: leftActionColor,
        icon: leftActionIcon,
        iconColor: iconColorOnDark,
        alignment: Alignment.centerLeft,
        cornerRadius: cornerRadius,
        isLeft: true,
      ),
      secondaryBackground: _buildActionBackground(
        color: rightActionColor,
        icon: rightActionIcon,
        iconColor: iconColorOnPink,
        alignment: Alignment.centerRight,
        cornerRadius: cornerRadius,
        isLeft: false,
      ),
      confirmDismiss: (DismissDirection direction) async {
        if (direction == DismissDirection.startToEnd) {
          onSwipeLeftToRight();
        } else if (direction == DismissDirection.endToStart) {
          onSwipeRightToLeft();
        }
        return false;
      },
      child: SquircleMaterialContainer(// Replaced Material widget here
        height: buttonHeight,
        color: mainContentColor,
        cornerRadius: cornerRadius, // The elevation you had previously
        child: GestureDetector(

          // No borderRadius needed here for InkWell, Material parent handles shape for splash
          onTap: () {
            print("Tapped on ${taskData.title}");
          },
          child: Row(
            children: [
              // Your leading icon for the task (using taskData.iconData)
              // Ensure taskData.iconData is a valid IconData
              // Icon(taskData.iconData, size: 30.0, color: Colors.black87), // Restored this line assuming taskData.iconData is present
              const SizedBox(width: 12.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center, // Vertically centers the text column
                  children: [
                    Text(
                      taskData.title,
                      style: const TextStyle(
                        fontSize: 17.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4.0),
                    Row(
                      children: [
                        Icon(timeIcon, size: 14.0, color: Colors.pinkAccent),
                        const SizedBox(width: 4.0),
                        Text(
                          taskData.time,
                          style: const TextStyle(fontSize: 13.0, color: Colors.pinkAccent),
                        ),
                        const SizedBox(width: 12.0),
                        Icon(dateIcon, size: 14.0, color: Colors.purpleAccent),
                        const SizedBox(width: 4.0),
                        Text(
                          taskData.dateText,
                          style: const TextStyle(fontSize: 13.0, color: Colors.purpleAccent),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionBackground({
    required Color color,
    required IconData icon,
    required Color iconColor,
    required Alignment alignment,
    required double cornerRadius,
    required bool isLeft, // Determines which corners are the "outer" ones
  }) {
    // This background will now use ContinuousRectangleBorder for its visible corners.
    return Container(
      // The decoration is changed from BoxDecoration to ShapeDecoration
      decoration: ShapeDecoration(
        color: color,
        shape: ContinuousRectangleBorder(
          // We use BorderRadius.only to apply the continuous radius
          // to the "outer" corners and sharp corners (Radius.zero) to the "inner" ones.
          borderRadius: isLeft
              ? BorderRadius.only(
            topLeft: Radius.circular(cornerRadius),    // Squircle corner
            bottomLeft: Radius.circular(cornerRadius), // Squircle corner
            topRight: Radius.zero,                     // Sharp corner (will be hidden)
            bottomRight: Radius.zero,                    // Sharp corner (will be hidden)
          )
              : BorderRadius.only(
            topLeft: Radius.zero,                      // Sharp corner (will be hidden)
            bottomLeft: Radius.zero,                     // Sharp corner (will be hidden)
            topRight: Radius.circular(cornerRadius),   // Squircle corner
            bottomRight: Radius.circular(cornerRadius),// Squircle corner
          ),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      alignment: alignment,
      child: Icon(icon, color: iconColor, size: 28.0),
    );
  }
}