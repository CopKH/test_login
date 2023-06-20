import 'package:flutter/material.dart';

class ButtonTest extends StatelessWidget {
  final String tilte;
  final Icon icon;
  final Function pressHandler;
  const ButtonTest({super.key, required this.tilte, required this.icon, required this.pressHandler});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize:const Size(double.infinity, 45),
        backgroundColor:  Colors.black54,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
      ),
      onPressed: ()=>pressHandler(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Opacity(
            opacity: 0,
            child: Icon(Icons.arrow_forward),
          ),
          Text(tilte),
          icon,
        ],
      ),
    );
  }
}
