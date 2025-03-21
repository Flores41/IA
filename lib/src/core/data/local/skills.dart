class Skills {
  final String? name;
  final String? description;
  final String image;

  Skills({
    required this.name,
    required this.description,
    required this.image,
  });
}

final skills = <Skills>[
  Skills(
    name: 'Flutter',
    description: 'Desarrollo de aplicaciones móviles',
    //URL DE INTERNET
    image: 'assets/img/flutter.svg',
  ),
  Skills(
    name: 'Dart',
    description: 'Lenguaje de programación',
    image: 'assets/img/dart.svg',
  ),
  Skills(
    name: 'Firebase',
    description: 'Base de datos en tiempo real',
    image: 'assets/img/firebase.svg',
  ),
  Skills(
    name: 'Github',
    description: 'Repositorio de proyectos',
    image: 'assets/img/git.svg',
  ),
  Skills(
    name: 'JavaScript',
    description: 'Lenguaje de programación',
    image: 'assets/img/js.svg',
  ),
  Skills(
    name: 'Gemini IA',
    description: 'Lenguaje de programación',
    image: 'assets/img/gemini.svg',
  ),
];
