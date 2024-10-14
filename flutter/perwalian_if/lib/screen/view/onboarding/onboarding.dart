import 'package:flutter/material.dart';
import 'package:flutter_admin_perwalian_if/screen/view_model/view_model_login.dart';
import 'package:provider/provider.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({Key? key}) : super(key: key);

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  // late ViewModelOnBoarding viewModel;
  late ViewModelLogin viewModel;
  @override
  void initState() {
    // viewModel = Provider.of<ViewModelOnBoarding>(context, listen: false);
    viewModel = Provider.of<ViewModelLogin>(context, listen: false);
    viewModel.checkLogin(context);
    // viewModel.delayOnBoarding(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child:
            // Padding(
            //   padding: const EdgeInsets.all(13.0),
            //   child: SvgPicture.asset(
            //     "assets/logo_aplikasi.svg",
            //   ),
            // ),
            Image.asset(
          "assets/onBoarding.png",
          width: 120.0,
          height: 120.0,
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
