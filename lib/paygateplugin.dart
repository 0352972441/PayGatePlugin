library paygateplugin;
import 'package:url_launcher/url_launcher.dart';


class PayGatePlugin {
  static final PayGatePlugin _instance = PayGatePlugin();
  static PayGatePlugin get instance => _instance;

  Future<void> show({
    required String paymentUrl,
    LaunchMode? mode,
  }) async {
    if (!await launchUrl(
      Uri.parse(paymentUrl),
      mode: mode ?? LaunchMode.platformDefault,
    )) {
      throw Exception('Could not launch');
    }
  }
}
