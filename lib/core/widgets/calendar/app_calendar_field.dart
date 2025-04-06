import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:loop/core/theme/colors.dart';
import 'package:loop/core/theme/text_styles.dart';

class AppCalendarField extends StatefulWidget {
  final String labelText;
  final DateTime? initialDate;
  final DateTime firstDate;
  final DateTime lastDate;
  final void Function(DateTime) onDateSelected;
  final String? Function(String?)? validator;
  final bool isDisabled;
  final Color? backgroundColor;
  final Icon? suffixIcon;

  const AppCalendarField({
    super.key,
    required this.labelText,
    required this.initialDate,
    required this.firstDate,
    required this.lastDate,
    required this.onDateSelected,
    this.validator,
    this.isDisabled = false,
    this.backgroundColor = Colors.white,
    this.suffixIcon,
  });

  @override
  State<AppCalendarField> createState() => _AppCalendarFieldState();
}

class _AppCalendarFieldState extends State<AppCalendarField> {
  late TextEditingController _controller;
  late FocusNode _focusNode;
  bool _isFocused = false;
  String? _errorText;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(
      text: widget.initialDate != null
          ? _formatDate(widget.initialDate!)
          : '',
    );

    _focusNode = FocusNode();
    _focusNode.addListener(_handleFocusChange);
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _controller.dispose();
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

  String _formatDate(DateTime date) {
    return "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: widget.initialDate ?? DateTime.now(),
      firstDate: widget.firstDate,
      lastDate: widget.lastDate,
    );

    if (picked != null) {
      _controller.text = _formatDate(picked);
      widget.onDateSelected(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    Color borderColor = _errorText != null
        ? AppColors.error
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
            top: (_isFocused || _controller.text.isNotEmpty) ? 14 : 0,
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
            controller: _controller,
            validator: (value) {
              final error = widget.validator?.call(value);
              _updateError(error);
              return error;
            },
            focusNode: _focusNode,
            onTap: widget.isDisabled ? () {} : _pickDate,
            decoration: InputDecoration(
              alignLabelWithHint: true,
              labelText: widget.labelText,
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
                // child: widget.suffixIcon ??
                //     SvgPicture.asset("assets/images/calendar_icon.svg"),
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
