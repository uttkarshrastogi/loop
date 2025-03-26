import 'package:flutter/material.dart';
import 'package:loop/core/theme/colors.dart';
import 'package:loop/core/theme/text_styles.dart';
import 'package:loop/core/widgets/buttons/appbutton.dart';

void showSuccessDialog(
    BuildContext context, String serviceRequestId,void Function() onPressed) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset("assets/images/check.png",height:52,),
              const SizedBox(height: 20),
                const Text(
                'Ticket Raised Successfully',
                style: AppTextStyles.headingH5,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Text(
                'Service Request ID: $serviceRequestId',
                style: AppTextStyles.paragraphXSmall.copyWith(color: AppColors.neutral500),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              AppButton(text: "ok", onPressed:onPressed)
            ],
          ),
        ),
      );
    },
  );
}
void showUpdateSuccessDialog(
    BuildContext context, String serviceRequestId,void Function() onPressed) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset("assets/images/check.png",height:52,),
              const SizedBox(height: 20),
                const Text(
                'Ticket Updated Successfully',
                style: AppTextStyles.headingH5,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Text(
                'Service Request ID: $serviceRequestId',
                style: AppTextStyles.paragraphXSmall.copyWith(color: AppColors.neutral500),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              AppButton(text: "ok", onPressed:onPressed)
            ],
          ),
        ),
      );
    },
  );
}
