import '../models/song.dart';
import '../models/playlist.dart';

const List<Song> songs = [
  Song(
    id: '1',
    title: 'Dreams',
    artist: 'Demo Artist',
    imageUrl: 'https://picsum.photos/seed/music1/500',
    audioUrl:
        'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3',
  ),
  Song(
    id: '2',
    title: 'Summer Vibes',
    artist: 'Demo Artist',
    imageUrl: 'https://picsum.photos/seed/music2/500',
    audioUrl:
        'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-2.mp3',
  ),
  Song(
    id: '3',
    title: 'Night Drive',
    artist: 'Demo Artist',
    imageUrl: 'https://picsum.photos/seed/music3/500',
    audioUrl:
        'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-3.mp3',
  ),
  Song(
    id: '4',
    title: 'Ocean Waves',
    artist: 'Demo Artist',
    imageUrl: 'https://picsum.photos/seed/music4/500',
    audioUrl:
        'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-4.mp3',
  ),
  Song(
    id: '5',
    title: 'Midnight',
    artist: 'Demo Artist',
    imageUrl: 'https://picsum.photos/seed/music5/500',
    audioUrl:
        'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-5.mp3',
  ),
];

final List<Playlist> playlists = [
  Playlist(
    id: 'p1',
    name: 'Chill Mix',
    description: 'Relax and enjoy your favorite sounds.',
    imageUrl: 'https://picsum.photos/seed/chill/500',
    songs: songs.take(3).toList(),
  ),
  Playlist(
    id: 'p2',
    name: 'Daily Vibes',
    description: 'Music for your everyday routine.',
    imageUrl: 'https://picsum.photos/seed/daily/500',
    songs: songs.skip(2).toList(),
  ),
  Playlist(
    id: 'p3',
    name: 'Night Collection',
    description: 'Perfect music for late nights.',
    imageUrl: 'https://picsum.photos/seed/night/500',
    songs: songs.reversed.toList(),
  ),
];