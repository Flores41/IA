import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../data/data.dart';

class IndexacionRedes extends StatelessWidget {
  const IndexacionRedes({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Metricas Del Proyecto'.toUpperCase(),
          textAlign: TextAlign.left,
          style: const TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        Column(
            children: List.generate(
          redes.length,
          (index) {
            return ListTile(
              leading: Container(
                width: 50,
                height: 50,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color(0xFF3a3a3b),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.white.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    )
                  ],
                ),
                child: SvgPicture.asset(
                  redes[index].image,
                  width: 40,
                  height: 40,
                  color: Colors.amber,
                ),
              ),
              title: Text(
                redes[index].name.toUpperCase(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                redes[index].title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                ),
              ),
            );
          },
        )),
      ],
    );
  }
}
