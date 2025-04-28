import 'package:flutter/material.dart';
import 'package:loop/core/theme/colors.dart';
import 'package:loop/core/theme/text_styles.dart';

class AppTabSwitcher extends StatelessWidget {
  final TabController controller;

  const AppTabSwitcher({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColors.surfaceVariant, // light background for pill container
        borderRadius: BorderRadius.circular(32),
      ),
      child: TabBar(
        controller: controller,
        splashFactory: NoSplash.splashFactory,
        overlayColor: MaterialStateProperty.all(Colors.transparent),
        indicator: BoxDecoration(
          color: AppColors.brandPurple.withOpacity(0.1),
          borderRadius: BorderRadius.circular(30),
        ),
        labelColor: AppColors.brandPurple,
        unselectedLabelColor: AppColors.textSecondary,
        labelStyle: AppTextStyles.paragraphMedium,
        tabs: const [
          Tab(child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Center(child: Text("Goal")),
          )),
          Tab(child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Center(child: Text("LOOP")),
          )),
        ],
      ),
    );
  }
}
