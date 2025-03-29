import 'package:spotify_clone/models/song_model.dart';

class SampleDataService {
  static List<Song> getSampleSongs() {
    return [
      Song(
        id: '1',
        title: 'Blinding Lights',
        artist: 'The Weeknd',
        album: 'After Hours',
        coverUrl: 'https://i.scdn.co/image/ab67616d0000b2738863bc11d2aa12b54f5aeb36',
        audioUrl: 'https://example.com/audio1.mp3',
        duration: const Duration(minutes: 3, seconds: 20),
      ),
      Song(
        id: '2',
        title: 'Save Your Tears',
        artist: 'The Weeknd',
        album: 'After Hours',
        coverUrl: 'https://i.scdn.co/image/ab67616d0000b2738863bc11d2aa12b54f5aeb36',
        audioUrl: 'https://example.com/audio2.mp3',
        duration: const Duration(minutes: 3, seconds: 35),
      ),
      Song(
        id: '3',
        title: 'Starboy',
        artist: 'The Weeknd, Daft Punk',
        album: 'Starboy',
        coverUrl: 'https://i.scdn.co/image/ab67616d0000b273e13de7b8662b085b0885ff0f',
        audioUrl: 'https://example.com/audio3.mp3',
        duration: const Duration(minutes: 3, seconds: 50),
      ),
    ];
  }

  static List<Song> getFeaturedPlaylists() {
    return [
      Song(
        id: '4',
        title: 'Today\'s Top Hits',
        artist: 'Various Artists',
        album: 'Playlist',
        coverUrl: 'https://i.scdn.co/image/ab67706f00000002b0fe40a6e1692822f5a9d8f1',
        audioUrl: 'https://example.com/playlist1.mp3',
        duration: const Duration(hours: 1, minutes: 30),
      ),
      Song(
        id: '5',
        title: 'RapCaviar',
        artist: 'Various Artists',
        album: 'Playlist',
        coverUrl: 'https://i.scdn.co/image/ab67706f00000002a980b152e708667c9388e1e1',
        audioUrl: 'https://example.com/playlist2.mp3',
        duration: const Duration(hours: 2, minutes: 15),
      ),
    ];
  }
}