import 'package:flutter/material.dart';
class LyrcsResult extends StatefulWidget {
  final String data;
  const LyrcsResult({super.key, required this.data});

  @override
  State<LyrcsResult> createState() => _LyrcsResultState();
}

class _LyrcsResultState extends State<LyrcsResult> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text(widget.data, style: TextStyle(color: Colors.black),),
    );
  }
}