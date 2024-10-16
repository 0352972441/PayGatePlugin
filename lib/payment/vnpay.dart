// import 'dart:convert';
// import 'dart:io';
// import 'package:crypto/crypto.dart';
// import 'package:flutter/foundation.dart';
// import 'package:intl/intl.dart';
// import 'package:paygateplugin/models/vnpay_payment_params.dart';

// enum VNPayHashType { sha256, hmacsha512 }

// extension VNPayHashTypeExt on VNPayHashType {
//   String toValueString() {
//     switch (this) {
//       case VNPayHashType.sha256:
//         return 'SHA256';
//       case VNPayHashType.hmacsha512:
//         return 'HmacSHA512';
//     }
//   }
// }

// class VNPAYFlutter {
//   static final VNPAYFlutter _instance = VNPAYFlutter();
//   static VNPAYFlutter get instance => _instance;
//   Map<String, dynamic> _sortParams(Map<String, dynamic> params) {
//     final sortedParams = <String, dynamic>{};
//     final keys = params.keys.toList()..sort();
//     for (String key in keys) {
//       sortedParams[key] = params[key];
//     }
//     return sortedParams;
//   }

//   // Future<void> show({
//   //   required String paymentUrl,
//   //   LaunchMode? mode,
//   // }) async {
//   //   if (!await launchUrl(
//   //     Uri.parse(paymentUrl),
//   //     mode: mode ?? LaunchMode.platformDefault,
//   //   )) {
//   //     throw Exception('Could not launch');
//   //   }
//   // }

//   Future<String> getLocalIp() async {
//     try {
//       for (final interface in await NetworkInterface.list()) {
//         for (final addr in interface.addresses) {
//           if (addr.type == InternetAddressType.IPv4) {
//             return addr.address;
//           }
//         }
//       }
//     } catch (e) {
//       return 'Không xác định';
//     }
//     return 'Không xác định';
//   }

//   /// Generates a payment URL for VNPay.
//   ///
//   /// [url]: The payment gateway URL. Default is 'https://sandbox.vnpayment.vn/paymentv2/vpcpay.html'.
//   /// [version]: The version of the VNPay API to use - 2.0.1.
//   /// [command]: The command type, default is 'pay'.
//   /// [tmnCode]: The merchant's identifier.
//   /// [locale]: The locale for the transaction, default is 'vn'.
//   /// [currencyCode]: The currency code, default is 'VND'.
//   /// [txnRef]: A unique transaction reference (e.g., current time in milliseconds).
//   /// [orderInfo]: Information about the order. Default is 'Pay Order'.
//   /// [amount]: The amount to be paid (in VND).
//   /// [returnUrl]: The URL to return to after payment.
//   /// [ipAdress]: The IP address of the payer. Use [getLocalIp()] to retrieve.
//   /// [createAt]: The creation date of the transaction, defaults to now if not provided.
//   /// [vnpayHashKey]: The merchant's secure key.
//   /// [vnPayHashType]: The hashing method used. Default is HMAC-SHA512.
//   /// [vnpayOrderType]: The type of the order, default is 'other'.
//   /// [vnpayExpireDate]: The expiration date of the transaction.
//   String generatePaymentUrl({
//     required VnpayPaymentParams paymentParams,
//   }) {
//     final params = <String, String>{
//       'vnp_Version': paymentParams.version,
//       'vnp_Command': paymentParams.command,
//       'vnp_TmnCode': paymentParams.tmnCode,
//       'vnp_Locale': paymentParams.locale,
//       'vnp_CurrCode': paymentParams.currencyCode,
//       'vnp_TxnRef': paymentParams.txnRef,
//       'vnp_OrderInfo': paymentParams.orderInfo,
//       'vnp_Amount': (paymentParams.amount * 100).toStringAsFixed(0),
//       'vnp_ReturnUrl': paymentParams.returnUrl,
//       'vnp_IpAddr': paymentParams.ipAdress,
//       'vnp_CreateDate': DateFormat('yyyyMMddHHmmss').format(paymentParams.createAt ?? DateTime.now()).toString(),
//       'vnp_OrderType': paymentParams.vnpayOrderType,
//       'vnp_ExpireDate': DateFormat('yyyyMMddHHmmss').format(paymentParams.vnpayExpireDate).toString(),
//     };
//     var sortedParam = _sortParams(params);
//     final hashDataBuffer = StringBuffer();
//     sortedParam.forEach((key, value) {
//       hashDataBuffer.write(key);
//       hashDataBuffer.write('=');
//       hashDataBuffer.write(value);
//       hashDataBuffer.write('&');
//     });
//     String hashData = hashDataBuffer.toString().substring(0, hashDataBuffer.length - 1);
//     String query = sortedParam.entries
//         .map((e) => '${e.key}=${e.value}')
//         .join('&'); //Uri(host: url, queryParameters: sortedParam).query;
//     String vnpSecureHash = "";

//     if (paymentParams.vnPayHashType == VNPayHashType.sha256) {
//       List<int> bytes = utf8.encode(paymentParams.vnpayHashKey + hashData.toString());
//       vnpSecureHash = sha256.convert(bytes).toString();
//     } else if (paymentParams.vnPayHashType == VNPayHashType.hmacsha512) {
//       vnpSecureHash = Hmac(sha512, utf8.encode(paymentParams.vnpayHashKey)).convert(utf8.encode(hashData)).toString();
//     }
//     String paymentUrl =
//         "${paymentParams.url}?$query&vnp_SecureHashType=${paymentParams.vnPayHashType.toValueString()}&vnp_SecureHash=$vnpSecureHash";
//     debugPrint("=====>[PAYMENT URL]: $paymentUrl");
//     return paymentUrl;
//   }



// }
