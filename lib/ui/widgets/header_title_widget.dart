import 'package:flutter/material.dart';

class HeaderTitleWidget extends StatefulWidget {
  const HeaderTitleWidget({super.key, required this.text});

  final String text;

  @override
  State<HeaderTitleWidget> createState() => _HeaderTitleWidgetState();
}

class _HeaderTitleWidgetState extends State<HeaderTitleWidget> {
  @override
  Widget build(BuildContext context) {
    return Text(
      widget.text,
      style: const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
