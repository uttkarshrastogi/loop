import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loop/core/theme/colors.dart';
import 'package:loop/core/theme/text_styles.dart';
import 'package:loop/core/widgets/template/page_template.dart';

import '../../../Onboarding/presentation/widgets/loop_section_header.dart';
import '../../../Onboarding/presentation/widgets/loop_tile.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';

class DashboardPage extends StatelessWidget {
  static const routeName = '/dashboard';

  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final todayLoops = [
      LoopData(title: "Read 20 mins", isCompleted: false, recurrence: "Daily"),
      LoopData(
        title: "Workout",
        isCompleted: true,
        recurrence: "Mon, Wed, Fri",
      ),
    ];

    return PageTemplate(
      showBackArrow: false,
      // footer: FloatingActionButton(
      //   onPressed: () {
      //     // navigate to add loop
      //   },
      //   child: const Icon(Icons.add),
      // ),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // const LoopSectionHeader(),
          // const SizedBox(height: 16),
          GestureDetector(
            onTap: (){
              context.read<AuthBloc>().add(
                  const AuthEvent.signOut(),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.primary,
            
                borderRadius: BorderRadius.circular(20),
              ),
              width: double.infinity,
              height: 100,
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: AppColors.surface,

              borderRadius: BorderRadius.circular(20),
            ),
            width: double.infinity,
            height: 100,
          ),
          Container(
            decoration: BoxDecoration(
              color: AppColors.textPlaceholder,

              borderRadius: BorderRadius.circular(20),
            ),
            width: double.infinity,
            height: 100,
          ), Container(
            decoration: BoxDecoration(
              color: AppColors.success,

              borderRadius: BorderRadius.circular(20),
            ),
            width: double.infinity,
            height: 100,
          ),
          Container(
            decoration: BoxDecoration(
              color: AppColors.danger,

              borderRadius: BorderRadius.circular(20),
            ),
            width: double.infinity,
            height: 100,
          ),
        ],
      ),
    );
  }
}
