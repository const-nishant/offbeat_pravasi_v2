import 'package:flutter/material.dart';

class Eventtab extends StatefulWidget {
  const Eventtab({super.key});

  @override
  State<Eventtab> createState() => _EventtabState();
}

class _EventtabState extends State<Eventtab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Eventtab'),
      ),
    );
  }
}