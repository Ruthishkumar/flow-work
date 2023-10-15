import 'dart:html' as html;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:work_management/dashboard/model/create_billing_model.dart';
import 'package:work_management/dashboard/provider/provider.dart';
import 'package:work_management/dashboard/utils/app_button.dart';
import 'package:work_management/dashboard/utils/app_colors.dart';
import 'package:work_management/dashboard/utils/app_input_outline_widget.dart';
import 'package:work_management/dashboard/utils/app_styles.dart';

class UpdateBillingSections extends StatefulWidget {
  const UpdateBillingSections({Key? key}) : super(key: key);

  @override
  State<UpdateBillingSections> createState() => _UpdateBillingSectionsState();
}

class _UpdateBillingSectionsState extends State<UpdateBillingSections> {
  TextEditingController nameController = TextEditingController();
  TextEditingController updateNameController = TextEditingController();
  TextEditingController lineNameController = TextEditingController();
  TextEditingController billNumberController = TextEditingController();
  TextEditingController siController = TextEditingController();
  TextEditingController commentController = TextEditingController();
  TextEditingController amendController = TextEditingController();
  TextEditingController revisedController = TextEditingController();
  TextEditingController statusController = TextEditingController();

  @override
  void initState() {
    getData();
    super.initState();
  }

  String createdAtTime = "";
  final df = DateFormat('dd MMM yyyy, HH:mm:ss');

  getData() async {
    String myDocumentId =
        Provider.of<BillingProvider>(context, listen: false).documentId;
    DocumentSnapshot documentSnapshot;
    await FirebaseFirestore.instance
        .collection('billing')
        .doc(myDocumentId)
        .get()
        .then((value) {
      documentSnapshot = value;
      print(documentSnapshot['updaterName']);
      print('UPdspdsds');
      nameController.text = documentSnapshot['submitterName'];
      lineNameController.text = documentSnapshot['lineName'];
      billNumberController.text = documentSnapshot['billNumber'];
      siController.text = documentSnapshot['shippingInstructions'];
      statusController.text = documentSnapshot['status'] ?? '';
      updateNameController.text = documentSnapshot['updaterName'] ?? '';
      print(updateNameController.text);
      print('dsds');
      createdAtTime = documentSnapshot['createAt'];
      commentController.text = documentSnapshot['comment'] ?? '';
      print(createdAtTime);
      print('CREATE TIME');
      if (documentSnapshot['amend'] != '' ||
          documentSnapshot['amend'] != null) {
        amendController.text = documentSnapshot['amend'] ?? '';
        setState(() {
          showAmend = true;
        });
      }
      if (documentSnapshot['revised'] != '' ||
          documentSnapshot['revised'] != null) {
        revisedController.text = documentSnapshot['revised'] ?? '';
        setState(() {
          showRevised = true;
        });
      }
    });
  }

  getSameNumberData() {
    if (sameName == true) {
      updateNameController.text = nameController.text;
      print(updateNameController.text);
      print('FALSE');
      setState(() {});
    } else if (sameName == false) {
      updateNameController.text = '';
      setState(() {});
    }
  }

  bool showAmend = false;
  bool showRevised = false;

