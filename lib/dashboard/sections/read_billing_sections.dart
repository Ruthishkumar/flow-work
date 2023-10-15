import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:work_management/dashboard/provider/provider.dart';
import 'package:work_management/dashboard/utils/app_colors.dart';
import 'package:work_management/dashboard/utils/app_styles.dart';

class ReadBillingSections extends StatefulWidget {
  const ReadBillingSections({Key? key}) : super(key: key);

  @override
  State<ReadBillingSections> createState() => _ReadBillingSectionsState();
}

class _ReadBillingSectionsState extends State<ReadBillingSections> {
  // @override
  // void initState() {
  //   getData();
  //   super.initState();
  // }

  late EmployeeDataSource _employeeDataSource;

  List<Employee> _employees = <Employee>[];

  @override
  void initState() {
    super.initState();
    _employees = getEmployeeData();
    _employeeDataSource = EmployeeDataSource(employees: _employees);
  }

  List<Employee> getEmployeeData() {
    return [
      Employee(10001, 'James', 'Project Lead', 20000),
      Employee(10002, 'Kathryn', 'Manager', 30000),
      Employee(10003, 'Lara', 'Developer', 15000),
      Employee(10004, 'Michael', 'Designer', 15000),
      Employee(10005, 'Martin', 'Developer', 15000),
      Employee(10006, 'Newberry', 'Developer', 15000),
      Employee(10007, 'Balnc', 'Developer', 15000),
      Employee(10008, 'Perry', 'Developer', 15000),
      Employee(10009, 'Gable', 'Developer', 15000),
      Employee(10010, 'Grimes', 'Developer', 15000)
    ];
  }

  final dataStream = FirebaseFirestore.instance.collection('billing').get();

  final df = DateFormat('dd MMM, yyyy');

