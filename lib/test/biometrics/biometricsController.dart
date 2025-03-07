import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';

class Fingerprintcontroller extends GetxController {
  LocalAuthentication auth = LocalAuthentication();
  void checkprint() async {
    bool isFingerprint;
    try {
      isFingerprint = await auth.canCheckBiometrics;

      if (isFingerprint) {
        bool result = await auth.authenticate(
          localizedReason: 'Please authenticate to show account balance',
          options: const AuthenticationOptions(
            useErrorDialogs: true,
            stickyAuth: true,
            sensitiveTransaction: true,
          ),
        );

        if (result) {
          print("Fingerprint is available");
          Get.toNamed('/welcome');
        } else {
          print("Fingerprint is not available");
        }
      } else {
        print("Fingerprint is not available");
      }
    } catch (e) {
      print(e);
    }
  }
}
