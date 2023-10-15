import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'create_billing_model.g.dart';

@JsonSerializable()
class CreateBillingModel {
  String submitterName;
  String lineName;
  String billNumber;
  String shippingInstructions;
  DateTime? createAt;
  DateTime? updatedAt;
  @JsonKey(defaultValue: '')
  String? amend;
  @JsonKey(defaultValue: '')
  String? revised;
  @JsonKey(defaultValue: '')
  String? status;

  CreateBillingModel(
      {required this.submitterName,
      required this.lineName,
      required this.billNumber,
      required this.shippingInstructions,
      this.createAt,
      this.updatedAt,
      this.amend,
      this.status,
      this.revised});

  factory CreateBillingModel.fromJson(Map<String, dynamic> json) =>
      _$CreateBillingModelFromJson(json);
  Map<String, dynamic> toJson() => _$CreateBillingModelToJson(this);
}

class TimestampConverter implements JsonConverter<DateTime, Timestamp> {
  const TimestampConverter();

  @override
  DateTime fromJson(Timestamp timestamp) {
    return timestamp.toDate();
  }

  @override
  Timestamp toJson(DateTime date) => Timestamp.fromDate(date);
}
