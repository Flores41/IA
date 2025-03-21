import 'package:coreia/src/core/data/data.dart';
import 'package:coreia/src/core/provider/provider.dart';
import 'package:coreia/src/core/screens/home/widgets/gemini/gemini_mark_down.dart';
import 'package:coreia/src/core/utils/colors.dart';
import 'package:coreia/src/core/utils/responsive.dart';
import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';

import 'package:provider/provider.dart';

import 'widgets/widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  //Tab Controller
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color(0xFF101011),
      body: Center(
        child: Container(
          margin: Responsive.isMobile(context)
              ? const EdgeInsets.only(left: 20, right: 20, bottom: 0, top: 40)
              : const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
          width: Responsive.isMobile(context) ? width : width * 0.8,
          child: Responsive.isMobile(context)
              ? SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      const IndexacionProfile(),
                      const SizedBox(height: 20),
                      IndexacionMainView(
                        width: width,
                        tabController: _tabController,
                      ),
                    ],
                  ),
                )
              : Row(
                  children: [
                    const Expanded(
                      flex: 1,
                      child: IndexacionProfile(),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      flex: 3,
                      child: IndexacionMainView(
                        width: width,
                        tabController: _tabController,
                      ),
                    )
                  ],
                ),
        ),
      ),
    );
  }
}

class SummaryIndexacion extends StatefulWidget {
  const SummaryIndexacion({super.key});

  @override
  State<SummaryIndexacion> createState() => _SummaryIndexacionState();
}

class _SummaryIndexacionState extends State<SummaryIndexacion> {
  // late TextEditingController controller;
  final TextEditingController _messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final scrapingProvider = Provider.of<ScrapingProvider>(context, listen: false);
    scrapingProvider.getCategories();
    scrapingProvider.getGenders();
  }

  @override
  void dispose() {
    _messageController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final geminiProvider = context.read<GeminiProvider>();
    final provider = Provider.of<ScrapingProvider>(context);

    final width = context.width;
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 10.0),
        child: Consumer<GeminiProvider>(
          builder: (context, value, child) {
            return SingleChildScrollView(
              child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
                const SizedBox(
                  height: 20,
                ),
                Text(
                  '¿En qué puedo ayudarte?'.toUpperCase(),
                  style: const TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
                ),
                CustomDivider(width: width * 0.05),
                const SizedBox(
                  height: 20,
                ),
                Center(
                  child: Container(
                    width: width * 0.4,
                    decoration: BoxDecoration(
                      color: const Color(0xFF3a3a3b),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.white.withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 2),
                        )
                      ],
                    ),
                    child: TextFormField(
                      // onFieldSubmitted: (value) {
                      //   final geminiProvider =
                      //       context.read<GeminiProvider>();
                      //   geminiProvider.fetchGemini(value);
                      // },
                      controller: _messageController,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.only(top: 40, bottom: 40, left: 20, right: 20),
                        filled: true,
                        fillColor: const Color(0xFF3a3a3b),
                        hintStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
                        hintText: 'Envia Un Mensaje a ...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: const BorderSide(color: Color(0xFF3a3a3b)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: const BorderSide(color: Color(0xFF3a3a3b)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: const BorderSide(color: Color(0xFF3a3a3b)),
                        ),
                        hoverColor: const Color(0xFF3a3a3b),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1e1f1f),
                    shadowColor: const Color(0xFF1e1f1f),
                    elevation: 0,
                  ),
                  onPressed: () {
                    final mesage = _messageController.text.trim();
                    final provider = Provider.of<ScrapingProvider>(context, listen: false);
                    if (mesage.isNotEmpty) {
                      provider.sendPromptToGemini(mesage);
                      _messageController.clear();
                    }
                  },
                  child: const Text(''),
                ),
                geminiProvider.isLoading
                    ? const CircularProgressIndicator(
                        backgroundColor: Colors.amber,
                      )
                    : const SizedBox(),
                const SizedBox(
                  height: 20,
                ),

                //! HISTORIAL DEL CHAT

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 650, // Espacio para la conversación
                    decoration: BoxDecoration(
                      // border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListView.builder(
                      // controller: _chatScrollController,
                      padding: const EdgeInsets.all(10),
                      itemCount: provider.chatHistory.length,
                      itemBuilder: (context, index) {
                        final message = provider.chatHistory[index];
                        final isUserMessage = message.startsWith("Usuario:");

                        return Align(
                          alignment: isUserMessage ? Alignment.centerRight : Alignment.centerLeft,
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            margin: const EdgeInsets.symmetric(vertical: 5),
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
                            child: GeminiMarkdown(
                              markdownText: message.replaceFirst(
                                RegExp(r'Usuario: |Gemini: '),
                                '',
                              ),
                            ),
                            //  Markdown(
                            //   message.replaceFirst(
                            //     RegExp(r'Usuario: |Gemini: '),
                            //     '',
                            //   ),
                            //   style: TextStyle(
                            //       fontSize: 14,
                            //       color: isUserMessage
                            //           ? Colors.black
                            //           : Colors.black),
                            // ),
                          ),
                        );
                      },
                    ),
                  ),
                ),

                // GeminiMarkdown(
                //   markdownText: geminiProvider.response,
                // ),
              ]),
            );
          },
        ),
      ),
    );
  }
}

