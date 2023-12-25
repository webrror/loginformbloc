import 'package:flutter/material.dart';
import 'package:loginformbloc/pallete.dart';

class GradientButton extends StatelessWidget {
  const GradientButton({Key? key, required this.onPressed, this.text = 'Sign in'})
      : super(key: key);
  final VoidCallback onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Pallete.gradient1,
            Pallete.gradient2,
            Pallete.gradient3,
          ],
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
        ),
        borderRadius: BorderRadius.circular(7),
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
            fixedSize: const Size(395, 55),
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(7),
            )),
        child: Text(
          text,
          style: const TextStyle(
              fontWeight: FontWeight.w600, fontSize: 17, color: Colors.white),
        ),
      ),
    );
  }
}
