import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:work_management/dashboard/utils/app_colors.dart';

class AppInputOutlineWidget extends StatefulWidget {
  final TextEditingController inputController;
  bool? isNumber;
  final TextInputAction? textInputAction;
  final String? hintText;
  final Color? fillColor;
  final FocusNode? focusNode;
  final ValueChanged<String>? onChanged;
  final List<TextInputFormatter>? inputFormatters;
  final bool? disabled;
  final String? Function(String?)? validator;

  AppInputOutlineWidget(
      {Key? key,
      required this.inputController,
      this.isNumber,
      this.textInputAction,
      this.hintText,
      this.fillColor,
      this.focusNode,
      this.onChanged,
      this.inputFormatters,
      this.disabled,
      this.validator})
      : super(key: key);

  @override
  State<AppInputOutlineWidget> createState() => _EditProfileOutlineButtonState(
      inputController,
      isNumber,
      textInputAction,
      hintText,
      fillColor,
      focusNode,
      onChanged,
      inputFormatters,
      disabled,
      validator);
}

class _EditProfileOutlineButtonState extends State<AppInputOutlineWidget> {
  final TextEditingController inputController;
  bool? isNumber;
  final TextInputAction? textInputAction;
  final String? hintText;
  final Color? fillColor;
  final FocusNode? focusNode;
  final ValueChanged<String>? onChanged;
  final List<TextInputFormatter>? inputFormatters;
  final bool? disabled;
  final String? Function(String?)? validator;

  _EditProfileOutlineButtonState(
      this.inputController,
      this.isNumber,
      this.textInputAction,
      this.hintText,
      this.fillColor,
      this.focusNode,
      this.onChanged,
      this.inputFormatters,
      this.disabled,
      this.validator);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      child: TextFormField(
        keyboardType: (isNumber ?? false)
            ? const TextInputType.numberWithOptions(decimal: true)
            : null,
        inputFormatters: ((isNumber ?? false) && inputFormatters == null)
            ? [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(10),
              ]
            : (inputFormatters != null)
                ? inputFormatters
                : null,
        controller: widget.inputController,
        readOnly: widget.disabled ?? false,
        validator: validator,
        style: GoogleFonts.poppins(
            color: AppColors.appPrimaryTextColor,
            fontStyle: FontStyle.normal,
            fontSize: 15,
            fontWeight: FontWeight.w400),
        textInputAction: widget.textInputAction,
        onChanged: widget.onChanged,
        focusNode: widget.focusNode,
        decoration: InputDecoration(
          hintText: widget.hintText,
          contentPadding: const EdgeInsets.all(20),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Color(0xffF15252)),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.grey, width: 1),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.grey, width: 1),
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xff26D0CE), width: 1)),
          labelStyle: GoogleFonts.montserrat(
              color: AppColors.appPrimaryTextColor,
              fontStyle: FontStyle.normal,
              fontSize: 15,
              fontWeight: FontWeight.w400),
        ),
      ),
    );
  }
}
