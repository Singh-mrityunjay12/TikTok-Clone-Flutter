import 'package:flutter/material.dart';
import 'package:tic_tok/constant.dart';

class TextInputField extends StatelessWidget {
  // final - Jab Aapko Pata ho ki ye ab change nahi hoga - const But Widgets/Methods Ke Liye
  final TextEditingController controller;
  final IconData myIcon;
  final String myLabelText;
  final bool toHide;
  const TextInputField({
    Key? key,
    required this.controller,
    required this.myIcon, //yadi hmane jis bhi variable ko initilized nahi kiya h use named costructor banate time required likhana padata h
    required this.myLabelText,
    this.toHide = false,

    ///yaha per toHide me hamlogo ne value de di h false isiliye required ki jarurat nahi h ye optional h
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: toHide, //text ko hide aur show karane ke liye use karate h
      controller: controller,
      decoration: InputDecoration(
        filled: true,
        icon: Icon(myIcon),
        labelText: myLabelText,
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(
              color: borderColor,
            )),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(
            color: borderColor,
          ),
        ),
      ),
    );
  }
}
