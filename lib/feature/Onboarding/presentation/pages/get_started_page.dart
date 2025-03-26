import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:loop/core/theme/text_styles.dart';
import 'package:loop/core/widgets/buttons/appbutton.dart';
import 'package:loop/core/widgets/template/page_template.dart';
import 'package:loop/feature/auth/presentation/bloc/auth_bloc.dart';
import 'package:loop/feature/dashboard/presentation/pages/dashboard_page.dart';

import '../../../../core/theme/colors.dart';
import '../../../../core/widgets/globalLoader/bloc/bloc/loader_bloc.dart';
import '../../../../core/widgets/icons/parallax_image.dart';
import '../../../../core/widgets/icons/titlt_parallax_effect.dart';
import '../../../../core/widgets/loaders/app_loader.dart';
import '../../../auth/data/datasources/auth_service.dart';

class GetStartedPage extends StatelessWidget {
  static const routeName = '/GetStartedPage';

  const GetStartedPage({super.key});

  @override
  Widget build(BuildContext context) {
    final LoaderBloc lBloc = GetIt.instance<LoaderBloc>();
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        state.maybeWhen(
          loading: (){
            lBloc.add(const LoaderEvent.loadingON());
          },
          success: (user) {
            lBloc.add(const LoaderEvent.loadingOFF());
            context.push(
              DashboardPage.routeName,
            );
          },
            orElse: (){});
      },
      child: PageTemplate(
        content: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              flex: 4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TiltParallaxImage(),
                  // ParallaxImage(),
                  // Container(
                  //   decoration: BoxDecoration(
                  //     boxShadow: [
                  //       BoxShadow(
                  //         color: AppColors.neutral1100.withOpacity(0.5),
                  //         blurRadius: 60,
                  //         spreadRadius: 0,
                  //         offset: const Offset(0, 20),
                  //       ),
                  //     ],
                  //   ),
                  //   child: Image.asset(
                  //     "assets/LiconBG.png",
                  //     width: MediaQuery.of(context).size.width / 1.4,
                  //   ),
                  // ),
                  Text(
                    "Welcome to",
                    style: AppTextStyles.paragraphLarge.copyWith(
                      color: AppColors.textSecondary,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  Text(
                    "Loop",
                    style: AppTextStyles.headingH3.copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  // AppLoader(),
                ],
              ),
            ),
            // Spacer(),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  AppButton(text: "Get Started", onPressed: () async {
                    context.read<AuthBloc>().add(
                        const AuthEvent.signUp()
                    );
                  },
                  ),
                  Gap(24),
                ],
              ),
            ),
          ],
        ),
        showBackArrow: false,
      ),
    );
  }
}