  getData() async {
    // DocumentSnapshot querySnapshot = await _collectionRef.doc().get();
    //
    // // Get data from docs and convert map to List
    // List<Object?> allData =
    //     querySnapshot.docs.map((doc) => doc.data()).toList();
    // for (int i = 0 ; i < allData.length ; i++) {
    //   print(allData[i]? )
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appPrimaryColor,
      body: Container(
        padding: const EdgeInsets.fromLTRB(40, 100, 40, 100),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('S.No', style: AppStyles.instance.viewHeaderName),
                Text('Submitter Name',
                    style: AppStyles.instance.viewHeaderName),
                Text('Line Name', style: AppStyles.instance.viewHeaderName),
                Text('Bill Number', style: AppStyles.instance.viewHeaderName),
                Text('Shipping Instructions',
                    style: AppStyles.instance.viewHeaderName),
                Text('Created Date', style: AppStyles.instance.viewHeaderName),
                Text('Amend', style: AppStyles.instance.viewHeaderName),
                Text('Revised', style: AppStyles.instance.viewHeaderName),
                Text('Status', style: AppStyles.instance.viewHeaderName),
                Text('Edit', style: AppStyles.instance.viewHeaderName),
              ],
            ),
            const SizedBox(height: 30),
            StreamBuilder(
              stream: dataStream.asStream(),
              builder: (context, snapShot) {
                if (snapShot.hasError) {
                  return const Text('No Data Found');
                }
                if (snapShot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                var billingDetails = snapShot.data!.docs;

                return ListView.builder(
                    shrinkWrap: true,
                    // scrollDirection: Axis.horizontal,
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemCount: billingDetails.length,
                    itemBuilder: (BuildContext context, int index) {
                      final upcomingSortedItems = billingDetails
                        ..sort((item1, item2) =>
                            item1['createAt'].compareTo(item2['createAt']));
                      final upcomingItems = upcomingSortedItems[index];
                      String createDate = upcomingItems['createAt'];
                      var date = createDate.split('T').first;
                      return Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('${index + 1}',
                                  style: AppStyles.instance.viewBodyName),
                              Text(upcomingItems['submitterName'] ?? '',
                                  style: AppStyles.instance.viewBodyName),
                              Text(upcomingItems['lineName'] ?? '',
                                  style: AppStyles.instance.viewBodyName),
                              Text(upcomingItems['billNumber'] ?? '',
                                  style: AppStyles.instance.viewBodyName),
                              Text(upcomingItems['shippingInstructions'] ?? '',
                                  style: AppStyles.instance.viewBodyName),
                              Text(date,
                                  style: AppStyles.instance.viewBodyName),
                              upcomingItems['amend'] == null
                                  ? Text(
                                      'No Amend',
                                      style: AppStyles.instance.viewBodyName,
                                    )
                                  : Text(upcomingItems['amend'] ?? '',
                                      style: AppStyles.instance.viewBodyName),
                              upcomingItems['revised'] == null
                                  ? Text(
                                      'No Revised',
                                      style: AppStyles.instance.viewBodyName,
                                    )
                                  : Text(upcomingItems['revised'] ?? '',
                                      style: AppStyles.instance.viewBodyName),
                              upcomingItems['status'] == null
                                  ? Text(
                                      'No Status',
                                      style: AppStyles.instance.viewBodyName,
                                    )
                                  : Text(upcomingItems['status'] ?? '',
                                      style: AppStyles.instance.viewBodyName),
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
                                  child: const MouseRegion(
                                    cursor: SystemMouseCursors.click,
                                    child: Icon(Icons.edit_note_outlined,
                                        size: 20, color: Colors.white),
                                  ))
                            ],
                          ),
                          const SizedBox(height: 30),
                        ],
                      );
                    });
              },
            ),
          ],
        ),
      ),
      // body: Center(
      //   child: Column(
      //     crossAxisAlignment: CrossAxisAlignment.center,
      //     children: [
      //       SfDataGrid(
      //         source: _employeeDataSource,
      //         columns: [
      //           GridColumn(
      //               columnName: 'id',
      //               label: Container(
      //                   padding: EdgeInsets.symmetric(horizontal: 16.0),
      //                   alignment: Alignment.centerRight,
      //                   child: Text(
      //                     'ID',
      //                     overflow: TextOverflow.ellipsis,
      //                   ))),
      //           GridColumn(
      //               columnName: 'name',
      //               label: Container(
      //                   padding: EdgeInsets.symmetric(horizontal: 16.0),
      //                   alignment: Alignment.centerLeft,
      //                   child: Text(
      //                     'Name',
      //                     overflow: TextOverflow.ellipsis,
      //                   ))),
      //           GridColumn(
      //               columnName: 'designation',
      //               label: Container(
      //                   padding: EdgeInsets.symmetric(horizontal: 16.0),
      //                   alignment: Alignment.centerLeft,
      //                   child: Text(
      //                     'Designation',
      //                     overflow: TextOverflow.ellipsis,
      //                   ))),
      //           GridColumn(
      //               columnName: 'salary',
      //               label: Container(
      //                   padding: EdgeInsets.symmetric(horizontal: 16.0),
      //                   alignment: Alignment.centerRight,
      //                   child: Text(
      //                     'Salary',
      //                     overflow: TextOverflow.ellipsis,
      //                   ))),
      //         ],
      //       ),
      //     ],
      //   ),
      // ),
    );
    // body: Container(
    //   padding: EdgeInsets.fromLTRB(40, 100, 40, 100),
    //   child: Center(
    //       child: Column(
    //     children: [
    //       Row(
    //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //         children: [
    //           Text('Submitter Name',
    //               style: AppStyles.instance.viewHeaderName),
    //           Text('Line Name', style: AppStyles.instance.viewHeaderName),
    //           Text('Bill Number', style: AppStyles.instance.viewHeaderName),
    //           Text('Amend', style: AppStyles.instance.viewHeaderName),
    //           Text('Revised', style: AppStyles.instance.viewHeaderName),
    //           Text('Status', style: AppStyles.instance.viewHeaderName),
    //         ],
    //       ),
    //       const SizedBox(height: 40),
    //       FutureBuilder<QuerySnapshot>(
    //         future: FirebaseFirestore.instance
    //             .collection('billing') // 👈 Your collection name here
    //             .get(),
    //         builder: (_, snapshot) {
    //           if (snapshot.hasError) return Text('Error = ${snapshot.error}');
    //           if (snapshot.connectionState == ConnectionState.waiting) {
    //             return const Text("Loading");
    //           }
    //           return ListView(
    //               shrinkWrap: true,
    //               physics: const AlwaysScrollableScrollPhysics(),
    //               children:
    //                   snapshot.data!.docs.map((DocumentSnapshot document) {
    //                 Map<String, dynamic> data =
    //                     document.data() as Map<String, dynamic>;
    //                 return Column(
    //                   crossAxisAlignment: CrossAxisAlignment.start,
    //                   children: [
    //                     Row(
    //                       crossAxisAlignment: CrossAxisAlignment.start,
    //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                       children: [
    //                         Text(
    //                           data['submitterName'].toString(),
    //                           style: AppStyles.instance.viewBodyName,
    //                         ),
    //                         Text(
    //                           data['lineName'].toString(),
    //                           style: AppStyles.instance.viewBodyName,
    //                         ),
    //                         Text(
    //                           data['billNumber'].toString(),
    //                           style: AppStyles.instance.viewBodyName,
    //                         ),
    //                         Text(data['lineName'].toString(),
    //                             style: AppStyles.instance.viewBodyName),
    //                         Text(data['lineName'].toString(),
    //                             style: AppStyles.instance.viewBodyName),
    //                         Text(data['lineName'].toString(),
    //                             style: AppStyles.instance.viewBodyName),
    //                       ],
    //                     ),
    //                     const SizedBox(height: 20),
    //                   ],
    //                 );
    //               }).toList());
    //         },
    //       ),
    //     ],
    //   )),
    // ),
  }
}

class Employee {
  Employee(this.id, this.name, this.designation, this.salary);
  final int id;
  final String name;
  final String designation;
  final int salary;
}

class EmployeeDataSource extends DataGridSource {
  EmployeeDataSource({required List<Employee> employees}) {
    dataGridRows = employees
        .map<DataGridRow>((dataGridRow) => DataGridRow(cells: [
              DataGridCell<int>(columnName: 'id', value: dataGridRow.id),
              DataGridCell<String>(columnName: 'name', value: dataGridRow.name),
              DataGridCell<String>(
                  columnName: 'designation', value: dataGridRow.designation),
              DataGridCell<int>(
                  columnName: 'salary', value: dataGridRow.salary),
            ]))
        .toList();
  }

  List<DataGridRow> dataGridRows = [];

  @override
  List<DataGridRow> get rows => dataGridRows;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((dataGridCell) {
      return Container(
          alignment: (dataGridCell.columnName == 'id' ||
                  dataGridCell.columnName == 'salary')
              ? Alignment.centerRight
              : Alignment.centerLeft,
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            dataGridCell.value.toString(),
            overflow: TextOverflow.ellipsis,
          ));
    }).toList());
  }
}
