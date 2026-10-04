import 'package:flutter/material.dart';
import '../data/music_data.dart';
import '../models/playlist.dart';

class LibraryScreen extends StatelessWidget {
  final Function(Playlist) onPlaylistTap;

  const LibraryScreen({
    super.key,
    required this.onPlaylistTap,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        backgroundColor: const Color(0xFF121212),
        title: const Text(
          'Your Library',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.add,
              color: Colors.white,
              size: 28,
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Wrap(
            spacing: 8,
            children: [
              Chip(
                label: Text('Playlists'),
                backgroundColor: Color(0xFF333333),
                labelStyle: TextStyle(color: Colors.white),
              ),
              Chip(
                label: Text('Artists'),
                backgroundColor: Color(0xFF333333),
                labelStyle: TextStyle(color: Colors.white),
              ),
              Chip(
                label: Text('Albums'),
                backgroundColor: Color(0xFF333333),
                labelStyle: TextStyle(color: Colors.white),
              ),
            ],
          ),
          const SizedBox(height: 20),
          ...playlists.map((playlist) {
            return ListTile(
              contentPadding: const EdgeInsets.symmetric(vertical: 5),
              onTap: () => onPlaylistTap(playlist),
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Image.network(
                  playlist.imageUrl,
                  width: 58,
                  height: 58,
                  fit: BoxFit.cover,
                ),
              ),
              title: Text(
                playlist.name,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                '${playlist.songs.length} songs',
                style: const TextStyle(color: Colors.white60),
              ),
              trailing: const Icon(
                Icons.more_vert,
                color: Colors.white70,
              ),
            );
          }),
        ],
      ),
    );
  }
}