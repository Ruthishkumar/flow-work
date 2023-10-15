import 'package:flutter/cupertino.dart';

class BillingProvider extends ChangeNotifier {
  String documentId = "";

  void addDocumentId(String value) {
    documentId = value;
    notifyListeners();
  }
}
