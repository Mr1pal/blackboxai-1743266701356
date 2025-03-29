import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:spotify_clone/models/song_model.dart';

class PlayerService {
  final AudioPlayer _audioPlayer = AudioPlayer();
  final ConcatenatingAudioSource _playlist = ConcatenatingAudioSource(children: []);

  Future<void> init() async {
    await _audioPlayer.setLoopMode(LoopMode.off);
    await _audioPlayer.setAudioSource(_playlist);
  }

  Future<void> playSong(Song song) async {
    try {
      await _playlist.clear();
      await _playlist.add(AudioSource.uri(
        Uri.parse(song.audioUrl),
        tag: MediaItem(
          id: song.id,
          title: song.title,
          artist: song.artist,
          album: song.album,
          artUri: Uri.parse(song.coverUrl),
        ),
      ));
      await _audioPlayer.seek(Duration.zero);
      await _audioPlayer.play();
    } catch (e) {
      throw Exception('Failed to play song: ${e.toString()}');
    }
  }

  Future<void> playPlaylist(List<Song> songs) async {
    try {
      await _playlist.clear();
      await _playlist.addAll(
        songs.map((song) => AudioSource.uri(Uri.parse(song.audioUrl))).toList()
      );
      await _audioPlayer.seek(Duration.zero);
      await _audioPlayer.play();
    } catch (e) {
      throw Exception('Failed to play playlist: ${e.toString()}');
    }
  }

  Future<void> pause() => _audioPlayer.pause();
  Future<void> resume() => _audioPlayer.play();
  Future<void> stop() => _audioPlayer.stop();
  Future<void> seek(Duration position) => _audioPlayer.seek(position);
  Future<void> skipToNext() => _audioPlayer.seekToNext();
  Future<void> skipToPrevious() => _audioPlayer.seekToPrevious();

  Stream<Duration> get positionStream => _audioPlayer.positionStream;
  Stream<Duration?> get durationStream => _audioPlayer.durationStream;
  Stream<PlayerState> get playerStateStream => _audioPlayer.playerStateStream;
  Stream<bool> get isPlayingStream => _audioPlayer.playingStream;
}