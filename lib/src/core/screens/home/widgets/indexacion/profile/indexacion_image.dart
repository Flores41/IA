import 'package:flutter/material.dart';

class IndexacionImage extends StatelessWidget {
  const IndexacionImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 240,
        height: 240,
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Image.asset(
          'assets/img/dash.png',
          fit: BoxFit.contain,
          width: 150,
          height: 150,
        ));
  }
}
