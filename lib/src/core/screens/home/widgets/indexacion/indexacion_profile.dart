import 'package:coreia/src/core/utils/responsive.dart';
import 'package:flutter/material.dart';

import 'profile/profile.dart';

class IndexacionProfile extends StatelessWidget {
  const IndexacionProfile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFF1E1F1F),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: const Color(0xFF3a3a3b),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.white.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 2),
          )
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        child: Responsive.isMobile(context)
            ? const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IndexacionImage(),
                  SizedBox(height: 10),
                  IndexacionName(),
                  SizedBox(height: 15),
                  IndexacionDescription(),
                  SizedBox(height: 20),
                  Divider(color: Color(0xFF3a3a3b), thickness: 3),
                  SizedBox(height: 20),
                  IndexacionRedes(),
                  SizedBox(height: 20),
                  IndexacionDoc(),
                ],
              )
            : LayoutBuilder(
                builder: (context, constraints) {
                  return SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: constraints.maxHeight,
                        // minWidth: constraints.maxWidth,
                      ),
                      child: const IntrinsicHeight(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IndexacionImage(),
                            SizedBox(height: 10),
                            IndexacionName(),
                            SizedBox(height: 15),
                            IndexacionDescription(),
                            SizedBox(height: 20),
                            Divider(color: Color(0xFF3a3a3b), thickness: 3),
                            SizedBox(height: 20),
                            IndexacionRedes(),
                            SizedBox(height: 20),
                            Expanded(
                              child: Align(
                                alignment: Alignment.bottomCenter,
                                child: IndexacionDoc(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
