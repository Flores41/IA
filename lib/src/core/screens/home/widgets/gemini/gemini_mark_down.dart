import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class GeminiMarkdown extends StatelessWidget {
  final String markdownText;

  const GeminiMarkdown({super.key, required this.markdownText});

  @override
  Widget build(BuildContext context) {
    return MarkdownBody(
      data: markdownText.isNotEmpty ? markdownText : '',
      selectable: true, // Permite que el usuario seleccione el texto
      styleSheet: MarkdownStyleSheet(
        p: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w400,
          fontSize: 18,
          height: 1.5,
        ),
        h1: const TextStyle(
          color: Colors.amber,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
        h2: const TextStyle(
          color: Colors.amber,
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
        h3: const TextStyle(
          color: Colors.amber,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
        blockquote: const TextStyle(
          color: Colors.white10,
        ),
        code: const TextStyle(
          color: Colors.orangeAccent,
          fontSize: 14,
        ),
        codeblockDecoration: BoxDecoration(
          color: Colors.black54,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.white30),
        ),
        listBullet: const TextStyle(color: Colors.white, fontSize: 16),
        strong:
            const TextStyle(color: Colors.amber, fontWeight: FontWeight.bold),
        em: const TextStyle(color: Colors.amber, fontStyle: FontStyle.italic),
        a: const TextStyle(
          color: Colors.blueAccent,
          decoration: TextDecoration.underline,
        ),
      ),
      // onTapLink: (text, url, title) {
      //   if (url != null) {
      //     _launchURL(url);
      //   }
      // },
    );
  }

  // void _launchURL(String url) async {
  //   final Uri uri = Uri.parse(url);
  //   if (await canLaunchUrl(uri)) {
  //     await launchUrl(uri, mode: LaunchMode.externalApplication);
  //   } else {
  //     debugPrint("No se pudo abrir el enlace: $url");
  //   }
  // }
}
