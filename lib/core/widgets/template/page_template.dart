// lib/core/widgets/page_template.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:loop/core/theme/colors.dart';
import 'package:loop/core/theme/spacing.dart';
import 'package:loop/core/routes/index.dart';

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
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: AppColors.neutral700,
                        ),
                        textAlign: TextAlign.center,
                      )
                    : null,
                leadingWidth: 80,
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: statusBarColor,
                  statusBarIconBrightness: Brightness.dark,
                ),
                leading: AppIconContainer(icon: Icons.arrow_back_rounded, onTap: () {
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
                top: AppSpacing.spacing5,
                left: AppSpacing.spacing5,
                right: AppSpacing.spacing5,
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

class BackButtonLight extends StatelessWidget {
  final bool? isHome;
  const BackButtonLight({
    super.key,
    this.isHome = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 0.0, left: 10, bottom: 2),
      child: Align(
          alignment: Alignment.center,
          child: GestureDetector(
            onTap: () {
              if (isHome!) {
                // context.go(Index.routeName);
              } else {
                Navigator.of(context).pop();
              }
            },
            child: Container(
              width: 48,
              height: 48,
              padding: const EdgeInsets.all(AppSpacing.spacing2),
              decoration: BoxDecoration(
                  color: Colors.white, // Updated color
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: const [
                    BoxShadow(
                      color: Color.fromARGB(255, 228, 228, 228),
                      spreadRadius: 0.5,
                      blurRadius: 1,
                      offset: Offset(1, 1),
                    ),
                  ]),
              child: const Center(
                child: Icon(
                  Icons.arrow_back,
                  size: 22,
                  color: Color(0xff1F2937), // Updated color
                ),
              ),
            ),
          )),
    );
  }
}


class AppIconContainer extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const AppIconContainer({
    Key? key,
    required this.icon,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.only(top: 14, left: 24, right: 0, bottom: 0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.widgetBackground,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.widgetBorder),
          ),
          padding: const EdgeInsets.all(0),
          child: Icon(
            icon,
            size: 30,
            color: AppColors.textPrimary,
          ),
        ),
      ),
    );
  }
}

