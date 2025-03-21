import 'package:coreia/src/core/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../data/local/skills.dart';
import '../../../screens.dart';
import '../scraping/sraping_screen.dart';

class IndexacionMainView extends StatelessWidget {
  const IndexacionMainView({
    super.key,
    required this.width,
    required TabController tabController,
  }) : _tabController = tabController;

  final double width;
  final TabController _tabController;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        color: const Color(0xFF1e1f1f),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: const Color(0xFF3a3a3b),
          width: 1,
        ),
      ),
      child: Column(
        // mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          IndexacionTabBar(
            width: width,
            tabController: _tabController,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
              child: TabBarView(
                controller: _tabController,
                children: [
                  const Center(
                    child: ScrapingScreen(),
                  ),
                  //! TAB BAR 1
                  SingleChildScrollView(
                    child: Column(
                      // mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Sobre El Proyecto'.toUpperCase(),
                          textAlign: TextAlign.right,
                          style: const TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        CustomDivider(width: width * 0.03),
                        const SizedBox(height: 20),
                        const IndexacionAboutMe(), // <-- About Me -->
                        const SizedBox(height: 20),
                        Text(
                          'Áreas de enfoque'.toUpperCase(),
                          style: const TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        CustomDivider(width: width * 0.03),
                        const SizedBox(height: 20),
                        IndexacionAreaOfFocus(
                          width: width,
                        ),
                        const SizedBox(height: 20),

                        Text(
                          'Stack Tecnologico'.toUpperCase(),
                          style: const TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        CustomDivider(width: width * 0.03),
                        const SizedBox(height: 20),
                        // PortfolioSkills(width: width),

                        SkillsContent(width: width)
                      ],
                    ),
                  ),
                  //! TAB BAR 2

                  const Center(
                    child: SummaryIndexacion(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SkillsContent extends StatelessWidget {
  const SkillsContent({
    super.key,
    required this.width,
  });

  final double width;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Wrap(
          spacing: 10,
          runSpacing: 10,
          children: List.generate(
            skills.length,
            (index) {
              return Container(
                width: Responsive.isMobile(context) ? width * 0.30 : width * 0.15,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color(0xFF3a3a3b),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.3),
                    width: 1,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.white.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    )
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      skills[index].image,
                      color: Colors.amber,
                      fit: BoxFit.contain,
                      width: 30,
                      height: 30,
                      semanticsLabel: skills[index].name,
                      placeholderBuilder: (BuildContext context) => const CircularProgressIndicator(),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      skills[index].name!,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              );
            },
          )),
    );
  }
}
