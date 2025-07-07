class Audiobook {
  final String title;
  final String author;
  final String coverUrl;
  final double price;
  final String description;

  Audiobook({
    required this.title,
    required this.author,
    required this.coverUrl,
    required this.price,
    required this.description,
  });
}

class AppState {
  final List<Audiobook> audiobooks = [
    Audiobook(
      title: 'The Hobbit',
      author: 'J.R.R. Tolkien',
      coverUrl: 'https://covers.openlibrary.org/b/id/10313311-L.jpg',
      price: 19.99,
      description: 'A great fantasy book.'
    ),
    Audiobook(
      title: 'The Fellowship of the Ring',
      author: 'J.R.R. Tolkien',
      coverUrl: 'https://covers.openlibrary.org/b/id/10309999-L.jpg',
      price: 24.99,
      description: 'The first book in The Lord of the Rings trilogy.'
    ),
    Audiobook(
      title: 'The Two Towers',
      author: 'J.R.R. Tolkien',
      coverUrl: 'https://covers.openlibrary.org/b/id/10310001-L.jpg',
      price: 24.99,
      description: 'The second book in The Lord of the Rings trilogy.'
    ),
    Audiobook(
      title: 'The Return of the King',
      author: 'J.R.R. Tolkien',
      coverUrl: 'https://covers.openlibrary.org/b/id/10310002-L.jpg',
      price: 24.99,
      description: 'The third book in The Lord of the Rings trilogy.'
    ),
    Audiobook(
      title: 'A Game of Thrones',
      author: 'George R. R. Martin',
      coverUrl: 'https://covers.openlibrary.org/b/id/10579848-L.jpg',
      price: 29.99,
      description: 'The first book in A Song of Ice and Fire.'
    ),
    Audiobook(
      title: 'A Clash of Kings',
      author: 'George R. R. Martin',
      coverUrl: 'https://covers.openlibrary.org/b/id/10579849-L.jpg',
      price: 29.99,
      description: 'The second book in A Song of Ice and Fire.'
    ),
    Audiobook(
      title: 'A Storm of Swords',
      author: 'George R. R. Martin',
      coverUrl: 'https://covers.openlibrary.org/b/id/10579850-L.jpg',
      price: 29.99,
      description: 'The third book in A Song of Ice and Fire.'
    ),
    Audiobook(
      title: 'A Feast for Crows',
      author: 'George R. R. Martin',
      coverUrl: 'https://covers.openlibrary.org/b/id/10579851-L.jpg',
      price: 29.99,
      description: 'The fourth book in A Song of Ice and Fire.'
    ),
    Audiobook(
      title: 'A Dance with Dragons',
      author: 'George R. R. Martin',
      coverUrl: 'https://covers.openlibrary.org/b/id/10579852-L.jpg',
      price: 29.99,
      description: 'The fifth book in A Song of Ice and Fire.'
    ),
    Audiobook(
      title: 'The Name of the Wind',
      author: 'Patrick Rothfuss',
      coverUrl: 'https://covers.openlibrary.org/b/id/10034222-L.jpg',
      price: 22.99,
      description: 'The first book in The Kingkiller Chronicle.'
    ),
     Audiobook(
      title: 'The Wise Man\'s Fear',
      author: 'Patrick Rothfuss',
      coverUrl: 'https://covers.openlibrary.org/b/id/8259779-L.jpg',
      price: 24.99,
      description: 'The second book in The Kingkiller Chronicle.'
    ),
    Audiobook(
      title: 'Mistborn: The Final Empire',
      author: 'Brandon Sanderson',
      coverUrl: 'https://covers.openlibrary.org/b/id/10440316-L.jpg',
      price: 26.99,
      description: 'The first book in the Mistborn series.'
    ),
     Audiobook(
      title: 'The Way of Kings',
      author: 'Brandon Sanderson',
      coverUrl: 'https://covers.openlibrary.org/b/id/10440318-L.jpg',
      price: 32.99,
      description: 'The first book in The Stormlight Archive.'
    ),
     Audiobook(
      title: 'Words of Radiance',
      author: 'Brandon Sanderson',
      coverUrl: 'https://covers.openlibrary.org/b/id/10440319-L.jpg',
      price: 32.99,
      description: 'The second book in The Stormlight Archive.'
    ),
  ];
}
