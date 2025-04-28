import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:loop/core/theme/colors.dart';
import 'package:loop/core/theme/text_styles.dart';

class AppCalendarField extends StatefulWidget {
  final String labelText;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final FocusNode? focusNode;
  final Icon? suffixIcon;
  final VoidCallback onTap;
  final bool isDisabled;
  final Color? backgroundColor;
  final bool isRequired;

  const AppCalendarField({
    super.key,
    required this.labelText,
    required this.controller,
    this.validator,
    this.focusNode,
    this.suffixIcon,
    required this.onTap,
    this.isDisabled = false,
    this.isRequired = false,
    this.backgroundColor = Colors.white,
  });

  @override
  State<AppCalendarField> createState() => _AppCalendarFieldState();
}

class _AppCalendarFieldState extends State<AppCalendarField> {
  late FocusNode _focusNode;
  bool _isFocused = false;
  String? _errorText;

  @override
  void initState() {
    super.initState();
    _focusNode = widget.focusNode ?? FocusNode();
    _focusNode.addListener(_handleFocusChange);
  }

  @override
  void dispose() {
    if (widget.focusNode == null) {
      _focusNode.dispose();
    }
    super.dispose();
  }

  void _handleFocusChange() {
    setState(() {
      _isFocused = _focusNode.hasFocus;
    });
  }

  void _updateError(String? error) {
    setState(() {
      _errorText = error;
    });
  }

  @override
  Widget build(BuildContext context) {
    Color borderColor = _errorText != null
        ? Colors.red
        : widget.isDisabled
        ? AppColors.neutral300
        : _isFocused
        ? AppColors.blue500
        : AppColors.border;

    Color labelColor =
    widget.isDisabled ? AppColors.neutral300 : AppColors.neutral400;
    Color inputTextColor =
    widget.isDisabled ? AppColors.neutral300 : AppColors.neutral800;

    Color bgColor = widget.backgroundColor ?? Colors.white;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.only(
            left: 0,
            right: 0,
            top: (_isFocused || widget.controller.text.isNotEmpty) ? 14 : 0,
            bottom: 0,
          ),
          decoration: BoxDecoration(
            color: bgColor,
            border: Border.all(
              color: borderColor,
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          child: TextFormField(
            readOnly: true,
            controller: widget.controller,
            validator: (value) {
              final error = widget.validator?.call(value);
              _updateError(error);
              return error;
            },
            focusNode: _focusNode,
            onTap: widget.isDisabled ? () {} : widget.onTap,
            decoration: InputDecoration(
              alignLabelWithHint: true,
              // labelText: widget.labelText,
              label: RichText(
                text: TextSpan(
                  text: widget.labelText,
                  style: const TextStyle(
                      color: AppColors.neutral400,
                      fontSize: 16), // Normal label style
                  children: [
                    if (widget.isRequired)
                      const TextSpan(
                        text: "*",
                        style: TextStyle(
                          color:
                          Color(0xFFB22D2D), // Red color for the asterisk
                          fontSize: 16,
                        ),
                      ),
                  ],
                ),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide.none,
              ),
              floatingLabelBehavior: FloatingLabelBehavior.auto,
              floatingLabelAlignment: FloatingLabelAlignment.start,
              labelStyle: AppTextStyles.paragraphMedium.copyWith(
                letterSpacing: 1,
                color: labelColor,
              ),
              contentPadding: const EdgeInsets.all(16),
              suffixIcon: Padding(
                padding: const EdgeInsets.only(right: 24),
                child: widget.suffixIcon ??
                    SvgPicture.asset(
                      "assets/images/calendar_icon.svg",
                    ),
              ),
              fillColor: bgColor,
            ),
            style: AppTextStyles.paragraphMedium.copyWith(
              fontWeight: FontWeight.w400,
              letterSpacing: 1,
              color: inputTextColor,
            ),
          ),
        ),
        if (_errorText != null)
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              _errorText!,
              style: AppTextStyles.error.copyWith(fontSize: 12),
            ),
          ),
      ],
    );
  }
}
