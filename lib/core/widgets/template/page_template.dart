// lib/core/widgets/page_template.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:heroicons/heroicons.dart';
import 'package:loop/core/theme/colors.dart';
import 'package:loop/core/theme/spacing.dart';
import 'package:loop/core/routes/index.dart';
import 'package:loop/core/theme/text_styles.dart';

class PageTemplate extends StatelessWidget {
  final Widget content; // Main content widget
  final Widget? footer;
  final Widget? drawer;
  final Widget? mascot;
  final bool showBottomGradient;
  final void Function(bool)? onDrawerChanged;
  final Color? drawerScrimColor;
  final Gradient? linearGradient;
  final PreferredSizeWidget? bottomWidget;
  final EdgeInsetsGeometry? padding;
  final List<Widget>? actions;
  final String? title; // Optional footer widget
  final bool
      showBackArrow; // Controls the visibility of the back arrow// Custom back action
  final Color? backgroundColor;
  final Color? appBarBackgroundColor; // Background color
  final bool? resizeToAvoidBottomInset;
  final Color? statusBarColor;
  final bool? isHome;

  const PageTemplate(
      {super.key,
      required this.content,
        this.showBottomGradient = false,
        this.footer,
      this.showBackArrow = true, // Default value set to true
      this.backgroundColor = AppColors.background,
      this.title,
      this.actions,
      this.padding,
      this.appBarBackgroundColor = AppColors.background,
      this.bottomWidget,
      this.resizeToAvoidBottomInset = true, // Default background color
      this.statusBarColor = Colors.transparent,
      this.isHome = false,
      this.linearGradient, this.drawerScrimColor, this.drawer, this.onDrawerChanged, this.mascot});

  bool isKeyboardVisible(BuildContext context) {
    return MediaQuery.of(context).viewInsets.bottom > 0;
  }

  @override
  Widget build(BuildContext context) {
    bool keyboardVisible = isKeyboardVisible(context);
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus(); // Dismiss keyboard
      },
      child: Scaffold(
        drawerScrimColor: drawerScrimColor,
        drawer: drawer,
        onDrawerChanged: onDrawerChanged,
        resizeToAvoidBottomInset: resizeToAvoidBottomInset,
        bottomNavigationBar: footer != null && !keyboardVisible ? footer : null,
        appBar: showBackArrow
            ? AppBar(
                toolbarHeight: 66,
                surfaceTintColor: Colors.transparent,
                bottom: bottomWidget,
                shadowColor: Colors.transparent,
                // elevation: 0,
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
                  statusBarColor: statusBarColor,
                  statusBarIconBrightness: Brightness.dark,
                ),
                leading: AppIconContainer(icon: HeroIcons.arrowLeft, onTap: () {
                  context.pop();
                },),
              )
            : null,
        backgroundColor: backgroundColor,
        body: SafeArea(
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
            if(mascot != null)
            Image.asset(
              "assets/loop_mascot_hi.png",
              height: MediaQuery.of(context).size.height / 11, // small mascot
            ),
          ],
        ),
      ),

          // if (showBottomGradient)
          //   Positioned(
          //     bottom: 0,
          //     left: 0,
          //     right: 0,
          //     child: IgnorePointer(
          //       child: Container(
          //         height: 500, // You can tweak this
          //         decoration: BoxDecoration(
          //           gradient: LinearGradient(
          //             begin: Alignment.bottomCenter,
          //             end: Alignment.topCenter,
          //             colors: [
          //               AppColors.brandPurple.withOpacity(0.2),
          //               AppColors.brandPurple.withOpacity(0.0),
          //               Colors.transparent,
          //             ],
          //             stops: [0.0, 0.4, 1.0],
          //           ),
          //         ),
          //       ),
          //     ),
          //   ),
      ],
    ),

    ),
      ),
    );
  }
}



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
      padding: const EdgeInsets.only(left: 12.0,top: 12,bottom: 12), // Enough margin from screen edge
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(
            color: Colors.transparent, // Visible but subtle
            borderRadius: BorderRadius.circular(8), // Clean curve
            border: Border.all(
              color: AppColors.border, // Soft but visible
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



