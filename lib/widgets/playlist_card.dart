import 'package:flutter/material.dart';
import '../models/playlist.dart';

class PlaylistCard extends StatelessWidget {
  final Playlist playlist;
  final VoidCallback onTap;

  const PlaylistCard({
    super.key,
    required this.playlist,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 155,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                playlist.imageUrl,
                width: 155,
                height: 155,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  width: 155,
                  height: 155,
                  color: Colors.white12,
                  child: const Icon(
                    Icons.queue_music,
                    size: 45,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              playlist.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              playlist.description,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Colors.white60,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}