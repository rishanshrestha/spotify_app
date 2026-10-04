import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import '../models/song.dart';

class PlayerScreen extends StatelessWidget {
  final Song? song;
  final AudioPlayer player;
  final VoidCallback onPlayPause;
  final VoidCallback onNext;
  final VoidCallback onPrevious;

  const PlayerScreen({
    super.key,
    required this.song,
    required this.player,
    required this.onPlayPause,
    required this.onNext,
    required this.onPrevious,
  });

  String formatDuration(Duration duration) {
    final minutes = duration.inMinutes;
    final seconds =
        duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    if (song == null) {
      return const Scaffold(
        backgroundColor: Color(0xFF121212),
        body: Center(
          child: Text(
            'Select a song to play',
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        backgroundColor: const Color(0xFF121212),
        leading: IconButton(
          icon: const Icon(
            Icons.keyboard_arrow_down,
            color: Colors.white,
            size: 32,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'NOW PLAYING',
          style: TextStyle(
            color: Colors.white,
            fontSize: 12,
            letterSpacing: 2,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  song!.imageUrl,
                  width: double.infinity,
                  height: 310,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    height: 310,
                    color: Colors.white12,
                    child: const Icon(
                      Icons.music_note,
                      size: 100,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 35),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          song!.title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 23,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          song!.artist,
                          style: const TextStyle(
                            color: Colors.white60,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.favorite_border,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 25),
              StreamBuilder<Duration>(
                stream: player.positionStream,
                builder: (context, snapshot) {
                  final position = snapshot.data ?? Duration.zero;
                  final duration =
                      player.duration ?? Duration.zero;

                  final max = duration.inMilliseconds > 0
                      ? duration.inMilliseconds.toDouble()
                      : 1.0;

                  final value = position.inMilliseconds
                      .toDouble()
                      .clamp(0.0, max);

                  return Column(
                    children: [
                      Slider(
                        min: 0,
                        max: max,
                        value: value,
                        activeColor: const Color(0xFF1DB954),
                        inactiveColor: Colors.white24,
                        onChanged: (newValue) {
                          player.seek(
                            Duration(
                              milliseconds: newValue.round(),
                            ),
                          );
                        },
                      ),
                      Row(
                        mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            formatDuration(position),
                            style: const TextStyle(
                              color: Colors.white60,
                              fontSize: 12,
                            ),
                          ),
                          Text(
                            formatDuration(duration),
                            style: const TextStyle(
                              color: Colors.white60,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    onPressed: onPrevious,
                    icon: const Icon(
                      Icons.skip_previous,
                      color: Colors.white,
                      size: 42,
                    ),
                  ),
                  StreamBuilder<PlayerState>(
                    stream: player.playerStateStream,
                    builder: (context, snapshot) {
                      final isPlaying =
                          snapshot.data?.playing ?? false;

                      return IconButton(
                        onPressed: onPlayPause,
                        icon: Icon(
                          isPlaying
                              ? Icons.pause_circle_filled
                              : Icons.play_circle_fill,
                          color: Colors.white,
                          size: 70,
                        ),
                      );
                    },
                  ),
                  IconButton(
                    onPressed: onNext,
                    icon: const Icon(
                      Icons.skip_next,
                      color: Colors.white,
                      size: 42,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.devices,
                    color: Colors.white60,
                    size: 20,
                  ),
                  SizedBox(width: 8),
                  Text(
                    'Listening on this device',
                    style: TextStyle(color: Colors.white60),
                  ),
                ],
              ),
              const SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }
}