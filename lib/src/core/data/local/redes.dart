class Redes {
  final String name;
  final String image;
  final String title;

  Redes({
    required this.name,
    required this.image,
    required this.title,
  });
}

final redes = <Redes>[
  Redes(
    name: 'Usuarios Activos',
    image: 'assets/img/git.svg',
    title: 'Metrica 1',
  ),
  Redes(
    name: 'Nº Outfits Recomendados',
    image: 'assets/img/twitter.svg',
    title: 'Metrica 2',
  ),
  Redes(
    name: 'Data Almacenada',
    image: 'assets/img/linkedin.svg',
    title: 'Metrica 3',
  ),
];
