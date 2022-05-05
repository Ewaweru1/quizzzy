import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quizzzy/src/home_page.dart';
import '../../libs/custom_widgets.dart';

class VerifyEmail extends StatefulWidget {
  const VerifyEmail({Key? key}) : super(key: key);

  @override
  State<VerifyEmail> createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {
  User? user;
  Timer? timer;

  @override
  initState() {
    timer = Timer.periodic(const Duration(seconds: 3), (time) {
      checkEmailVerification();
    });
    super.initState();
  }

  @override
  dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return QuizzzyTemplate(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "You need to verify your account before going further. A verification email has been already sent to your email.",
          style: TextStyle(
            fontFamily: 'Heebo',
            fontSize: 18,
            fontWeight: FontWeight.w400,
            color: Color.fromARGB(255, 255, 255, 255),
          ),
          textAlign: TextAlign.center,
        ),
        QuizzzyNavigatorBtn(
          text: "Resend Email",
          onTap: () => user?.sendEmailVerification(),
          clr: Colors.green[400],
        ),
      ],
    ));
  }

  Future<void> checkEmailVerification() async {
    await user?.reload();

    if (user!.emailVerified) {
      timer?.cancel();
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const HomePage()));
    }
  }
}
