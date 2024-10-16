// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names


import 'dart:convert';

import 'package:intl/intl.dart';

class VnpayPaymentParams {
  String? userId;
  String? vnp_Version;
  String? vnp_Command;
  String? vnp_TmnCode;
  String? vnp_Locale;
  String? vnp_CurrCode;
  String? vnp_TxnRef;
  String? vnp_OrderInfo;
  num? vnp_Amount;
  String? vnp_ReturnUrl;
  String? vnp_IpAddr;
  DateTime? vnp_CreateDate;
  String? vnp_OrderType;
  DateTime? vnp_ExpireDate;

  VnpayPaymentParams({
    this.userId,
    this.vnp_Version,
    this.vnp_Command,
    this.vnp_TmnCode,
    this.vnp_Locale,
    this.vnp_CurrCode,
    this.vnp_TxnRef,
    this.vnp_OrderInfo,
    this.vnp_Amount,
    this.vnp_ReturnUrl,
    this.vnp_IpAddr,
    this.vnp_CreateDate,
    this.vnp_OrderType,
    this.vnp_ExpireDate,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      if(userId != null) 'userId': userId,
      if(vnp_Version != null) 'vnp_Version': vnp_Version,
      if(vnp_Command != null) 'vnp_Command': vnp_Command,
      if(vnp_TmnCode != null) 'vnp_TmnCode': vnp_TmnCode,
      if(vnp_Locale != null) 'vnp_Locale': vnp_Locale,
      if(vnp_CurrCode != null) 'vnp_CurrCode': vnp_CurrCode,
      if(vnp_TxnRef != null) 'vnp_TxnRef': vnp_TxnRef,
      if(vnp_OrderInfo != null) 'vnp_OrderInfo': vnp_OrderInfo,
      if(vnp_Amount != null) 'vnp_Amount': vnp_Amount,
      if(vnp_ReturnUrl != null) 'vnp_ReturnUrl': vnp_ReturnUrl,
      if(vnp_IpAddr != null) 'vnp_IpAddr': vnp_IpAddr,
      if(vnp_CreateDate != null) 'vnp_CreateDate': DateFormat('yyyyMMddHHmmss').format(vnp_CreateDate!).toString(),
      if(vnp_OrderType != null) 'vnp_OrderType': vnp_OrderType,
      if(vnp_ExpireDate != null) 'vnp_ExpireDate': DateFormat('yyyyMMddHHmmss').format(vnp_ExpireDate!).toString(),
    };
  }

  factory VnpayPaymentParams.fromMap(Map<String, dynamic> map) {
    return VnpayPaymentParams(
      userId: map['userId'] != null ? map['userId'] as String : null,
      vnp_Version: map['vnp_Version'] != null ? map['vnp_Version'] as String : null,
      vnp_Command: map['vnp_Command'] != null ? map['vnp_Command'] as String : null,
      vnp_TmnCode: map['vnp_TmnCode'] != null ? map['vnp_TmnCode'] as String : null,
      vnp_Locale: map['vnp_Locale'] != null ? map['vnp_Locale'] as String : null,
      vnp_CurrCode: map['vnp_CurrCode'] != null ? map['vnp_CurrCode'] as String : null,
      vnp_TxnRef: map['vnp_TxnRef'] != null ? map['vnp_TxnRef'] as String : null,
      vnp_OrderInfo: map['vnp_OrderInfo'] != null ? map['vnp_OrderInfo'] as String : null,
      vnp_Amount: map['vnp_Amount'] != null ? map['vnp_Amount'] as num : null,
      vnp_ReturnUrl: map['vnp_ReturnUrl'] != null ? map['vnp_ReturnUrl'] as String : null,
      vnp_IpAddr: map['vnp_IpAddr'] != null ? map['vnp_IpAddr'] as String : null,
      // vnp_CreateDate: map['vnp_CreateDate'] != null ? map['vnp_CreateDate'] as String : null,
      vnp_OrderType: map['vnp_OrderType'] != null ? map['vnp_OrderType'] as String : null,
      // vnp_ExpireDate: map['vnp_ExpireDate'] != null ? map['vnp_ExpireDate'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory VnpayPaymentParams.fromJson(String source) => VnpayPaymentParams.fromMap(json.decode(source) as Map<String, dynamic>);
}
