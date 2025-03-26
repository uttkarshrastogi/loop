import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:loop/core/theme/colors.dart';
import 'package:loop/core/widgets/buttons/appbutton.dart';

import '../icons/app_icon.dart';

class AppBottomSheetInputField extends StatefulWidget {
  final List<dynamic> options;
  final Function? onTap;// List of options to display
  final String? selectedValue; // Currently selected value
  final ValueChanged<String?> onChanged; // Callback for value selection
  final String hintText; // Hint text for the field
  final String title; // Title for the bottom sheet
  final String? Function(String?)? validator;
  final bool? isAddButton;// Validation callback

  const AppBottomSheetInputField({
    super.key,
    required this.options,
    required this.selectedValue,
    required this.onChanged,
    this.hintText = "Select an option",
    this.title = "Choose an option",
    this.validator, this.onTap, this.isAddButton,
  });

  @override
  State<AppBottomSheetInputField> createState() =>
      _AppBottomSheetInputFieldState();
}

class _AppBottomSheetInputFieldState extends State<AppBottomSheetInputField> {
  String? _errorText;

  void _validate() {
    setState(() {
      _errorText = widget.validator?.call(widget.selectedValue);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            widget.onTap;
            _validate(); // Validate when tapped
            _showBottomSheet(context);
          },
          child: Container(
            padding: EdgeInsets.only(
              left: 16,
              right: 12,
              top: widget.selectedValue == null ? 16 : 7,
              bottom: 16,
            ),
            decoration: BoxDecoration(
              border: Border.all(
                  color:
                      _errorText != null ? AppColors.red500 : AppColors.border),
              color: Theme.of(context).inputDecorationTheme.fillColor,
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                widget.selectedValue != null
                    ? Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: Text(
                          widget.hintText,
                          style: const TextStyle(
                            color: AppColors.neutral400,
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      )
                    : SizedBox.shrink(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.selectedValue ?? widget.hintText,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: widget.selectedValue == null
                                ? Theme.of(context).hintColor
                                : Theme.of(context).primaryColor,
                          ),
                    ),
                    const Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: AppColors.neutral800,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        if (_errorText != null)
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              _errorText!,
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(color: AppColors.red500),
            ),
          ),
      ],
    );
  }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
      ),
      builder: (_) {
        return Padding(
          padding: const EdgeInsets.only(top: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.title,
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(color: AppColors.neutral900),
                    ),
                    AppIcon(
                      onClick: () => Navigator.pop(context),
                      icon: Icons.close_rounded,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16.0),
              Expanded(
                child: Container(
                  color: Colors.white,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: widget.options.length,
                    itemBuilder: (context, index) {
                      final option = widget.options[index];
                      return ListTile(
                        contentPadding:
                            const EdgeInsets.only(left: 24, right: 10),
                        title: Text(
                          option,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(color: Theme.of(context).primaryColor),
                        ),
                        trailing: Radio<String>(
                          value: option,
                          groupValue: widget.selectedValue,
                          onChanged: (value) {
                            widget.onChanged(value); // Call parent onChanged
                            Navigator.pop(context); // Close modal
                            _validate(); // Validate after selection
                          },
                        ),
                        onTap: () {
                          widget.onChanged(option); // Call parent onChanged
                          Navigator.pop(context); // Close modal
                          _validate(); // Validate after selection
                        },
                      );
                    },
                  ),
                ),
              ),

             widget.isAddButton!=null? SafeArea(child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: AppButton(text: "Add Member", onPressed: (){

                  // context.push(AddMembers.routeName);
                  context.pop();
                }),
              )):const SizedBox(),

            ],
          ),
        );
      },
    );
  }
}
