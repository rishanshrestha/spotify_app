import 'package:just_audio/just_audio.dart';
import '../models/song.dart';

class AudioService {
  final AudioPlayer player = AudioPlayer();

  Future<void> playSong(Song song) async {
    await player.setUrl(song.audioUrl);
    await player.play();
  }

  Future<void> pause() async {
    await player.pause();
  }

  Future<void> resume() async {
    await player.play();
  }

  Future<void> seek(Duration position) async {
    await player.seek(position);
  }

  Future<void> stop() async {
    await player.stop();
  }

  Future<void> dispose() async {
    await player.dispose();
  }
}