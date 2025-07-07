/// Audiobook data model with duration for realistic playback UI.
/// Ensure audioUrl points to a public MP3 for testing/demo.
class Audiobook {
  /// Unique identifier for the audiobook.
  final String id;

  /// Title of the audiobook.
  final String title;

  /// Author
  final String author;

  /// Cover image URL.
  final String coverUrl;

  /// URL to a sample audio.
  final String sampleUrl;

  /// URL to the full (purchased) audio.
  final String audioUrl;

  /// Price of the audiobook.
  final double price;

  /// Description of the audiobook.
  final String description;

  /// Realistic total duration in seconds (required for progress bar).
  final int durationSeconds;

  // PUBLIC_INTERFACE
  Audiobook({
    required this.id,
    required this.title,
    required this.author,
    required this.coverUrl,
    required this.sampleUrl,
    required this.audioUrl,
    required this.price,
    required this.description,
    required this.durationSeconds,
  });

  // PUBLIC_INTERFACE
  factory Audiobook.fromJson(Map<String, dynamic> json) {
    return Audiobook(
      id: json['id'],
      title: json['title'],
      author: json['author'],
      coverUrl: json['coverUrl'],
      sampleUrl: json['sampleUrl'],
      audioUrl: json['audioUrl'] ??
          "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3",
      price: (json['price'] as num).toDouble(),
      description: json['description'],
      durationSeconds: json['durationSeconds'] ??
          3600, // Default to 1 hour if missing for robustness
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'author': author,
        'coverUrl': coverUrl,
        'sampleUrl': sampleUrl,
        'audioUrl': audioUrl,
        'price': price,
        'description': description,
        'durationSeconds': durationSeconds,
      };

  /// Demo audiobook data with explicit durations and provided cover images.
  /// NOTE: This list is **NOT** actually used in the store or library UI. See AppState for real data used by the app.
  static List<Audiobook> dummyAudiobooks = [
    Audiobook(
      id: '1',
      title: 'Little Women',
      author: 'Louisa May Alcott',
      coverUrl: 'https://th.bing.com/th/id/R.c6fb60a8438cb54090b80ddfc64f7b33?rik=lyBTAyPlRmP1Ow&pid=ImgRaw&r=0',
      sampleUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3',
      audioUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3',
      price: 9.99,
      description: 'A timeless classic that follows the lives of the four March sisters as they grow up in post–Civil War America.',
      durationSeconds: 63000, // 17h30m
    ),
    Audiobook(
      id: '2',
      title: 'Jane Eyre',
      author: 'Charlotte Brontë',
      coverUrl: 'https://tse2.mm.bing.net/th/id/OIP.4cds9Zoth2Vd-XkBxV5HMQHaLE?rs=1&pid=ImgDetMain&o=7&rm=3',
      sampleUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-2.mp3',
      audioUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-2.mp3',
      price: 11.99,
      description: 'A coming-of-age novel following the orphaned Jane as she faces life’s hardships and searches for love and belonging.',
      durationSeconds: 69300, // 19h15m
    ),
    Audiobook(
      id: '3',
      title: 'Sherlock Holmes',
      author: 'Arthur Conan Doyle',
      coverUrl: 'https://tu.tv/wp-content/uploads/2019/09/the-adventures-of-sherlock-pdf-download.jpg',
      sampleUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-3.mp3',
      audioUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-3.mp3',
      price: 7.99,
      description: 'Join the world-famous detective Sherlock Holmes and his partner Watson in their thrilling adventures across London.',
      durationSeconds: 28200, // 7h50m
    ),
    Audiobook(
      id: '4',
      title: 'Frankenstein',
      author: 'Mary Shelley',
      coverUrl: 'https://tse2.mm.bing.net/th/id/OIP.hsX0irlDM_aMa-2bLl9ntAHaLH?rs=1&pid=ImgDetMain&o=7&rm=3',
      sampleUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-4.mp3',
      audioUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-4.mp3',
      price: 8.99,
      description: 'The chilling story of Dr. Frankenstein and his creation that explores themes of life, science, and responsibility.',
      durationSeconds: 30600, // 8h30m
    ),
    Audiobook(
      id: '5',
      title: 'To Kill a Mockingbird',
      author: 'Harper Lee',
      coverUrl: 'https://upload.wikimedia.org/wikipedia/commons/thumb/4/4f/To_Kill_a_Mockingbird_(first_edition_cover).jpg/440px-To_Kill_a_Mockingbird_(first_edition_cover).jpg',
      sampleUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-5.mp3',
      audioUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-5.mp3',
      price: 10.99,
      description: 'A classic novel of race, injustice, and moral growth in the Deep South, seen through the eyes of young Scout Finch.',
      durationSeconds: 44700, // 12h25m
    ),
    Audiobook(
      id: '6',
      title: 'War and Peace',
      author: 'Leo Tolstoy',
      coverUrl: 'https://bookshopnews.com/wp-content/uploads/2024/03/War-and-Peace.jpg',
      sampleUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-6.mp3',
      audioUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-6.mp3',
      price: 14.99,
      description: 'A sweeping historical epic set against the backdrop of Russia during the Napoleonic era.',
      durationSeconds: 219600, // 61h00m
    ),
    Audiobook(
      id: '7',
      title: 'The Odyssey',
      author: 'Homer',
      coverUrl: 'https://lythrumpress.com.au/media/2024/10/Artemis-76.webp',
      sampleUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-7.mp3',
      audioUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-7.mp3',
      price: 9.99,
      description: 'The legendary tale of Odysseus’s ten-year journey home after the Trojan War—one of the most important works of Western literature.',
      durationSeconds: 41700, // 11h35m
    ),
    Audiobook(
      id: '8',
      title: 'The Grapes of Wrath',
      author: 'John Steinbeck',
      coverUrl: 'https://th.bing.com/th/id/R.96459894576b2ab3ac2901b9345a8d22?rik=9vNewSGrVVKcMQ&pid=ImgRaw&r=0',
      sampleUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-8.mp3',
      audioUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-8.mp3',
      price: 12.49,
      description: 'An American masterpiece chronicling the struggles of the Joad family during the Great Depression.',
      durationSeconds: 76500, // 21h15m
    ),
  ];
}
