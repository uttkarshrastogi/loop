import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:loop/core/theme/colors.dart';

class OTPInputField extends StatelessWidget {
  final Function(String) onCompleted;
  final TextEditingController textEditingController;

  const OTPInputField(
      {Key? key,
      required this.onCompleted,
      required this.textEditingController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Pinput(
      controller: textEditingController,
      length: 6,
      defaultPinTheme: PinTheme(
        width: 56,
        height: 56,
        textStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
              fontSize: 14,
              height: 20 / 14,
              color: AppColors.neutral900,
            ),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.border, width: 1),
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      focusedPinTheme: PinTheme(
        width: 56,
        height: 56,
        textStyle: Theme.of(context).textTheme.bodySmall,
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.blue500, width: 1),
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      submittedPinTheme: PinTheme(
        width: 56,
        height: 56,
        textStyle: Theme.of(context).textTheme.bodySmall,
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.border),
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      onCompleted: onCompleted,
    );
  }
}
