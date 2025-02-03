import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../auth/auth_exports.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: TextButton(
            child: Text("Home Page"),
            onPressed: () {
              Provider.of<AuthServices>(context, listen: false).logout(context);
            }));
  }
}
