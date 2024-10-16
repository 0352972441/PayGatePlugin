import 'dart:convert';
import 'dart:io';
import 'package:crypto/crypto.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:paygateplugin/models/vnpay_payment_params.dart';

enum VNPayHashType { sha256, hmacsha512 }

extension VNPayHashTypeExt on VNPayHashType {
  String toValueString() {
    switch (this) {
      case VNPayHashType.sha256:
        return 'SHA256';
      case VNPayHashType.hmacsha512:
        return 'HmacSHA512';
    }
  }
}

class VNPAYFlutter {
  static final VNPAYFlutter _instance = VNPAYFlutter();
  static VNPAYFlutter get instance => _instance;
  Map<String, dynamic> _sortParams(Map<String, dynamic> params) {
    final sortedParams = <String, dynamic>{};
    final keys = params.keys.toList()..sort();
    for (String key in keys) {
      sortedParams[key] = params[key];
    }
    return sortedParams;
  }

  // Future<void> show({
  //   required String paymentUrl,
  //   LaunchMode? mode,
  // }) async {
  //   if (!await launchUrl(
  //     Uri.parse(paymentUrl),
  //     mode: mode ?? LaunchMode.platformDefault,
  //   )) {
  //     throw Exception('Could not launch');
  //   }
  // }

  Future<String> getLocalIp() async {
    try {
      for (final interface in await NetworkInterface.list()) {
        for (final addr in interface.addresses) {
          if (addr.type == InternetAddressType.IPv4) {
            return addr.address;
          }
        }
      }
    } catch (e) {
      return 'Không xác định';
    }
    return 'Không xác định';
  }

  /// Generates a payment URL for VNPay.
  ///
  /// [url]: The payment gateway URL. Default is 'https://sandbox.vnpayment.vn/paymentv2/vpcpay.html'.
  /// [version]: The version of the VNPay API to use - 2.0.1.
  /// [command]: The command type, default is 'pay'.
  /// [tmnCode]: The merchant's identifier.
  /// [locale]: The locale for the transaction, default is 'vn'.
  /// [currencyCode]: The currency code, default is 'VND'.
  /// [txnRef]: A unique transaction reference (e.g., current time in milliseconds).
  /// [orderInfo]: Information about the order. Default is 'Pay Order'.
  /// [amount]: The amount to be paid (in VND).
  /// [returnUrl]: The URL to return to after payment.
  /// [ipAdress]: The IP address of the payer. Use [getLocalIp()] to retrieve.
  /// [createAt]: The creation date of the transaction, defaults to now if not provided.
  /// [vnpayHashKey]: The merchant's secure key.
  /// [vnPayHashType]: The hashing method used. Default is HMAC-SHA512.
  /// [vnpayOrderType]: The type of the order, default is 'other'.
  /// [vnpayExpireDate]: The expiration date of the transaction.
  String generatePaymentUrl({
    required VnpayPaymentParams paymentParams,
  }) {
    final params = <String, String>{
      'vnp_Version': '2.0.1',
      'vnp_Command': 'pay',
      'vnp_TmnCode': paymentParams.vnp_TmnCode ?? '',
      'vnp_Locale': paymentParams.vnp_Locale ?? 'vn',
      'vnp_CurrCode': paymentParams.vnp_CurrCode ?? 'VND',
      'vnp_TxnRef': paymentParams.vnp_TxnRef ?? '',
      'vnp_OrderInfo': paymentParams.vnp_OrderInfo ?? '',
      'vnp_Amount': (paymentParams.vnp_Amount! * 100).toStringAsFixed(0),
      'vnp_ReturnUrl': paymentParams.vnp_ReturnUrl ?? '',
      'vnp_IpAddr': paymentParams.vnp_IpAddr ?? '',
      'vnp_CreateDate': DateFormat('yyyyMMddHHmmss').format(paymentParams.vnp_CreateDate ?? DateTime.now()).toString(),
      'vnp_OrderType': paymentParams.vnp_OrderType ?? 'other',
      'vnp_ExpireDate': DateFormat('yyyyMMddHHmmss').format(paymentParams.vnp_ExpireDate!).toString(),
    };
    var sortedParam = _sortParams(params);
    final hashDataBuffer = StringBuffer();
    sortedParam.forEach((key, value) {
      hashDataBuffer.write(key);
      hashDataBuffer.write('=');
      hashDataBuffer.write(value);
      hashDataBuffer.write('&');
    });
    String hashData = hashDataBuffer.toString().substring(0, hashDataBuffer.length - 1);
    String query = sortedParam.entries
        .map((e) => '${e.key}=${e.value}')
        .join('&'); //Uri(host: url, queryParameters: sortedParam).query;
    String vnpSecureHash = "";
    vnpSecureHash = Hmac(sha512, utf8.encode(paymentParams.key ?? '39QK4GLCL4M9LKED5CZCP8BZVGYWO12J'))
        .convert(utf8.encode(hashData))
        .toString();
    String paymentUrl =
        "https://sandbox.vnpayment.vn/paymentv2/vpcpay.html?$query&vnp_SecureHashType=${VNPayHashType.hmacsha512.toValueString()}&vnp_SecureHash=$vnpSecureHash";
    debugPrint("=====>[PAYMENT URL]: $paymentUrl");
    return paymentUrl;
  }
}
