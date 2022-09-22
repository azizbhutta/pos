import 'package:flutter/material.dart';

class HelloScreen extends StatefulWidget {
  const HelloScreen({Key? key}) : super(key: key);

  @override
  State<HelloScreen> createState() => _HelloScreenState();
}

class _HelloScreenState extends State<HelloScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              height: 300,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(120), bottomRight: Radius.circular(120)),
              )
            ),
            // Container(
            //     height: 370,
            //     width: MediaQuery.of(context).size.width,
            //     decoration: BoxDecoration(
            //       color: Colors.orange.shade600,
            //       borderRadius: BorderRadius.only(bottomLeft: Radius.circular(120), bottomRight: Radius.circular(120)),
            //     )
            // )
          ],
        ),
      ),
    );
  }
}
