

import 'package:paygateplugin/payment/vnpay.dart';

class VnpayPaymentParams {
  final String url;
  final String version;
  final String command;
  final String tmnCode;
  final String locale;
  final String currencyCode;
  final String txnRef;
  final String orderInfo;
  final double amount;
  final String returnUrl;
  final String ipAdress;
  final DateTime? createAt;
  final String vnpayHashKey;
  final VNPayHashType vnPayHashType;
  final String vnpayOrderType;
  final DateTime vnpayExpireDate;

  VnpayPaymentParams({
    this.url = 'https://sandbox.vnpayment.vn/paymentv2/vpcpay.html',
    required this.version,
    this.command = 'pay',
    required this.tmnCode,
    this.locale = 'vn',
    this.currencyCode = 'VND',
    required this.txnRef,
    this.orderInfo = 'Pay Order',
    required this.amount,
    required this.returnUrl,
    required this.ipAdress,
    this.createAt,
    required this.vnpayHashKey,
    this.vnPayHashType = VNPayHashType.hmacsha512,
    this.vnpayOrderType = 'other',
    required this.vnpayExpireDate,
  });
}
