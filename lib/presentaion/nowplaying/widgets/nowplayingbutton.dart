import 'package:beatboxnew/core/const.dart';
import 'package:flutter/material.dart';

class Mynowplayingbutton extends StatelessWidget {
  const Mynowplayingbutton(
      {super.key, required this.nowplayingbutton, required this.onPressed});
  final IconData nowplayingbutton;
  final void Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 50,
        child: Container(
          decoration: const BoxDecoration(
              color: klightblue,
              borderRadius: BorderRadius.all(Radius.circular(50)),
              boxShadow: [
                BoxShadow(
                    color: Color.fromARGB(255, 119, 182, 145),
                    offset: Offset(4.5, 4.5),
                    blurRadius: 15.5,
                    spreadRadius: 3),
                BoxShadow(
                    color: Color.fromARGB(179, 36, 33, 33),
                    offset: Offset(-4.5, -4.5),
                    blurRadius: 15.5,
                    spreadRadius: 3),
              ]),
          width: 60,
          child: IconButton(
              icon: Icon(
                nowplayingbutton,
                size: 30,
                color: kblack,
              ),
              onPressed: onPressed),
        ));
  }
}
