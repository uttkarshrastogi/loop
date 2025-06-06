// lib/core/widgets/page_template.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:heroicons/heroicons.dart';
import 'package:loop/core/theme/colors.dart'; // Assuming these exist
import 'package:loop/core/theme/spacing.dart'; // Assuming these exist
import 'package:loop/core/routes/index.dart';   // Assuming these exist
import 'package:loop/core/theme/text_styles.dart'; // Assuming these exist

class PageTemplate extends StatelessWidget {
  final Widget content;
  final Widget? floatingActionButton;
  final Widget? footer;
  final Widget? drawer;
  final Widget? mascot;
  final bool showBottomGradient;
  final void Function(bool)? onDrawerChanged;
  final Color? drawerScrimColor;
  final Gradient? linearGradient;
  final PreferredSizeWidget? bottomWidget; // For the default AppBar
  final EdgeInsetsGeometry? padding;
  final List<Widget>? actions; // For the default AppBar
  final String? title; // For the default AppBar
  final bool showBackArrow;
  final Color? backgroundColor;
  final Color? appBarBackgroundColor; // For the default AppBar
  final bool? resizeToAvoidBottomInset;
  final Color? statusBarColor; // For the default AppBar's SystemUiOverlayStyle
  final bool? isHome;
  final PreferredSizeWidget? replacementAppBar; // <<< NEW: For custom AppBar

  const PageTemplate({
    super.key,
    required this.content,
    this.showBottomGradient = false,
    this.footer,
    this.showBackArrow = true,
    this.backgroundColor = AppColors.background,
    this.title,
    this.actions,
    this.padding,
    this.appBarBackgroundColor = AppColors.background,
    this.bottomWidget,
    this.resizeToAvoidBottomInset = true,
    this.statusBarColor = Colors.transparent,
    this.isHome = false,
    this.linearGradient,
    this.drawerScrimColor,
    this.drawer,
    this.onDrawerChanged,
    this.mascot,
    this.replacementAppBar, this.floatingActionButton, // <<< NEW
  });

  bool isKeyboardVisible(BuildContext context) {
    return MediaQuery.of(context).viewInsets.bottom > 0;
  }

  @override
  Widget build(BuildContext context) {
    bool keyboardVisible = isKeyboardVisible(context);
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        floatingActionButton:floatingActionButton ,
        floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
        drawerScrimColor: drawerScrimColor,
        drawer: drawer,
        onDrawerChanged: onDrawerChanged,
        resizeToAvoidBottomInset: resizeToAvoidBottomInset,
        bottomNavigationBar: footer != null && !keyboardVisible ? footer : null,
        // Use replacementAppBar if provided, otherwise use original logic
        appBar: replacementAppBar ??
            (showBackArrow // Original AppBar logic
                ? AppBar(
              toolbarHeight: 66,
              surfaceTintColor: Colors.transparent,
              bottom: bottomWidget,
              shadowColor: Colors.transparent,
              backgroundColor: appBarBackgroundColor,
              actions: actions,
              centerTitle: true,
              title: title != null
                  ? Text(
                title!,
                style: AppTextStyles.paragraphMedium,
                textAlign: TextAlign.center,
              )
                  : null,
              leadingWidth: 56,
              bottomOpacity: 0.3,
              systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: statusBarColor, // Uses PageTemplate's statusBarColor
                statusBarIconBrightness: Brightness.dark, // Default, may need to change based on appBarBackgroundColor
              ),
              leading: AppIconContainer( // Using your existing AppIconContainer
                icon: HeroIcons.arrowLeft,
                onTap: () {
                  if (context.canPop()) {
                    context.pop();
                  }
                },
              ),
            )
                : null),
        backgroundColor: backgroundColor,
        body: SafeArea( // SafeArea for the body content
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(gradient: linearGradient),
                padding: padding ??
                    const EdgeInsets.only(
                      top: AppSpacing.spacing4,
                      left: AppSpacing.spacing4,
                      right: AppSpacing.spacing4,
                    ),
                margin: EdgeInsets.only(bottom: keyboardVisible ? 20 : 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () => FocusScope.of(context).unfocus(),
                        child: content,
                      ),
                    ),
                    if (mascot != null)
                      Image.asset(
                        "assets/loop_mascot_hi.png", // Make sure this path is correct
                        height: MediaQuery.of(context).size.height / 11,
                      ),
                  ],
                ),
              ),
              // ... your gradient overlay code ...
            ],
          ),
        ),
      ),
    );
  }
}

// Your AppIconContainer class (assuming it's defined in the same file or imported)
// ... (ensure AppIconContainer and other dependencies like AppColors, AppTextStyles are available) ...
class AppIconContainer extends StatelessWidget {
  final HeroIcons icon;
  final VoidCallback onTap;

  const AppIconContainer({
    Key? key,
    required this.icon,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12.0,top: 12,bottom: 12),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: AppColors.border,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 4,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Center(
            child: HeroIcon(
              icon,
              size: 18,
              color: AppColors.primary,
            ),
          ),
        ),
      ),
    );
  }
}