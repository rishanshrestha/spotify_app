import 'package:flutter/material.dart';
import '../models/song.dart';

class MiniPlayer extends StatelessWidget {
  final Song? song;
  final bool isPlaying;
  final VoidCallback onPlayPause;
  final VoidCallback onTap;

  const MiniPlayer({
    super.key,
    required this.song,
    required this.isPlaying,
    required this.onPlayPause,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    if (song == null) return const SizedBox.shrink();

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 65,
        margin: const EdgeInsets.symmetric(horizontal: 8),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: const Color(0xFF282828),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Image.network(
                song!.imageUrl,
                height: 43,
                width: 43,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => const Icon(
                  Icons.music_note,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    song!.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    song!.artist,
                    style: const TextStyle(
                      color: Colors.white60,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: onPlayPause,
              icon: Icon(
                isPlaying ? Icons.pause : Icons.play_arrow,
                color: Colors.white,
                size: 28,
              ),
            ),
          ],
        ),
      ),
    );
  }
}