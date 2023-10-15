import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:work_management/dashboard/utils/app_button.dart';
import 'package:work_management/dashboard/utils/app_colors.dart';
import 'package:work_management/dashboard/utils/app_styles.dart';

class ErrorPageSections extends StatefulWidget {
  const ErrorPageSections({Key? key}) : super(key: key);

  @override
  State<ErrorPageSections> createState() => _ErrorPageSectionsState();
}

class _ErrorPageSectionsState extends State<ErrorPageSections> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appPrimaryColor,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset('assets/lottie/oops.json', height: 250),
              const SizedBox(height: 50),
              Text(
                  'Error 404. The page you are looking for no longer\nexists. Perhaps you can return back to Helpdesk\n homepage and see if you can find what you are looking for.',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.montserrat(
                      height: 1.5,
                      color: AppColors.appPrimaryTextColor,
                      fontWeight: FontWeight.w500,
                      fontStyle: FontStyle.normal,
                      fontSize: 16)),
              const SizedBox(height: 50),
              AppButton(
                label: Text(
                  'Go To Home',
                  style: AppStyles.instance.labelButtonName,
                ),
                onPressed: () {
                  GoRouter.of(context).go('/billing');
                },
                width: 300,
              )
            ],
          ),
        ),
      ),
    );
  }
}
