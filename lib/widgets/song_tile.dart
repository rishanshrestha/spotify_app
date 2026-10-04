import 'package:flutter/material.dart';
import '../models/song.dart';

class SongTile extends StatelessWidget {
  final Song song;
  final VoidCallback onTap;

  const SongTile({
    super.key,
    required this.song,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 4,
      ),
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(6),
        child: Image.network(
          song.imageUrl,
          width: 55,
          height: 55,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => const Icon(
            Icons.music_note,
            size: 45,
          ),
        ),
      ),
      title: Text(
        song.title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: Text(
        song.artist,
        style: const TextStyle(color: Colors.white60),
      ),
      trailing: const Icon(
        Icons.more_vert,
        color: Colors.white60,
      ),
    );
  }
}