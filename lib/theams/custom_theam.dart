import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CutomsScreen extends StatelessWidget {
  const CutomsScreen({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Image.asset(
            'assets/images/bg44.jpg',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          SafeArea(child: child),
        ],
      ),
    );
  }
}
