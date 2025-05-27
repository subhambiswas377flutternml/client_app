import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final Function() onClick;
  const PrimaryButton({
    required this.text,
    required this.onClick,
    super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
              onPressed: (){
                onClick.call();
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 12),
                backgroundColor: Colors.blue,
              ),
              child: Text(text,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                  color: Colors.white
                )
              ),
              );
  }
}