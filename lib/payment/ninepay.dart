import 'dart:convert';
import 'package:http/http.dart';


class NinePAYFlutter {
  static final NinePAYFlutter _instance = NinePAYFlutter();
  static NinePAYFlutter get instance => _instance;

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

  /// Generates a payment URL for NINEPAY.
  ///
  /// [url]: url api gen payment gateway URL.
  ///
  /// [params]: Dữ liệu truyền lên BE xử lý.
  ///
  Future<String> generatePaymentUrl({required String url, required Map<String, dynamic> params}) async {
    try {
      String paymentUrl = '';
      final response = await post(
        Uri.parse(url), // Thay thế với URL API của bạn
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(params),
      );
      if (response.statusCode >= 200 && response.statusCode <= 300) {
        paymentUrl = response.body.toString();
      }
      return paymentUrl;
    } catch (e) {
      return '';
    }
  }
}
