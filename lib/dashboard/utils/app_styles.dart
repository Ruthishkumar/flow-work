import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:work_management/dashboard/utils/app_colors.dart';

class AppStyles {
  static final AppStyles _singleton = AppStyles._internal();
  AppStyles._internal();
  static AppStyles get instance => _singleton;

  final TextStyle? formLabelName = GoogleFonts.montserrat(
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w500,
      fontSize: 14,
      color: AppColors.appPrimaryTextColor);

  final TextStyle? labelButtonName = GoogleFonts.poppins(
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w500,
      fontSize: 14,
      color: AppColors.appPrimaryTextColor);

  final TextStyle? viewHeaderName = GoogleFonts.montserrat(
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w700,
      fontSize: 14,
      color: Color(0xff24C6DC));

  final TextStyle? showAmend = GoogleFonts.montserrat(
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w400,
      fontSize: 12,
      color: AppColors.appPrimaryTextColor);

  final TextStyle? viewBodyName = GoogleFonts.montserrat(
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w400,
      fontSize: 14,
      color: AppColors.appPrimaryTextColor);
}
