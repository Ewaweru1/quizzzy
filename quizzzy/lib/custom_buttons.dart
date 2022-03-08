import 'package:flutter/material.dart';

class CustomOutlinedBtn extends StatelessWidget {
  final String text;
  final double bt;
  final double h;
  final double w;
  final BuildContext context;
  final Route route;

  CustomOutlinedBtn({ Key? key, required this.text, required this.bt, required this.h, required this.w, 
                      required this.context, required this.route }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(

      bottom: bt,
      height: h,
      width: w,
      child: OutlinedButton(
        onPressed: () {
          Navigator.push(
            context,
            route);
        },
        style: OutlinedButton.styleFrom(
          side: const BorderSide(
            color: Color.fromARGB(255, 93, 0, 155),
            width: 2.0,
            style: BorderStyle.solid,
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(fontFamily: 'Heebo', fontSize: 24, fontWeight: FontWeight.w500, color: Colors.white),
        ),
      )
    );
  }
}