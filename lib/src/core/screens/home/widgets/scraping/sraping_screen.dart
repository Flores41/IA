import 'package:cached_network_image/cached_network_image.dart';
import 'package:coreia/src/core/data/models/scraping_model.dart';
import 'package:coreia/src/core/provider/provider.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class ScrapingScreen extends StatefulWidget {
  const ScrapingScreen({super.key});

  @override
  ScrapingScreenState createState() => ScrapingScreenState();
}

class ScrapingScreenState extends State<ScrapingScreen> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => Provider.of<ScrapingProvider>(
        context,
        listen: false,
      ).fecthScrapingData(),
    );
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent * 0.8) {}
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ScrapingProvider>(context, listen: true);
    final categories = provider.getCategories();
    final genders = provider.getGenders();

    return Scaffold(
      backgroundColor: const Color(0xFF1e1f1f),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 20),
            child: Column(
              children: [
                Consumer<ScrapingProvider>(
                  builder: (context, value, child) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        onChanged: provider.updateSearchQuery,
                        decoration: const InputDecoration(
                          labelText: 'Buscar producto',
                          prefixIcon: Icon(Icons.search),
                          border: OutlineInputBorder(),
                        ),
                      ),
                    );
                  },
                ),
                // 📂 Filtro por género con ToggleButtons
                ToggleButtons(
                  isSelected: genders.map((g) => g == provider.selectedGender).toList(),
                  onPressed: (index) {
                    provider.updateGender(genders[index]);
                  },
                  borderRadius: BorderRadius.circular(10),
                  selectedColor: Colors.black,
                  fillColor: Colors.amber,
                  color: Colors.white,
                  children: genders
                      .map((g) => Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                            child: Text(g,
                                style: const TextStyle(
                                  fontSize: 16,
                                )),
                          ))
                      .toList(),
                ),
                const SizedBox(height: 20),

                // 📂 Filtro por categoría con ToggleButtons
                ScrollbarTheme(
                  data: ScrollbarThemeData(
                    thickness: MaterialStateProperty.all(6),
                    thumbColor: MaterialStateProperty.all(Colors.amber),
                  ),
                  child: Scrollbar(
                    controller: _scrollController,
                    radius: const Radius.circular(30),
                    child: SingleChildScrollView(
                      controller: _scrollController,
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      child: ToggleButtons(
                        isSelected: categories.map((c) => c == provider.selectedCategory).toList(),
                        onPressed: (index) {
                          provider.updateCategory(categories[index]);
                        },
                        borderRadius: BorderRadius.circular(10),
                        selectedColor: Colors.black,
                        fillColor: Colors.amber,
                        color: Colors.white,
                        children: categories.map((c) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                            child: Text(
                              c,
                              style: const TextStyle(fontSize: 16),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.64,
            child: provider.isLoading
                ? const Center(child: CircularProgressIndicator())
                : provider.allScrapingList.isEmpty
                    ? const Center(
                        child: Text("No hay productos disponibles."),
                      )
                    : GridView.builder(
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 5,
                          crossAxisSpacing: 10,
                          // childAspectRatio: 0.7,
                        ),
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        // physics: const NeverScrollableScrollPhysics(),
                        itemCount: provider.allScrapingList.length,
                        itemBuilder: (context, index) {
                          final item = provider.allScrapingList[index];
                          return Container(
                            margin: const EdgeInsets.all(8.0),
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
                            child: Center(
                              child: ListTile(
                                leading: Image.network(
                                  item.imagen,
                                  width: 50,
                                  height: 50,
                                  fit: BoxFit.cover,
                                  errorBuilder: (
                                    context,
                                    error,
                                    stackTrace,
                                  ) {
                                    return const Icon(
                                      Icons.image_not_supported,
                                      size: 50,
                                    );
                                  },
                                ),
                                title: Text(
                                  item.nombre.toUpperCase(),
                                  style:
                                      const TextStyle(fontWeight: FontWeight.bold, fontSize: 17, color: Colors.white),
                                ),
                                subtitle: Text(
                                  'Categoría: ${item.categoria} - Género: ${item.genero} - Color: ${item.color}',
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }
}

/// 📌 **Tarjeta del producto (se mantiene tu diseño)**
class ScrapingItemCard extends StatelessWidget {
  final ScrapingModel item;
  const ScrapingItemCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      width: 200,
      height: 300,
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
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: CachedNetworkImage(
              imageUrl: item.imagen,
              height: 200,
              width: 200,
              fit: BoxFit.cover,
              placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) => const Icon(Icons.error, color: Colors.red),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              item.nombre.toUpperCase(),
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.amber,
                borderRadius: BorderRadius.circular(6),
                border: Border.all(
                  color: Colors.black,
                  width: 2,
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
                padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 3),
                child: Text(
                  item.categoria.toUpperCase(),
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
