import 'package:flutter/material.dart';

class IndexacionDoc extends StatelessWidget {
  const IndexacionDoc({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF3a3a3b),
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
            color: Colors.white.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 2),
          )
        ],
      ),
      child: ListTile(
        title: Text(
          'Documento'.toUpperCase(),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        trailing: const Icon(
          Icons.download_rounded,
          color: Colors.amber,
        ),
      ),
    );
  }
}
