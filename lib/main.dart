import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:spotify_clone/core/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await _initAudioService();
  runApp(const SpotifyClone());
}

Future<void> _initAudioService() async {
  await JustAudioBackground.init(
    androidNotificationChannelId: 'com.example.spotify_clone.channel.audio',
    androidNotificationChannelName: 'Audio playback',
    androidNotificationOngoing: true,
    androidStopForegroundOnPause: true,
  );
}

class SpotifyClone extends StatelessWidget {
  const SpotifyClone({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Spotify Clone',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      home: const App(),
    );
  }
}