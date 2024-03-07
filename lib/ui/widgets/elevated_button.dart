import 'package:firebase_demo/core/constants/color_consant.dart';
import 'package:flutter/material.dart';

class ElevatedButtonWidget extends StatelessWidget {
  const ElevatedButtonWidget({super.key,required this.text,required this.onPressed});
  final String text;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      
      width: MediaQuery.of(context).size.width*.9,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 20),
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(10),bottomLeft: Radius.circular(10),bottomRight: Radius.circular(10))),
          backgroundColor: ColorConstants.black,
        ),
        onPressed: onPressed,
        child: Text(text,style: const TextStyle(color: ColorConstants.white),),
      ),
    );
  }
}
