import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:loop/core/theme/colors.dart';
import 'package:loop/core/theme/text_styles.dart';
import 'package:loop/core/widgets/buttons/appbutton.dart';
import 'package:loop/core/widgets/template/page_template.dart';
import 'package:loop/feature/journey/presentation/pages/add_goal_dialog.dart';

import '../../../auth/presentation/bloc/auth_bloc.dart';

class OnboardingScreen extends StatefulWidget {
  static const routeName = "/OnboardingScreen";
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _floatController;
   CarouselSliderController _controller =CarouselSliderController();
  late final Animation<double> _floatAnimation;
  int _currentIndex = 0;

  final List<_OnboardingData> onboardingData = [
    _OnboardingData(
      title: Text.rich(
        textAlign: TextAlign.center,
        TextSpan(
          children: [
            TextSpan(
              text: 'Build any',
              style: AppTextStyles.headingH2.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w700,
              ),
            ),
            TextSpan(
              text: ' habit\n',
              style: AppTextStyles.headingH2.copyWith(
                color: AppColors.brandColor,
                fontWeight: FontWeight.w700,
              ),
            ),
            TextSpan(
              text: ' All of them.',
              style: AppTextStyles.headingH2.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
      subtitle:
          "From Spanish vocab to a bicycle kick, Loop lets you track every skill, routine and wellness goal in one place.",
      imagePath: 'assets/OB_v1.png',
    ),

    _OnboardingData(
      title: Text.rich(
        textAlign: TextAlign.center,
        TextSpan(
          children: [
            TextSpan(
              text: 'Your ',
              style: AppTextStyles.headingH2.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w700,
              ),
            ),
            TextSpan(
              text: 'Schedule\n',
              style: AppTextStyles.headingH2.copyWith(
                color: AppColors.brandColor,
                fontWeight: FontWeight.w700,
              ),
            ),
            TextSpan(
              text: ' Finally Respected',
              style: AppTextStyles.headingH2.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
      subtitle:
          "Loop scans your calendar and tucks habits into free slots- no more clashes with meetings or classes.",
      imagePath: 'assets/OB_2_v1.png',
    ),
    _OnboardingData(
      title: Text.rich(
        textAlign: TextAlign.center,
        TextSpan(
          children: [
            TextSpan(
              text: 'Smart ',
              style: AppTextStyles.headingH2.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w700,
              ),
            ),
            TextSpan(
              text: 'Nudges,\n',
              style: AppTextStyles.headingH2.copyWith(
                color: AppColors.brandColor,
                fontWeight: FontWeight.w700,
              ),
            ),
            TextSpan(
              text: ' Never Spam.',
              style: AppTextStyles.headingH2.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
      subtitle:
      "Gentle reminders appear only when they help- skip when you’re busy, cheer when you succeed.",
      imagePath: 'assets/OB_3_v1.png',
    ),
    _OnboardingData(
      title: Text.rich(
        textAlign: TextAlign.center,
        TextSpan(
          children: [
            TextSpan(
              text: 'Privacy',
              style: AppTextStyles.headingH2.copyWith(
                color: AppColors.brandColor,
                fontWeight: FontWeight.w700,
              ),
            ),
            TextSpan(
              text: ' First.\n',
              style: AppTextStyles.headingH2.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w700,
              ),
            ),
            TextSpan(
              text: 'Progress EveryWhere',
              style: AppTextStyles.headingH2.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
      subtitle:
          "Data stays on-device or encrypted in your own\ncloud; sync across Android, iOS and web\nwhenever you choose.",
      imagePath: 'assets/OB_4_v1.png',
    ),
  ];
  List<TextSpan> _buildRichSubtitle(String subtitle) {
    final List<String> importantWords = [
      "AI",
      "goals",
      "daily generate loop",
      "routine",
      "nudges",
      "guides",
      "time estimates",
      "difficulty",
      "motivating",
    ];

    final List<TextSpan> spans = [];

    subtitle.splitMapJoin(
      RegExp(importantWords.map(RegExp.escape).join('|')),
      onMatch: (match) {
        spans.add(
          TextSpan(
            text: match[0],
            style: AppTextStyles.paragraphSmall.copyWith(
              fontWeight: FontWeight.w500,
              decoration: TextDecoration.underline,
              decorationStyle: TextDecorationStyle.dotted,
              decorationThickness: 1.5,
              color: AppColors.brandColor,
              decorationColor: AppColors.brandColor,
            ),
          ),
        );
        return '';
      },
      onNonMatch: (text) {
        spans.add(TextSpan(text: text));
        return '';
      },
    );

    return spans;
  }

  @override
  void initState() {
    super.initState();

    _floatController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat(reverse: true);

    _floatAnimation = Tween<double>(begin: -5, end: 5).animate(
      CurvedAnimation(parent: _floatController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _floatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return PageTemplate(
      padding: const EdgeInsets.all(24),
      showBackArrow: false,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (_currentIndex != onboardingData.length - 1)
            AppButton(
              width: screenWidth/4,
              isGhost: true,
              withBorder: true,
              text: "Login",
              onPressed: () async {
                context.read<AuthBloc>().add(const AuthEvent.signUp());
              },
            ),
          Expanded(
            child: CarouselSlider.builder(
              carouselController: _controller,
              itemCount: onboardingData.length,
              itemBuilder: (context, index, realIndex) {
                final data = onboardingData[index];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 3,
                      child: AnimatedBuilder(
                        animation: _floatAnimation,
                        builder:
                            (context, child) => Transform.translate(
                              offset: Offset(0, _floatAnimation.value),
                              child: child,
                            ),
                        child: Center(
                          child: Image.asset(
                            data.imagePath,
                            height: screenHeight,
                            width: screenWidth,
                            fit: BoxFit.scaleDown,
                          ),
                        ),
                      ),
                    ),
                    Gap(24),
                    Expanded(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          data.title,

                          const SizedBox(height: 20),
                          Text.rich(
                            TextSpan(
                              style: AppTextStyles.paragraphSmall.copyWith(
                                height: 1.3,
                                fontWeight: FontWeight.w600,
                              ),
                              children: _buildRichSubtitle(data.subtitle),
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
              options: CarouselOptions(
                height: screenHeight * 0.7,
                viewportFraction: 1.0,
                enableInfiniteScroll: false,
                enlargeCenterPage: false,
                onPageChanged: (index, reason) {
                  setState(() => _currentIndex = index);
                },
              ),
            ),
          ),

          const SizedBox(height: 16),

         Row(
           mainAxisSize: MainAxisSize.min,
           children: [
             _currentIndex>0?
             Expanded(
               flex: 1,
               child: GestureDetector(
                 onTap: (){
                   _controller.previousPage();
                 },
                 child: Padding(
                   padding: const EdgeInsets.only(right: 8.0),
                   child: Icon(
                     weight: 200,
                       size: 30,
                       Icons.arrow_back_ios_rounded,color: AppColors.brandColor,),
                 ),
               )
                ):SizedBox.shrink(),
                    // context.push(OnboardingScreen.routeName);
                    // context.read<AuthBloc>().add(const AuthEvent.signUp())

    Expanded(
      flex: 7,
               child: AppButton(
                  text: _currentIndex==3? 'Get Started' : 'Continue',
                  onPressed: () async {
                    setState(() {
                      if(_currentIndex==3){
                         context.read<AuthBloc>().add(const AuthEvent.signUp());
                      }else{
                      _controller.nextPage();}
                    });
                    // context.push(OnboardingScreen.routeName);
                    // context.read<AuthBloc>().add(const AuthEvent.signUp());
                  },
                ),
             ),
           ],
         ),

          // AnimatedSwitcher(
          //   duration: const Duration(milliseconds: 500),
          //   switchInCurve: Curves.easeOut,
          //   switchOutCurve: Curves.easeIn,
          //   transitionBuilder: (child, animation) {
          //     return ScaleTransition(
          //       scale: animation,
          //       child: FadeTransition(opacity: animation, child: child),
          //     );
          //   },
          //   child:
          //       _currentIndex != onboardingData.length - 1
          //           ? Row(
          //             key: const ValueKey('indicator'),
          //             mainAxisAlignment: MainAxisAlignment.center,
          //             children: List.generate(
          //               onboardingData.length,
          //               (index) => AnimatedContainer(
          //                 duration: const Duration(milliseconds: 300),
          //                 margin: const EdgeInsets.symmetric(horizontal: 4),
          //                 width: _currentIndex == index ? 24 : 8,
          //                 height: 8,
          //                 decoration: BoxDecoration(
          //                   color:
          //                       _currentIndex == index
          //                           ? AppColors.brandPurple
          //                           : Colors.white.withOpacity(0.3),
          //                   borderRadius: BorderRadius.circular(12),
          //                 ),
          //               ),
          //             ),
          //           )
          //           : SizedBox(
          //             key: const ValueKey('button'),
          //             width: double.infinity,
          //             child: Hero(
          //               tag: "create_loop_btn",
          //               child: AppButton(
          //                 text: "Create My Loop",
          //                 backGroundColor: AppColors.brandPurple,
          //                 onPressed: () {
          //                   context.push(AddGoalDialog.routeName);
          //                 },
          //               ),
          //             ),
          //           ),
          // ),

          const SizedBox(height: 16),
        ],
      ),
    );
  }
}

class _OnboardingData {
  final Widget title;
  final String subtitle;
  final String imagePath;

  _OnboardingData({
    required this.title,
    required this.subtitle,
    required this.imagePath,
  });
}
