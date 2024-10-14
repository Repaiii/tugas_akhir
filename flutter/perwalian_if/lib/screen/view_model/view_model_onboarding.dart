import 'package:flutter/material.dart';
import 'package:flutter_admin_perwalian_if/screen/view/login/login.dart';

class ViewModelOnBoarding with ChangeNotifier {
  void delayOnBoarding(BuildContext context) async {
    Future.delayed(
      const Duration(seconds: 3),
      () {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (_) => const Login(),
            ),
            (route) => false);
      },
    );
  }
}