  bool sameName = false;

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
                        'Update'.toUpperCase(),
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
                      appOutlineHeader(labelName: 'Updater Name'),
                      const SizedBox(height: 6),
                      AppInputOutlineWidget(
                          inputController: updateNameController,
                          textInputAction: TextInputAction.next),
                      const SizedBox(height: 10),
                      sameAsSubmitterWidget(),
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
                          textInputAction: TextInputAction.next),
                      const SizedBox(height: 30),
                      appOutlineHeader(labelName: 'Comments'),
                      const SizedBox(height: 6),
                      AppInputOutlineWidget(
                          inputController: commentController,
                          textInputAction: TextInputAction.done),
                      const SizedBox(height: 30),
                      amendWidget(),
                      revisedWidget(),
                      appOutlineHeader(labelName: 'Bill Release'),
                      const SizedBox(height: 6),
                      AppInputOutlineWidget(
                          inputController: statusController,
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
        ));
  }

  /// outline header widget
  appOutlineHeader({required String labelName}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
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

  /// amend widget
  amendWidget() {
    return Column(
      children: [
        MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: () {
              setState(() {
                showAmend = !showAmend;
              });
            },
            child: showAmend == true
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text('Hidden Amend', style: AppStyles.instance.showAmend),
                      const SizedBox(width: 10),
                      const Icon(
                        Icons.visibility_off,
                        color: Colors.white,
                        size: 12,
                      )
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text('Show Amend', style: AppStyles.instance.showAmend),
                      const SizedBox(width: 10),
                      const Icon(
                        Icons.visibility,
                        color: Colors.white,
                        size: 12,
                      )
                    ],
                  ),
          ),
        ),
        const SizedBox(height: 20),
        Visibility(
          visible: showAmend,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Amend',
                style: AppStyles.instance.formLabelName,
              ),
              const SizedBox(height: 6),
              AppInputOutlineWidget(
                  inputController: amendController,
                  textInputAction: TextInputAction.next),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ],
    );
  }

  revisedWidget() {
    return Column(
      children: [
        MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: () {
              setState(() {
                showRevised = !showRevised;
              });
            },
            child: showRevised == true
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text('Hidden Revised',
                          style: AppStyles.instance.showAmend),
                      const SizedBox(width: 10),
                      const Icon(
                        Icons.visibility_off,
                        color: Colors.white,
                        size: 12,
                      )
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text('Show Revised', style: AppStyles.instance.showAmend),
                      const SizedBox(width: 10),
                      const Icon(
                        Icons.visibility,
                        color: Colors.white,
                        size: 12,
                      )
                    ],
                  ),
          ),
        ),
        const SizedBox(height: 20),
        Visibility(
          visible: showRevised,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Revised',
                style: AppStyles.instance.formLabelName,
              ),
              const SizedBox(height: 6),
              AppInputOutlineWidget(
                  inputController: revisedController,
                  textInputAction: TextInputAction.done),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ],
    );
  }

  submitForm() {
    FirebaseFirestore fireStore = FirebaseFirestore.instance;
    if (validate()) {
      setState(() => buttonLoading = true);
      fireStore
          .collection('billing')
          .doc(Provider.of<BillingProvider>(context, listen: false).documentId)
          .update((CreateBillingModel(
                  submitterName: nameController.text,
                  lineName: lineNameController.text,
                  billNumber: billNumberController.text,
                  shippingInstructions: siController.text,
                  comment: commentController.text,
                  updatedAt: df.format(DateTime.now()),
                  amend: amendController.text,
                  revised: revisedController.text,
                  createAt: createdAtTime,
                  status: statusController.text,
                  updaterName: updateNameController.text)
              .toJson()))
          .whenComplete(() {
        context.pop();
        html.window.location.reload();

        setState(() {});
        setState(() => buttonLoading = false);
      }).catchError((error) {
        print(error.toString());
      });
    }
  }

  /// same as submitter name widget
  sameAsSubmitterWidget() {
    return Row(
      children: [
        SizedBox(
          width: 20,
          height: 16,
          child: Checkbox(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
            side: const BorderSide(color: Colors.white),
            checkColor: Colors.white,
            activeColor: const Color(0xff021B79),
            value: sameName,
            onChanged: (value) {
              setState(() {
                sameName = !sameName;
              });
              getSameNumberData();
            },
          ),
        ),
        const SizedBox(width: 5),
        Text(
          'Same as Submitter name',
          style: GoogleFonts.montserrat(
              color: AppColors.appPrimaryTextColor,
              fontSize: 12,
              fontWeight: FontWeight.w400,
              fontStyle: FontStyle.normal),
        )
      ],
    );
  }

  /// validate form
  bool validate() {
    if (nameController.text == '') {
      showToastWidget(msg: 'Please enter name');
      return false;
    } else if (updateNameController.text == '') {
      showToastWidget(msg: 'Please enter updater name');
      return false;
    } else if (lineNameController.text == '') {
      showToastWidget(msg: 'Please enter line name');
      return false;
    } else if (billNumberController.text == '') {
      showToastWidget(msg: 'Please enter bill number');
      return false;
    } else if (siController.text == '') {
      showToastWidget(msg: 'Please enter shipping instructions');
      return false;
    } else if (statusController.text == '') {
      showToastWidget(msg: 'Please enter comments');
      return false;
    }
    return true;
  }

  showToastWidget({required String msg}) {
    showToast(msg,
        context: context,
        backgroundColor: Colors.black45,
        animation: StyledToastAnimation.slideFromTop,
        reverseAnimation: StyledToastAnimation.slideToTop,
        position: StyledToastPosition.top,
        startOffset: const Offset(0.0, -3.0),
        reverseEndOffset: const Offset(0.0, -3.0),
        duration: const Duration(seconds: 4),
        //Animation duration   animDuration * 2 <= duration
        animDuration: const Duration(seconds: 1),
        curve: Curves.elasticOut,
        reverseCurve: Curves.fastOutSlowIn);
  }
}
