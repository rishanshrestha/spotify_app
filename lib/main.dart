import 'package:flutter/material.dart';

import 'data/music_data.dart';
import 'models/song.dart';
import 'models/playlist.dart';

import 'services/audio_service.dart';

import 'screens/home_screen.dart';
import 'screens/search_screen.dart';
import 'screens/library_screen.dart';
import 'screens/player_screen.dart';

import 'widgets/mini_player.dart';
import 'widgets/bottom_nav_bar.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const SpotifyApp());
}

class SpotifyApp extends StatelessWidget {
  const SpotifyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Spotify App',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF121212),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1DB954),
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final AudioService audioService = AudioService();

  int selectedIndex = 0;
  int currentSongIndex = 0;

  Song? currentSong;
  List<Song> currentQueue = songs;

  bool isPlayerOpen = false;

  void playSong(Song song) {
    final index = currentQueue.indexWhere(
      (item) => item.id == song.id,
    );

    if (index != -1) {
      currentSongIndex = index;
    } else {
      currentQueue = songs;
      currentSongIndex = songs.indexWhere(
        (item) => item.id == song.id,
      );
      if (currentSongIndex < 0) currentSongIndex = 0;
    }

    setState(() {
      currentSong = song;
    });

    audioService.playSong(song).catchError((Object error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Unable to play song: $error'),
          ),
        );
      }
    });
  }

  void playPlaylist(Playlist playlist) {
    if (playlist.songs.isEmpty) return;

    setState(() {
      currentQueue = playlist.songs;
      currentSongIndex = 0;
      currentSong = playlist.songs.first;
    });

    audioService.playSong(playlist.songs.first).catchError(
      (Object error) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Unable to play song: $error'),
            ),
          );
        }
      },
    );
  }

  void nextSong() {
    if (currentQueue.isEmpty) return;

    currentSongIndex =
        (currentSongIndex + 1) % currentQueue.length;

    playSong(currentQueue[currentSongIndex]);
  }

  void previousSong() {
    if (currentQueue.isEmpty) return;

    currentSongIndex =
        (currentSongIndex - 1 + currentQueue.length) %
            currentQueue.length;

    playSong(currentQueue[currentSongIndex]);
  }

  void togglePlayPause() {
    if (currentSong == null) {
      playSong(songs.first);
      return;
    }

    if (audioService.player.playing) {
      audioService.pause();
    } else {
      audioService.resume();
    }
  }

  void openPlayer() {
    if (currentSong == null) return;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => PlayerScreen(
          song: currentSong,
          player: audioService.player,
          onPlayPause: togglePlayPause,
          onNext: nextSong,
          onPrevious: previousSong,
        ),
      ),
    );
  }

  Widget buildCurrentScreen() {
    switch (selectedIndex) {
      case 1:
        return SearchScreen(
          onSongTap: playSong,
        );
      case 2:
        return LibraryScreen(
          onPlaylistTap: playPlaylist,
        );
      default:
        return HomeScreen(
          onSongTap: playSong,
          onPlaylistTap: playPlaylist,
        );
    }
  }

  @override
  void dispose() {
    audioService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: buildCurrentScreen(),
          ),
          StreamBuilder(
            stream: audioService.player.playerStateStream,
            builder: (context, snapshot) {
              final isPlaying =
                  snapshot.data?.playing ?? false;

              return MiniPlayer(
                song: currentSong,
                isPlaying: isPlaying,
                onPlayPause: togglePlayPause,
                onTap: openPlayer,
              );
            },
          ),
          BottomNavBar(
            selectedIndex: selectedIndex,
            onTap: (index) {
              setState(() {
                selectedIndex = index;
              });
            },
          ),
        ],
      ),
    );
  }
}