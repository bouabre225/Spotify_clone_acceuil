import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Spotify Clone',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF121212),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const SpotifyBottomNav(),
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.only(bottom: 140),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TopBar(),
                  SizedBox(height: 16),
                  ShortcutGrid(),
                  SizedBox(height: 30),
                  SectionTitle(title: "Albums avec des titres que vous aimez"),
                  AlbumHorizontalList(albums: likedAlbums),
                  SectionTitle(title: "Réécoutez vos favoris"),
                  AlbumHorizontalList(albums: favoriteAlbums),
                  SectionTitle(title: "Récemment écoutés"),
                  AlbumHorizontalList(albums: recentAlbums),
                  SectionTitle(title: "Albums par des artistes que vous suivez"),
                  AlbumHorizontalList(albums: followedArtistsAlbums),
                ],
              ),
            ),
            const MiniPlayer(),
          ],
        ),
      ),
    );
  }
}

class TopBar extends StatelessWidget {
  const TopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 18,
            backgroundColor: Colors.green,
            child: Icon(Icons.person, color: Colors.white),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: SizedBox(
              height: 40,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: const [
                  SpotifyChip("Tout", selected: true),
                  SpotifyChip("Wrapped"),
                  SpotifyChip("Musique"),
                  SpotifyChip("Podcasts"),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SpotifyChip extends StatelessWidget {
  const SpotifyChip(this.label, {super.key, this.selected = false});

  final String label;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 10),
      padding: EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: selected ? Colors.green : Colors.grey[800],
        borderRadius: BorderRadius.circular(20),
      ),
      alignment: Alignment.center,
      child: Text(label),
    );
  }
}

class ShortcutGrid extends StatelessWidget {
  const ShortcutGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Row(
            children: const [
              Expanded(child: ShortcutCard(title: "Titres likés")),
              SizedBox(width: 12),
              Expanded(child: ShortcutCard(title: "MALYA")),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: const [
              Expanded(child: ShortcutCard(title: "BĒYĀH")),
              SizedBox(width: 12),
              Expanded(child: ShortcutCard(title: "Panthéon")),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: const [
              Expanded(child: ShortcutCard(title: "J'ai menti")),
              SizedBox(width: 12),
              Expanded(child: ShortcutCard(title: "Quitte ou double")),
            ],
          ),
        ],
      ),
    );
  }
}

class ShortcutCard extends StatelessWidget {
  final String title;

  const ShortcutCard({required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      decoration: BoxDecoration(
        color: Colors.grey.shade800,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: const DecorationImage(image: AssetImage('assets/img.jpg')),
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  const SectionTitle({required this.title, super.key});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 12),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w700,
          letterSpacing: -0.2,
        ),
      ),
    );
  }
}

class AlbumCard extends StatelessWidget {
  final String title;
  final String artist;
  final String image;

  const AlbumCard({
    required this.title,
    required this.artist,
    required this.image,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: SizedBox(
        width: 140,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 140,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                image: DecorationImage(
                  image: AssetImage(image),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 2),
            Text(
              artist,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 12, color: Colors.white54),
            ),
          ],
        ),
      ),
    );
  }
}

class Album {
  final String title;
  final String artist;
  final String image;

  Album({required this.title, required this.artist, required this.image});
}

final likedAlbums = [
  Album(title: "BĒYĀH", artist: "Damso", image: "assets/beyah.jpg"),
  Album(title: "BĒYĀH", artist: "Damso", image: "assets/beyah.jpg"),
  Album(title: "QALF", artist: "Damso", image: "assets/qualf.jpg"),
  Album(title: "QALF", artist: "Damso", image: "assets/qualf.jpg"),
  Album(title: "Feu", artist: "Nekfeu", image: "assets/feu.jpg"),
  Album(title: "Feu", artist: "Nekfeu", image: "assets/feu.jpg"),
];

final recentAlbums = [
  Album(title: "QALF", artist: "Damso", image: "assets/qualf.jpg"),
  Album(title: "Saison 00", artist: "Kerchak", image: "assets/saison00.jpg"),
  Album(title: "Feu", artist: "Nekfeu", image: "assets/feu.jpg"),
  Album(title: "BĒYĀH", artist: "Damso", image: "assets/beyah.jpg"),
  Album(title: "La fête est finie", artist: "Orelsan", image: "assets/fete.jpg"),
];

final favoriteAlbums = [
  Album(title: "QALF", artist: "Damso", image: "assets/qualf.jpg"),
  Album(title: "Saison 00", artist: "Kerchak", image: "assets/saison00.jpg"),
  Album(title: "Feu", artist: "Nekfeu", image: "assets/feu.jpg"),
  Album(title: "BĒYĀH", artist: "Damso", image: "assets/beyah.jpg"),
  Album(title: "La fête est finie", artist: "Orelsan", image: "assets/fete.jpg"),
];

final followedArtistsAlbums = [
  Album(title: "Civilisation", artist: "Orelsan", image: "assets/Civilisation.jpg"),
  Album(title: "QALF", artist: "Damso", image: "assets/qualf.jpg"),
  Album(title: "Saison 00", artist: "Kerchak", image: "assets/saison00.jpg"),
  Album(title: "Feu", artist: "Nekfeu", image: "assets/feu.jpg"),
  Album(title: "BĒYĀH", artist: "Damso", image: "assets/beyah.jpg"),
  Album(title: "La fête est finie", artist: "Orelsan", image: "assets/fete.jpg"),
];

class AlbumHorizontalList extends StatelessWidget {
  final List<Album> albums;

  const AlbumHorizontalList({required this.albums, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 210,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: albums.length,
        separatorBuilder: (_, __) => const SizedBox(width: 16),
        itemBuilder: (context, index) {
          final album = albums[index];
          return AlbumCard(
            title: album.title,
            artist: album.artist,
            image: album.image,
          );
        },
      ),
    );
  }
}

class MiniPlayer extends StatelessWidget {
  const MiniPlayer({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 12,
      right: 12,
      bottom: 70, // au-dessus de la bottom bar
      child: GestureDetector(
        onTap: () {
          debugPrint("Open full player");
        },
        child: Container(
          height: 64,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: const Color(0xFF1DB954).withOpacity(0.9),
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.4),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              // Pochette
              ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: Image.asset(
                  'assets/img.jpg',
                  width: 48,
                  height: 48,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 12),

              // Titre + artiste
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "T'aimerais (feat. Ziak)",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      "Kerchak",
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),

              // Bouton play
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.play_arrow,
                  color: Colors.white,
                  size: 28,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class SpotifyBottomNav extends StatelessWidget {
  const SpotifyBottomNav({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.black,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white54,
      type: BottomNavigationBarType.fixed,
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Accueil"),
        BottomNavigationBarItem(icon: Icon(Icons.search), label: "Rechercher"),
        BottomNavigationBarItem(icon: Icon(Icons.library_music), label: "Bibliothèque"),
        BottomNavigationBarItem(icon: Icon(Icons.star), label: "Premium"),
        BottomNavigationBarItem(icon: Icon(Icons.add), label: "Créer"),
      ],
    );
  }
}
