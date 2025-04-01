import 'package:flutter/material.dart';
import 'package:loop/core/theme/colors.dart';
import 'package:loop/core/widgets/template/page_template.dart';
import 'package:lottie/lottie.dart';

class AppLoader extends StatefulWidget {
  const AppLoader({super.key, this.size = 100});
  final double size;

  @override
  State<AppLoader> createState() => _AppLoaderState();
}

class _AppLoaderState extends State<AppLoader> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    )..repeat(); // infinite loop
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      showBackArrow: false,
      appBarBackgroundColor: AppColors.background,
      backgroundColor: AppColors.background,
      content: Center(
          child:Lottie.asset(
            decoder:customDecoder,
            'assets/text_loader_lottie.lottie', // Place your rotating icon image here
            width: widget.size,
            height: widget.size,
          )
    ));
  }
}
Future<LottieComposition?> customDecoder(List<int> bytes) {
  return LottieComposition.decodeZip(
    bytes,
    filePicker: (files) {
      return files.firstWhere(
            (f) => f.name.startsWith('animations/') && f.name.endsWith('.json'),
      );
    },
  );
}

