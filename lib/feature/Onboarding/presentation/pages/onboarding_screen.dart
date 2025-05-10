import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:go_router/go_router.dart';
import 'package:loop/core/theme/colors.dart';
import 'package:loop/core/theme/text_styles.dart';
import 'package:loop/core/widgets/buttons/appbutton.dart';
import 'package:loop/core/widgets/template/page_template.dart';
import 'package:loop/feature/journey/presentation/pages/add_goal_dialog.dart';

class OnboardingScreen extends StatefulWidget {
  static const routeName = "/OnboardingScreen";
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _floatController;
  late final Animation<double> _floatAnimation;
  int _currentIndex = 0;

  final List<_OnboardingData> onboardingData = [
    _OnboardingData(
      title: "Let AI Guide Your Journey",
      subtitle:
          "Loop works like a smart compass — turning your goals into daily tasks with step-by-step instructions.",
      imagePath: 'assets/OB_v1.png',
    ),
    _OnboardingData(
      title: "Stay Focused, Even in the Fog",
      subtitle:
          "Loop adapts your plan to your routine and keeps you anchored with timely nudges.",
      imagePath: 'assets/OB_2_v1.png',
    ),
    _OnboardingData(
      title: "Everything You Need, One Tap Away",
      subtitle:
          "Each task comes with how-to guides, time estimates, difficulty, and motivating reasons.",
      imagePath: 'assets/OB_3_v1.png',
    ),
  ];
  List<TextSpan> _buildRichSubtitle(String subtitle) {
    final List<String> importantWords = [
      "AI",
      "goals",
      "daily tasks",
      "routine",
      "nudges",
      "guides",
      "time estimates",
      "difficulty",
      "motivating"
    ];

    final List<TextSpan> spans = [];

    subtitle.splitMapJoin(
      RegExp(importantWords.map(RegExp.escape).join('|')),
      onMatch: (match) {
        spans.add(TextSpan(
          text: match[0],
          style: AppTextStyles.paragraphSmall.copyWith(
            fontWeight: FontWeight.w500,
            decoration: TextDecoration.underline,
            decorationStyle:  TextDecorationStyle.dotted,
            decorationThickness: 1.5,
            color: AppColors.brandPurple,
            decorationColor: AppColors.brandPurple,
          )
        ));
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
        children: [
          if (_currentIndex != onboardingData.length - 1)
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap:  () {
                  context.push(AddGoalDialog.routeName);
                },
                child: Text(
                  "skip",
                  style: AppTextStyles.paragraphSmall.copyWith(
                    decoration: TextDecoration.underline,
                    decorationColor: AppColors.brandPurple
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: CarouselSlider.builder(
              itemCount: onboardingData.length,
              itemBuilder: (context, index, realIndex) {
                final data = onboardingData[index];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                            width: screenWidth * 0.7,
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            data.title,
                            style: AppTextStyles.headingH6,
                            textAlign: TextAlign.left,
                          ),
                          const SizedBox(height: 20),
                          Text.rich(
                            TextSpan(
                              style: AppTextStyles.paragraphSmall.copyWith(height: 1.3),
                              children: _buildRichSubtitle(data.subtitle),
                            ),
                            textAlign: TextAlign.left,
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

          AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            switchInCurve: Curves.easeOut,
            switchOutCurve: Curves.easeIn,
            transitionBuilder: (child, animation) {
              return ScaleTransition(
                scale: animation,
                child: FadeTransition(opacity: animation, child: child),
              );
            },
            child:
                _currentIndex != onboardingData.length - 1
                    ? Row(
                      key: const ValueKey('indicator'),
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        onboardingData.length,
                        (index) => AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          width: _currentIndex == index ? 24 : 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color:
                                _currentIndex == index
                                    ? AppColors.brandPurple
                                    : Colors.white.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    )
                    : SizedBox(
                      key: const ValueKey('button'),
                      width: double.infinity,
                      child: Hero(
                        tag: "create_loop_btn",
                        child: AppButton(
                          text: "Create My Loop",
                          backGroundColor: AppColors.brandPurple,
                          onPressed: () {
                            context.push(AddGoalDialog.routeName);
                          },
                        ),
                      ),
                    ),
          ),

          const SizedBox(height: 16),
        ],
      ),
    );
  }
}

class _OnboardingData {
  final String title;
  final String subtitle;
  final String imagePath;

  _OnboardingData({
    required this.title,
    required this.subtitle,
    required this.imagePath,
  });
}
