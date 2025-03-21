import 'dart:developer';

import 'package:coreia/src/core/data/models/scraping_model.dart';
import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';


class GeminiProvider extends ChangeNotifier {
  // Define una clase llamada GeminiProvider que extiende ChangeNotifier para manejar notificaciones de cambios en el estado.

  final List<String> _chatHistory =
      []; // Lista privada para almacenar el historial de conversación.

  String _response =
      'Escribe un mensaje y presiona enviar'; // Variable privada para almacenar la última respuesta del modelo.

  bool isLoading =
      false; // Variable booleana para indicar si la IA está procesando una respuesta.

  final TextEditingController prompController =
      TextEditingController(); // Controlador de texto para manejar la entrada del usuario.

  String get response =>
      _response; // Getter para acceder a la respuesta más reciente.

  List<String> get chatHistory =>
      _chatHistory; // Getter para acceder al historial de conversación.

  final GenerativeModel _model = GenerativeModel(
    // Se crea una instancia del modelo generativo de Gemini con la API key.
    model: 'gemini-2.0-flash', // Se especifica el modelo de IA a utilizar.
    apiKey:
        'AIzaSyA0PkP6I-6U8Rob-i7_kJmKex6d3fePkDg', // Clave de la API para autenticación (¡Nunca compartas claves API en código público!).
  );

  Future<void> fecthChatResponse(
      String userPrompt, List<ScrapingModel> products) async {
    // Método asíncrono para obtener la respuesta del chat.
    try {
      isLoading =
          true; // Se establece isLoading en true para indicar que se está procesando una solicitud.
      notifyListeners(); // Se notifica a los oyentes del cambio de estado.

      _chatHistory.add(
          'Usuario: $userPrompt'); // Se añade el mensaje del usuario al historial.

      String productsList = products.map(
        // Se genera una lista formateada de los productos disponibles.
        (p) {
          return "- ${p.nombre} (${p.categoria}, ${p.genero}, ${p.color})\n  Imagen: ${p.imagen}"; // Se formatea cada producto con su nombre, categoría, género, color e imagen.
        },
      ).join(
          "\n"); // Se une toda la lista en una sola cadena separada por saltos de línea.
// Se construye el mensaje que se enviará a la IA, incluyendo productos y conversación previa.
// Se inserta la lista de productos disponibles.
// Se añade el historial de conversación para contexto.
// Se añade el mensaje actual del usuario.
      String enhancedPrompt = """
     Un usuario está buscando recomendaciones de outfit basadas en los siguientes productos disponibles:

     $productsList 

     Conversacion Anterior:
     ${_chatHistory.join('\n')} 

     Usuario: $userPrompt 
      Responde con una recomendación de outfit utilizando exclusivamente los productos listados arriba. 
      Indica claramente la recomendación y su justificación.
      Minimo unas 5 recomendaciones detalladas y explicadas y tambien puedes recomendar por tu cuenta

      **Formato de Respuesta:**
      **Recomendación:** [Aquí tu recomendación]
      **Imagen:** [URL de la imagen del producto recomendado]
 """;

      final content = [
        Content.text(enhancedPrompt)
      ]; // Se crea una lista con el mensaje estructurado para enviarlo a Gemini.

      final response = await _model.generateContent(
          content); // Se envía la solicitud a Gemini y se espera la respuesta.

      String geminiResponse = response.text ??
          'No se obtuvo respuesta de Gemini IA'; // Se obtiene la respuesta de Gemini o un mensaje de error si es nula.

      _chatHistory.add(
          'Gemini: $geminiResponse'); // Se agrega la respuesta de Gemini al historial.

      log(geminiResponse);

      _response =
          geminiResponse; // Se actualiza la variable con la respuesta obtenida.
    } catch (e) {
      // Captura errores en la ejecución.
      _response =
          'Error: $e'; // Guarda el mensaje de error en la variable de respuesta.
    } finally {
      // Bloque que se ejecuta siempre, haya o no error.
      isLoading =
          false; // Se establece isLoading en false porque la operación terminó.
      notifyListeners(); // Se notifica a los oyentes que el estado ha cambiado.
    }
  }
}
