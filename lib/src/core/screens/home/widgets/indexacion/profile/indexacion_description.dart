import 'package:flutter/material.dart';

class IndexacionDescription extends StatelessWidget {
  const IndexacionDescription({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(7),
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
      child: const Text(
        'Recomendaciones de outfits con Gemini IA y Firestore, adaptadas a tu estilo en tiempo real.',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
          // fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    );
  }
}
