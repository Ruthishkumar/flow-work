// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_billing_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateBillingModel _$CreateBillingModelFromJson(Map<String, dynamic> json) =>
    CreateBillingModel(
      submitterName: json['submitterName'] as String,
      lineName: json['lineName'] as String,
      billNumber: json['billNumber'] as String,
      shippingInstructions: json['shippingInstructions'] as String,
      createAt: json['createAt'] == null
          ? null
          : DateTime.parse(json['createAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      amend: json['amend'] as String? ?? '',
      status: json['status'] as String? ?? '',
      revised: json['revised'] as String? ?? '',
    );

Map<String, dynamic> _$CreateBillingModelToJson(CreateBillingModel instance) =>
    <String, dynamic>{
      'submitterName': instance.submitterName,
      'lineName': instance.lineName,
      'billNumber': instance.billNumber,
      'shippingInstructions': instance.shippingInstructions,
      'createAt': instance.createAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'amend': instance.amend,
      'revised': instance.revised,
      'status': instance.status,
    };