class IndexacionAboutMe extends StatelessWidget {
  const IndexacionAboutMe({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Text(
      'Este proyecto consiste en un sistema de recomendación de outfits basado en Gemini IA y datos almacenados en Firestore. Utiliza técnicas de indexación de datos y aprendizaje automático para analizar preferencias de los usuarios y sugerir combinaciones de ropa personalizadas en tiempo real. \n \n La plataforma está desarrollada en Flutter, garantizando una experiencia intuitiva y optimizada en múltiples dispositivos. Con este enfoque, se busca mejorar la experiencia de usuario en la selección de outfits, reduciendo el tiempo de búsqueda y ofreciendo recomendaciones precisas basadas en tendencias y datos almacenados.',
      style: TextStyle(
        color: Colors.white,
        fontSize: 16,
      ),
    );
  }
}

class IndexacionAreaOfFocus extends StatelessWidget {
  const IndexacionAreaOfFocus({
    super.key,
    required this.width,
  });

  final double width;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Responsive.isMobile(context)
          ? Column(
              children: focusAreaContent(context),
            )
          : Wrap(
              // alignment: WrapAlignment.center,
              spacing: 10,
              runSpacing: 10,
              children: focusAreaContent(context),
            ),
    );
  }

  List<Widget> focusAreaContent(BuildContext context) {
    return List.generate(
      enfoque.length,
      (index) {
        return Container(
          margin: Responsive.isMobile(context)
              ? const EdgeInsets.symmetric(vertical: 10, horizontal: 0)
              : const EdgeInsets.all(0),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          width: Responsive.isMobile(context) ? width : width * 0.25,
          // height: width * 0.15,
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
                blurRadius: 12,
                offset: const Offset(0, 1),
              )
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    // margin: const EdgeInsets.all(10),
                    width: 50,
                    height: 50,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: const Color(0xFF3a3a3b),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.5),
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
                    // child: Image.network(
                    //   enfoque[index].image,
                    //   fit: BoxFit.contain,
                    //   color: Colors.amber,
                    //   width: 30,
                    //   height: 30,
                    // )
                    child: SvgPicture.asset(
                      enfoque[index].image,
                      color: Colors.amber,
                      fit: BoxFit.contain,
                      width: 30,
                      height: 30,
                      semanticsLabel: enfoque[index].name,
                      placeholderBuilder: (BuildContext context) => const CircularProgressIndicator(),
                    ),
                  ),
                  const SizedBox(width: 10),
                  SizedBox(
                    width: width * 0.16,
                    child: Text(
                      enfoque[index].name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Text(
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                enfoque[index].description,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class IndexacionTabBar extends StatelessWidget {
  const IndexacionTabBar({
    super.key,
    required this.width,
    required TabController tabController,
  }) : _tabController = tabController;

  final double width;
  final TabController _tabController;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Responsive.isMobile(context) ? width : width * 0.3,
      decoration: const BoxDecoration(
        color: Color(0xFF3a3a3b),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(15),
          topRight: Radius.circular(10),
        ),
      ),
      child: TabBar(
        controller: _tabController,
        splashBorderRadius: BorderRadius.circular(10),
        indicatorColor: Colors.amber,
        indicatorSize: TabBarIndicatorSize.tab,
        indicatorWeight: 3,
        labelColor: Colors.amber,
        unselectedLabelColor: Colors.white.withOpacity(0.3),
        mouseCursor: SystemMouseCursors.click,
        tabs: [
          Tab(
              child: Text(
            'Scraping'.toUpperCase(),
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          )),
          Tab(
            child: Text(
              'Resumen'.toUpperCase(),
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Tab(
              child: Text(
            'Gemini'.toUpperCase(),
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          )),
        ],
      ),
    );
  }
}

class CustomDivider extends StatelessWidget {
  const CustomDivider({
    super.key,
    required this.width,
  });

  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.amber,
            width: 4,
          ),
        ),
      ),
    );
  }
}
