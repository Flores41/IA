class Enfoque {
  final String name;
  final String description;
  final String image;

  Enfoque({
    required this.name,
    required this.description,
    required this.image,
  });
}

final enfoque = <Enfoque>[
  Enfoque(
    name: 'Recomendaciones con IA',
    description:
        'Utilización de Gemini IA para generar recomendaciones de outfits personalizadas, analizando preferencias del usuario y tendencias en tiempo real.',
    image: 'assets/img/ia.svg',
  ),
  Enfoque(
    name: 'Indexación de Datos Eficiente',
    description:
        'Implementación de técnicas avanzadas de indexación de datos para optimizar la búsqueda y recuperación de información en Firestore.',
    image: 'assets/img/data.svg',
  ),
  Enfoque(
    name: 'Almacenamiento Escalable en Firestore',
    description:
        'Uso de Firestore para gestionar datos de usuarios y outfits en tiempo real, garantizando escalabilidad y eficiencia en la plataforma.',
    image: 'assets/img/firebase.svg',
  ),
  Enfoque(
    name: 'Desarrollo con Flutter',
    description:
        'Construcción de una plataforma multiplataforma con Flutter, asegurando un diseño intuitivo, responsivo y optimizado para dispositivos móviles y web.',
    image: 'assets/img/flutter.svg',
  ),
  Enfoque(
    name: 'Experiencia de Usuario Optimizada',
    description:
        'Diseño UI/UX centrado en la facilidad de navegación y personalización, brindando una experiencia fluida en la elección de outfits.',
    image: 'assets/img/ui.svg',
  ),
  Enfoque(
    name: 'Obtención de Datos con Web Scraping',
    description:
        'Extracción automatizada de datos de moda desde fuentes web para enriquecer las recomendaciones y mantenerse alineado con las tendencias actuales.',
    image: 'assets/img/inde.svg',
  ),
  Enfoque(
    name: 'Evaluación y Mejora Continua',
    description:
        'Implementación de métricas para medir la precisión y satisfacción del usuario, mejorando el modelo de recomendación con análisis de datos.',
    image: 'assets/img/mejora.svg',
  ),
];
