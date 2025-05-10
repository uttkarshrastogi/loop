import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:loop/core/theme/text_styles.dart';
import 'package:loop/core/widgets/buttons/appbutton.dart';
import 'package:loop/core/widgets/template/page_template.dart';
import 'package:loop/feature/auth/presentation/bloc/auth_bloc.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/widgets/globalLoader/bloc/bloc/loader_bloc.dart';
import '../../../../core/widgets/icons/titlt_parallax_effect.dart';
import '../../../journey/presentation/pages/add_goal_dialog.dart';

class GetStartedPage extends StatelessWidget {
  static const routeName = '/GetStartedPage';
  const GetStartedPage({super.key});

  @override
  Widget build(BuildContext context) {
    final LoaderBloc lBloc = GetIt.instance<LoaderBloc>();
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        state.maybeWhen(
          loading: () {
            lBloc.add(const LoaderEvent.loadingON());
          },
          success: (user) {
            lBloc.add(const LoaderEvent.loadingOFF());
          },
          error: (e){
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text('Error: $e')));
          },
          orElse: () {
            print("errorrrr");
          },
        );
      },
      child: PageTemplate(
        padding: EdgeInsets.fromLTRB(24,0,24,0),
        content: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              flex: 4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TiltParallaxImage(),
                  Text(
                    "Welcome to",
                    style: AppTextStyles.headingH4.copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  Gap(8),
                  Image.asset("assets/Loop Name Logo.png",width: 80,),
                  // AppLoader(),
                ],
              ),
            ),
            // Spacer(),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  AppButton(
                    text: "Get Started",
                    onPressed: () async {
                      context.read<AuthBloc>().add(const AuthEvent.signUp());
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
