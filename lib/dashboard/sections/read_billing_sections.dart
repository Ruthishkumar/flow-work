import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:work_management/dashboard/provider/provider.dart';
import 'package:work_management/dashboard/utils/app_colors.dart';
import 'package:work_management/dashboard/utils/app_styles.dart';

class ReadBillingSections extends StatefulWidget {
  const ReadBillingSections({Key? key}) : super(key: key);

  @override
  State<ReadBillingSections> createState() => _ReadBillingSectionsState();
}

class _ReadBillingSectionsState extends State<ReadBillingSections> {
  final dataStream = FirebaseFirestore.instance.collection('billing').get();
  final df = DateFormat('dd MMM, yyyy');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appPrimaryColor,
      body: Container(
        padding: const EdgeInsets.fromLTRB(40, 130, 40, 130),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      width: 50,
                      child: Text('S.No',
                          style: AppStyles.instance.viewHeaderName)),
                  Container(
                    width: 170,
                    child: Text('Submitter Name',
                        style: AppStyles.instance.viewHeaderName),
                  ),
                  Container(
                      width: 130,
                      child: Text('Line Name',
                          style: AppStyles.instance.viewHeaderName)),
                  Container(
                      width: 130,
                      child: Text('Bill Number',
                          style: AppStyles.instance.viewHeaderName)),
                  Container(
                    width: 190,
                    child: Text('Shipping Instructions',
                        style: AppStyles.instance.viewHeaderName),
                  ),
                  Container(
                      width: 130,
                      child: Text('Created Date',
                          style: AppStyles.instance.viewHeaderName)),
                  Container(
                      width: 110,
                      child: Text('Amend',
                          style: AppStyles.instance.viewHeaderName)),
                  Container(
                      width: 110,
                      child: Text('Revised',
                          style: AppStyles.instance.viewHeaderName)),
                  Container(
                      width: 110,
                      child: Text('Status',
                          style: AppStyles.instance.viewHeaderName)),
                  Container(
                      width: 50,
                      child: Text('Edit',
                          style: AppStyles.instance.viewHeaderName)),
                ],
              ),
              const SizedBox(height: 30),
              StreamBuilder(
                stream: dataStream.asStream(),
                builder: (context, snapShot) {
                  if (snapShot.hasError) {
                    return Text('No Data Found',
                        style: AppStyles.instance.viewBodyName);
                  }
                  if (snapShot.connectionState == ConnectionState.waiting) {
                    return const SizedBox(
                        height: 250,
                        child: Center(
                            child: CircularProgressIndicator(
                          color: Colors.white,
                        )));
                  }
                  var billingDetails = snapShot.data!.docs;

                  return ListView.separated(
                      shrinkWrap: true,
                      // scrollDirection: Axis.horizontal,
                      physics: const NeverScrollableScrollPhysics(),
                      separatorBuilder: (BuildContext context, int index) =>
                          const SingleChildScrollView(
                            child: Column(
                              children: [
                                SizedBox(height: 15),
                                Divider(
                                  height: 1,
                                  color: Color(0xffE3E3E3),
                                ),
                                SizedBox(height: 15),
                              ],
                            ),
                          ),
                      itemCount: billingDetails.length,
                      itemBuilder: (BuildContext context, int index) {
                        final upcomingSortedItems = billingDetails
                          ..sort((item1, item2) =>
                              item2['createAt'].compareTo(item1['createAt']));
                        final upcomingItems = upcomingSortedItems[index];
                        String createDate = upcomingItems['createAt'];
                        var date = createDate.split(',').first;
                        return Column(
                          children: [
                            Container(
                              // padding: const EdgeInsets.all(15),
                              decoration: const BoxDecoration(
                                  // color: Colors.grey,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(6))),
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 50,
                                      child: Text('${index + 1}',
                                          style:
                                              AppStyles.instance.viewBodyName),
                                    ),
                                    Container(
                                      width: 170,
                                      child: Text(
                                          upcomingItems['submitterName'] ?? '',
                                          style:
                                              AppStyles.instance.viewBodyName),
                                    ),
                                    Container(
                                      width: 130,
                                      child: Text(
                                          upcomingItems['lineName'] ?? '',
                                          style:
                                              AppStyles.instance.viewBodyName),
                                    ),
                                    Container(
                                      width: 130,
                                      child: Text(
                                          upcomingItems['billNumber'] ?? '',
                                          style:
                                              AppStyles.instance.viewBodyName),
                                    ),
                                    Container(
                                      width: 190,
                                      child: Text(
                                          upcomingItems[
                                                  'shippingInstructions'] ??
                                              '',
                                          style:
                                              AppStyles.instance.viewBodyName),
                                    ),
                                    Container(
                                      width: 130,
                                      child: Text(date,
                                          style:
                                              AppStyles.instance.viewBodyName),
                                    ),
                                    upcomingItems['amend'] == '' ||
                                            upcomingItems['amend'] == null
                                        ? Container(
                                            width: 110,
                                            child: Text(
                                              'No Amend',
                                              style: AppStyles
                                                  .instance.viewBodyName,
                                            ),
                                          )
                                        : Container(
                                            width: 110,
                                            child: Text(
                                                upcomingItems['amend'] ?? '',
                                                style: AppStyles
                                                    .instance.viewBodyName),
                                          ),
                                    upcomingItems['revised'] == '' ||
                                            upcomingItems['revised'] == null
                                        ? Container(
                                            width: 110,
                                            child: Text(
                                              'No Revised',
                                              style: AppStyles
                                                  .instance.viewBodyName,
                                            ),
                                          )
                                        : Container(
                                            width: 110,
                                            child: Text(
                                                upcomingItems['revised'] ?? '',
                                                style: AppStyles
                                                    .instance.viewBodyName),
                                          ),
                                    upcomingItems['status'] == '' ||
                                            upcomingItems['status'] == null
                                        ? Container(
                                            width: 110,
                                            child: Text(
                                              'No Status',
                                              style: AppStyles
                                                  .instance.viewBodyName,
                                            ),
                                          )
                                        : Container(
                                            width: 110,
                                            child: Text(
                                                upcomingItems['status'] ?? '',
                                                style: AppStyles
                                                    .instance.viewBodyName),
                                          ),
                                    GestureDetector(
                                        onTap: () {
                                          Provider.of<BillingProvider>(context,
                                                  listen: false)
                                              .addDocumentId(upcomingItems.id);
                                          // print(billingDetails[index].id);
                                          // print(billingDetails[index]['uniqueId']);
                                          // print('BILLING ID');
                                          context.push('/update');
                                        },
                                        child: MouseRegion(
                                          cursor: SystemMouseCursors.click,
                                          child: Container(
                                            width: 50,
                                            child: const Icon(
                                                Icons.edit_note_outlined,
                                                size: 20,
                                                color: Colors.white),
                                          ),
                                        ))
                                  ],
                                ),
                              ),
                            ),
                          ],
                        );
                      });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
