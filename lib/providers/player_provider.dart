import 'package:flutter/foundation.dart';
import 'package:just_audio/just_audio.dart';
import 'package:spotify_clone/models/song_model.dart';
import 'package:spotify_clone/services/player_service.dart';

class PlayerProvider with ChangeNotifier {
  final PlayerService _playerService;
  Song? _currentSong;
  List<Song> _queue = [];
  PlayerState _playerState = PlayerState(false, ProcessingState.idle);

  PlayerProvider(this._playerService) {
    _init();
  }

  Future<void> _init() async {
    await _playerService.init();
    _playerService.playerStateStream.listen((state) {
      _playerState = state;
      notifyListeners();
    });
  }

  Song? get currentSong => _currentSong;
  List<Song> get queue => _queue;
  bool get isPlaying => _playerState.playing;
  Duration? get position => _playerState.position;
  Duration? get duration => _playerState.duration;

  Future<void> playSong(Song song) async {
    _currentSong = song;
    await _playerService.playSong(song);
    notifyListeners();
  }

  Future<void> playPlaylist(List<Song> songs, {int initialIndex = 0}) async {
    _queue = songs;
    _currentSong = songs[initialIndex];
    await _playerService.playPlaylist(songs);
    notifyListeners();
  }

  Future<void> togglePlayback() async {
    if (_playerState.playing) {
      await _playerService.pause();
    } else {
      await _playerService.resume();
    }
  }

  Future<void> seek(Duration position) async {
    await _playerService.seek(position);
  }

  Future<void> skipToNext() async {
    await _playerService.skipToNext();
    // Update current song from queue
    notifyListeners();
  }

  Future<void> skipToPrevious() async {
    await _playerService.skipToPrevious();
    // Update current song from queue
    notifyListeners();
  }
}