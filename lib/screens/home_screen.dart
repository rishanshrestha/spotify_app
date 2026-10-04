import 'package:flutter/material.dart';
import '../data/music_data.dart';
import '../models/song.dart';
import '../models/playlist.dart';
import '../widgets/song_tile.dart';
import '../widgets/playlist_card.dart';

class HomeScreen extends StatelessWidget {
  final Function(Song) onSongTap;
  final Function(Playlist) onPlaylistTap;

  const HomeScreen({
    super.key,
    required this.onSongTap,
    required this.onPlaylistTap,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: Color(0xFF1DB954),
                          child: Icon(
                            Icons.person,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(width: 12),
                        Text(
                          'Good morning',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 23,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 25),
                    const Text(
                      'Your playlists',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 15),
                  ],
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              sliver: SliverGrid(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final playlist = playlists[index];

                    return GestureDetector(
                      onTap: () => onPlaylistTap(playlist),
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFF282828),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        clipBehavior: Clip.antiAlias,
                        child: Row(
                          children: [
                            Image.network(
                              playlist.imageUrl,
                              width: 72,
                              height: 85,
                              fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) =>
                                  const SizedBox(
                                width: 72,
                                child: Icon(
                                  Icons.music_note,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8),
                                child: Text(
                                  playlist.name,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  childCount: playlists.length,
                ),
                gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 2.05,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(18, 28, 18, 12),
                child: const Text(
                  'Made for you',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 245,
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  scrollDirection: Axis.horizontal,
                  itemCount: playlists.length,
                  separatorBuilder: (_, __) =>
                      const SizedBox(width: 14),
                  itemBuilder: (context, index) {
                    return PlaylistCard(
                      playlist: playlists[index],
                      onTap: () =>
                          onPlaylistTap(playlists[index]),
                    );
                  },
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(18, 25, 18, 8),
                child: const Text(
                  'Recently played',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => SongTile(
                  song: songs[index],
                  onTap: () => onSongTap(songs[index]),
                ),
                childCount: songs.length,
              ),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(height: 20),
            ),
          ],
        ),
      ),
    );
  }
}