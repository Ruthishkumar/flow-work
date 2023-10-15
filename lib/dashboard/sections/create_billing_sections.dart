import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:work_management/dashboard/utils/app_button.dart';
import 'package:work_management/dashboard/utils/app_colors.dart';
import 'package:work_management/dashboard/utils/app_input_outline_widget.dart';
import 'package:work_management/dashboard/utils/app_styles.dart';

import '../model/create_billing_model.dart';

class CreateBillingSections extends StatefulWidget {
  const CreateBillingSections({Key? key}) : super(key: key);

  @override
  State<CreateBillingSections> createState() => _CreateBillingSectionsState();
}

class _CreateBillingSectionsState extends State<CreateBillingSections> {
  TextEditingController nameController = TextEditingController();
  TextEditingController lineNameController = TextEditingController();
  TextEditingController billNumberController = TextEditingController();
  TextEditingController siController = TextEditingController();

  FirebaseFirestore fireStore = FirebaseFirestore.instance;

  bool buttonLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appPrimaryColor,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(30),
                width: 500,
                child: Column(
                  children: [
                    Text(
                      'Create New'.toUpperCase(),
                      style: GoogleFonts.montserrat(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.w500,
                          fontStyle: FontStyle.normal),
                    ),
                    const SizedBox(height: 50),
                    appOutlineHeader(labelName: 'Submitter Name'),
                    const SizedBox(height: 6),
                    AppInputOutlineWidget(
                        inputController: nameController,
                        textInputAction: TextInputAction.next),
                    const SizedBox(height: 30),
                    appOutlineHeader(labelName: 'Line Name'),
                    const SizedBox(height: 6),
                    AppInputOutlineWidget(
                        inputController: lineNameController,
                        textInputAction: TextInputAction.next),
                    const SizedBox(height: 30),
                    appOutlineHeader(labelName: 'Bill Number'),
                    const SizedBox(height: 6),
                    AppInputOutlineWidget(
                        inputController: billNumberController,
                        textInputAction: TextInputAction.next),
                    const SizedBox(height: 30),
                    appOutlineHeader(labelName: 'Shipping Instructions'),
                    const SizedBox(height: 6),
                    AppInputOutlineWidget(
                        inputController: siController,
                        textInputAction: TextInputAction.done),
                    const SizedBox(height: 50),
                    AppButton(
                        label: buttonLoading
                            ? Center(
                                child: Container(
                                  width: 24,
                                  height: 24,
                                  padding: const EdgeInsets.all(2.0),
                                  child: const CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 3,
                                  ),
                                ),
                              )
                            : Text(
                                'Submit',
                                style: AppStyles.instance.labelButtonName,
                              ),
                        onPressed: () {
                          buttonLoading ? null : submitForm();
                        },
                        width: 300)
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  /// outline header widget
  appOutlineHeader({required String labelName}) {
    return Row(
      children: [
        Text(
          labelName,
          style: AppStyles.instance.formLabelName,
        ),
        const SizedBox(width: 3),
        Text(
          '*',
          style: GoogleFonts.montserrat(
              color: Colors.redAccent,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w500,
              fontSize: 14),
        )
      ],
    );
  }

  /// submit form
  submitForm() {
    Timestamp stamp = Timestamp.now();
    DateTime date = stamp.toDate();
    if (validate()) {
      setState(() => buttonLoading = true);
      fireStore
          .collection('billing')
          .add((CreateBillingModel(
                  submitterName: nameController.text,
                  lineName: lineNameController.text,
                  billNumber: billNumberController.text,
                  shippingInstructions: siController.text,
                  createAt: DateTime.now())
              .toJson()))
          .whenComplete(() {
        setState(() => buttonLoading = false);
        context.push('/view');
      }).catchError((error) {
        print(error.toString());
      });
    }
  }

  /// validate form
  bool validate() {
    if (nameController.text == '') {
      // showToast("Show Center Toast", gravity: Toast.center);
      return false;
    } else if (lineNameController.text == '') {
      return false;
    } else if (billNumberController.text == '') {
      return false;
    } else if (siController.text == '') {
      return false;
    }
    return true;
  }
}
