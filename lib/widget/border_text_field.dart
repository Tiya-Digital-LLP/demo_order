import 'package:demoorder/utils/app_colors.dart';
import 'package:demoorder/utils/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BorderTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final bool isError;
  final bool readOnly;
  final bool byDefault;
  final List<TextInputFormatter> textInputType;
  final TextInputType keyboard;
  final ValueChanged<String>? onChanged;
  final double height;
  final int? maxLength;
  final Widget? suffixIcon;
  final bool? enableToolbar; // Added toolbar option

  const BorderTextField({
    super.key,
    required this.controller,
    required this.hint,
    this.isError = false,
    this.readOnly = false,
    required this.textInputType,
    required this.keyboard,
    required this.byDefault,
    this.onChanged,
    this.height = 65.0,
    this.maxLength,
    this.suffixIcon,
    this.enableToolbar = true, // Default value is true
  });

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: height,
      decoration: BoxDecoration(
        border: Border.all(
          color:
              byDefault
                  // ignore: deprecated_member_use
                  ? AppColors.containerBorder.withOpacity(0.4)
                  : isError
                  ? AppColors.redText
                  : AppColors.greenBorder,
        ),
        borderRadius: BorderRadius.circular(14),
        color: AppColors.white,
      ),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Center(
                child: TextField(
                  cursorHeight: 15,
                  autocorrect: false,
                  readOnly: readOnly,
                  enableInteractiveSelection:
                      enableToolbar ?? true, // Control toolbar visibility
                  keyboardType: keyboard,
                  inputFormatters: textInputType,
                  onChanged: onChanged,
                  controller: controller,
                  maxLength: maxLength,
                  style: textStyleW700(size.width * 0.038, AppColors.blackText),
                  cursorColor: AppColors.blackText,
                  decoration: InputDecoration(
                    counterText: "",
                    labelText: hint,
                    labelStyle: textStyleW400(
                      size.width * 0.038,
                      AppColors.blackText,
                    ),
                    contentPadding: const EdgeInsets.symmetric(vertical: 12),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
          ),
          if (suffixIcon != null)
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: suffixIcon,
            ),
        ],
      ),
    );
  }
}
