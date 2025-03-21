import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coreia/src/core/data/models/scraping_model.dart';

class ScrapingRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<ScrapingModel>> getAllScrapingData() async {
    try {
      final hombreFuture = _firestore.collection('shombre').get();
      final mujerFuture = _firestore.collection('smujer').get();

      final results = await Future.wait([hombreFuture, mujerFuture]);

      List<ScrapingModel> scrapingList = [];

      for (var querysnapshot in results) {
        scrapingList.addAll(
          querysnapshot.docs.map(
            (e) => ScrapingModel.fromSnapshot(e),
          ),
        );
      }
      return scrapingList;
    } catch (e) {
      throw Exception('Error al obtener los datos: $e');
    }
  }
}
