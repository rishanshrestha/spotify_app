import 'package:flutter/material.dart';
import '../data/music_data.dart';
import '../models/song.dart';
import '../widgets/song_tile.dart';

class SearchScreen extends StatefulWidget {
  final Function(Song) onSongTap;

  const SearchScreen({
    super.key,
    required this.onSongTap,
  });

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController controller = TextEditingController();
  String searchQuery = '';

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filteredSongs = songs.where((song) {
      return song.title.toLowerCase().contains(
            searchQuery.toLowerCase(),
          ) ||
          song.artist.toLowerCase().contains(
            searchQuery.toLowerCase(),
          );
    }).toList();

    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        backgroundColor: const Color(0xFF121212),
        title: const Text(
          'Search',
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: controller,
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
              style: const TextStyle(color: Colors.black),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: 'What do you want to play?',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: IconButton(
                  onPressed: () {
                    controller.clear();
                    setState(() {
                      searchQuery = '';
                    });
                  },
                  icon: const Icon(Icons.close),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          Expanded(
            child: searchQuery.isEmpty
                ? const Center(
                    child: Text(
                      'Search for your favorite songs',
                      style: TextStyle(color: Colors.white70),
                    ),
                  )
                : filteredSongs.isEmpty
                    ? const Center(
                        child: Text(
                          'No songs found',
                          style: TextStyle(color: Colors.white70),
                        ),
                      )
                    : ListView.builder(
                        itemCount: filteredSongs.length,
                        itemBuilder: (context, index) {
                          final song = filteredSongs[index];

                          return SongTile(
                            song: song,
                            onTap: () => widget.onSongTap(song),
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }
}