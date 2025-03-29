import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:spotify_clone/models/song_model.dart';

class FirebaseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  // User Management
  User? get currentUser => _auth.currentUser;

  // Song Operations
  Future<List<Song>> getSongs() async {
    final snapshot = await _firestore.collection('songs').get();
    return snapshot.docs.map((doc) => Song.fromMap(doc.data())).toList();
  }

  Future<String> getSongUrl(String path) async {
    return await _storage.ref(path).getDownloadURL();
  }

  // Playlist Operations
  Future<void> addToPlaylist(String playlistId, String songId) async {
    await _firestore
        .collection('playlists')
        .doc(playlistId)
        .update({
          'songs': FieldValue.arrayUnion([songId])
        });
  }

  // User Data
  Future<Map<String, dynamic>> getUserData(String userId) async {
    final doc = await _firestore.collection('users').doc(userId).get();
    return doc.data() ?? {};
  }

  // Helper Methods
  DocumentReference get userRef => 
      _firestore.collection('users').doc(_auth.currentUser?.uid);
}