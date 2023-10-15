import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
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
  TextEditingController lineNameController = TextEditingController();
  TextEditingController billNumberController = TextEditingController();
  TextEditingController siController = TextEditingController();
  TextEditingController amendController = TextEditingController();
  TextEditingController revisedController = TextEditingController();
  TextEditingController statusController = TextEditingController();

  @override
  void initState() {
    getData();
    super.initState();
  }

  String createdAtTime = "";
  final df = DateFormat('dd-MM-yyyy');

  getData() async {
    String myDocumentId =
        Provider.of<BillingProvider>(context, listen: false).documentId;
    DocumentSnapshot documentSnapshot;
    await FirebaseFirestore.instance
        .collection('billing')
        .doc(myDocumentId)
        .get()
        .then((value) {
      documentSnapshot = value; // you get the document here
      nameController.text = documentSnapshot['submitterName'];
      lineNameController.text = documentSnapshot['lineName'];
      billNumberController.text = documentSnapshot['billNumber'];
      siController.text = documentSnapshot['shippingInstructions'];
      statusController.text = documentSnapshot['status'] ?? '';
      createdAtTime = documentSnapshot['createAt'];
      print(createdAtTime);
      print('CREATE TIME');
      if (documentSnapshot['amend'] != null) {
        amendController.text = documentSnapshot['amend'];
        setState(() {
          showAmend = true;
        });
      }
      if (documentSnapshot['revised'] != null) {
        revisedController.text = documentSnapshot['revised'];
        setState(() {
          showRevised = true;
        });
      }
    });
  }

  bool showAmend = false;
  bool showRevised = false;

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
                  textInputAction: TextInputAction.done),
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
                  updatedAt: DateTime.now(),
                  amend: amendController.text,
                  revised: revisedController.text,
                  createAt: DateTime.now(),
                  status: statusController.text)
              .toJson()))
          .whenComplete(() {
        setState(() => buttonLoading = false);
      }).catchError((error) {
        print(error.toString());
      });
    }
  }

  /// validate form
  bool validate() {
    if (nameController.text == '') {
      return false;
    } else if (lineNameController.text == '') {
      return false;
    } else if (billNumberController.text == '') {
      return false;
    } else if (siController.text == '') {
      return false;
    } else if (statusController.text == '') {
      return false;
    }
    return true;
  }
}
