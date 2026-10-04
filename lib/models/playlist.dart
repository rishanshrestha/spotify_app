import 'song.dart';

class Playlist {
  final String id;
  final String name;
  final String description;
  final String imageUrl;
  final List<Song> songs;

  const Playlist({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.songs,
  });
}