import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spotify_clone/models/song_model.dart';
import 'package:spotify_clone/providers/auth_provider.dart';
import 'package:spotify_clone/providers/player_provider.dart';
import 'package:spotify_clone/widgets/now_playing_bar.dart';
import 'package:spotify_clone/widgets/playlist_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final List<Song> _recentSongs;
  late final List<Song> _featuredPlaylists;

  @override
  void initState() {
    super.initState();
    _recentSongs = SampleDataService.getSampleSongs();
    _featuredPlaylists = SampleDataService.getFeaturedPlaylists();
  }

  @override
  Widget build(BuildContext context) {
    final playerProvider = Provider.of<PlayerProvider>(context);

    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Home'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => Provider.of<AuthProvider>(context, listen: false).signOut(),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Good afternoon',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    childAspectRatio: 2.5,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    children: _featuredPlaylists.map((playlist) {
                      return GestureDetector(
                        onTap: () => playerProvider.playPlaylist(_featuredPlaylists),
                        child: PlaylistCard(
                          title: playlist.title,
                          color: const Color(0xFF1DB954),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 30),
                  const Text(
                    'Recently played',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 200,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: _recentSongs.length,
                      itemBuilder: (context, index) {
                        final song = _recentSongs[index];
                        return Padding(
                          padding: const EdgeInsets.only(right: 16.0),
                          child: GestureDetector(
                            onTap: () => playerProvider.playSong(song),
                            child: PlaylistCard(
                              title: song.title,
                              color: Colors.blue,
                              width: 150,
                              height: 200,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          const NowPlayingBar(),
        ],
      ),
    );
  }
}