import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:loop/core/theme/colors.dart';
import 'package:loop/core/theme/text_styles.dart';
import 'package:loop/core/widgets/cards/squircle_container.dart';
import '../../model/loop_card_model.dart';
import '../loaders/circular_percentage_indicator.dart';
import 'loop_tag_widget.dart';
// Assuming InfoCardData, SquircleMaterialContainer, InfoTagWidget,
// and CircularPercentageIndicator are defined as above or imported.

  class LoopHabitInfoCard extends StatelessWidget {
  final LoopCardData cardData;

  const LoopHabitInfoCard({Key? key, required this.cardData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {// For default text styles if needed

    return SquircleMaterialContainer(
      // width: double.infinity, // Takes full width available to it
      color: Colors.white, // Card background color
      cornerRadius: 28.0,  // Adjust as per your squircle preference
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min, // So card takes minimum vertical space needed
          children: [
            // Top Section: Icon, Title, Progress
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  cardData.titleIcon,
                  size: 20, // Adjust size// Or a specific color
                ),
                const SizedBox(width: 12.0),
                Expanded(
                  child: Text(
                    cardData.title,
                    style:AppTextStyles.headingH5
                  ),
                ),
                CircularPercentageIndicator(
                  percentage: cardData.progressPercent,
                  label: cardData.progressLabel,
                  radius: 22.0, // Adjust for size in screenshot
                  strokeWidth: 5.0,
                  progressColor: Colors.black87,
                  backgroundColor: Colors.grey.shade300,
                ),
              ],
            ),
            // Gap(16),

            // Tags Section
            Wrap(
              spacing: 8.0, // Horizontal space between tags
              runSpacing: 8.0, // Vertical space between lines of tags
              children: cardData.tags
                  .map((tagData) => LoopTagWidget(tag: tagData))
                  .toList(),
            ),
            const SizedBox(height: 16.0),

            // Description Section
            Text(
              cardData.description,
              style: AppTextStyles.paragraphXSmall.copyWith(color: AppColors.textSecondary)
            ),
            Gap(10),
            // const SizedBox(height: 20.0),
            Divider(
              height: 0,
              color: AppColors.textSecondary.withOpacity(0.1),
            ),
            Gap(12),
            // Bottom Icons Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: cardData.bottomIconsLeft
                      .map((icon) => Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: Icon(
                      icon,
                      size: 24.0,

                    ),
                  ))
                      .toList(),
                ),
                if (cardData.bottomIconRight != null)
                  Icon(
                    cardData.bottomIconRight,
                    size: 28.0,

                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}