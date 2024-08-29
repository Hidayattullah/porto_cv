import 'package:flutter/material.dart';

class HomeSec extends StatelessWidget {
  const HomeSec({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.yellow,
      height: MediaQuery.of(context).size.height,
      child: const Center(
        child: Text('Home Section', 
        style: TextStyle(
          color: Colors.white, fontSize: 24
          )
        )
      ),
    );
  }
}
