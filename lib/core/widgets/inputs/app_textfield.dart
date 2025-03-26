import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loop/core/theme/colors.dart';

enum FieldTheme { light, dark }

class AppTextField extends StatefulWidget {
  final String labelText;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final TextCapitalization? textCapitalization;
  final bool isPrefix;
  final int? minLines;
  final bool isDisabled;
  final Icon? suffixIcon;
  final ValueChanged<String>? onChanged;
  final List<TextInputFormatter>? inputFormatters;
  final FocusNode? focusNode;
  final String? Function(String?)? validator;
  final String? error;
  final FieldTheme? fieldTheme;

  const AppTextField(
      {super.key,
      required this.labelText,
      this.minLines = 1,
      required this.controller,
      this.keyboardType = TextInputType.text,
      this.validator,
      this.focusNode,
      this.isPrefix = false,
      this.isDisabled = false,
      this.inputFormatters,
      this.onChanged,
      this.suffixIcon,
      this.error,
      this.fieldTheme = FieldTheme.light,
      this.textCapitalization});

  // Expose validate() method to parent widgets
  String? validate() {
    if (validator != null) {
      return validator!(controller.text);
    }
    return null;
  }

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
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
  void didUpdateWidget(covariant AppTextField oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Only update _errorText if the error from the parent has changed
    if (widget.error != oldWidget.error) {
      setState(() {
        _errorText = widget
            .error; // Update _errorText with the new error from the parent
      });
    }
  }

  @override
  void dispose() {
    // Dispose of the FocusNode only if it was created internally
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

    if (widget.fieldTheme == FieldTheme.dark) {
      borderColor = _errorText != null
          ? Colors.red
          : widget.isDisabled
              ? Color(0xff525359)
              : _isFocused
                  ? AppColors.blue500
                  : Color(0xff525359);
      inputTextColor = widget.isDisabled ? AppColors.neutral300 : Colors.white;
    }

    Color bgColor = widget.fieldTheme == FieldTheme.light
        ? Colors.white
        : Color(0xff292D33);

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
              color: borderColor, // Highlight on focus
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          child: TextFormField(
            readOnly: widget.isDisabled,
            controller: widget.controller,
            keyboardType: widget.keyboardType,
            onChanged: (value) {
              widget.onChanged?.call(value);
              // Validate on each change (optional)
              _updateError(widget.validator?.call(value));
            },
            minLines: widget.minLines,
            maxLines: 20,
            inputFormatters: widget.inputFormatters,
            focusNode: _focusNode,
            textCapitalization:
                widget.textCapitalization ?? TextCapitalization.none,
            decoration: InputDecoration(
                alignLabelWithHint: true,
                labelText: widget.labelText,

//  label: Text.rich(
//                   TextSpan(
//                     children: <InlineSpan>[
//                       WidgetSpan(
//                         child: Text(
//                           'Username',
//                         ),
//                       ),
//                       WidgetSpan(
//                         child: Text(
//                           '*',
//                           style: TextStyle(color: Colors.red),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),

                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
                floatingLabelBehavior: FloatingLabelBehavior.auto,
                prefixText:
                    widget.isPrefix ? '+91 ' : null, // Add the +91 prefix
                prefixStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w400,
                      letterSpacing: 1,
                      color: AppColors.neutral800,
                    ),
                floatingLabelAlignment: FloatingLabelAlignment.start,
                labelStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      letterSpacing: 1,
                      color: widget.isDisabled
                          ? AppColors.neutral300
                          : AppColors.neutral400,
                    ),
                contentPadding: const EdgeInsets.all(16),
                suffixIcon: widget.suffixIcon,
                errorText: null, // Disables default error message
                fillColor: bgColor),
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
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
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.red,
                    fontSize: 12,
                  ),
            ),
          ),
      ],
    );
  }
}
