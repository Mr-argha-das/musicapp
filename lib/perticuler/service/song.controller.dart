import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';

class SongState {
  final MediaItem? currentSong;
  final bool isPlaying;

  SongState({this.currentSong, this.isPlaying = false});
}

class SongStateNotifier extends StateNotifier<SongState> {
  final AudioPlayer _player;
  int _currentIndex = 0;
  List<MediaItem> _songQueue = [];

  SongStateNotifier(this._player) : super(SongState()) {
    _setupPlayerListeners();
  }

  void _setupPlayerListeners() {
    _player.playbackEventStream.listen((event) {
      if (event.processingState == ProcessingState.completed) {
        playNextSong();
      }
    }, onError: (error) {
      print('Playback error: $error');
    });
  }

  void addToQueue(List<MediaItem> songs) {

    _songQueue.addAll(songs);

  }

  void playNextSong() async {
    if (_songQueue.isEmpty) return;

    final nextSong = _songQueue[_currentIndex];
    _currentIndex = (_currentIndex + 1) % _songQueue.length;
    final songUrl = nextSong.extras?['url'] ?? '';

     state = SongState(currentSong: nextSong, isPlaying: true);
       playSong(nextSong, songUrl);
  }

  void playSong(MediaItem song, String songUrl) async {
    try {
      final audioSource = AudioSource.uri(
        Uri.parse(songUrl),
        tag: song,
      );

      

      await _player.stop();
      await _player.setVolume(1.0); // Adjust volume if needed
      await _player.setAudioSource(audioSource);
      state = SongState(currentSong: song, isPlaying: true);
      await _player.play();
      
    } catch (e) {
      print('Error playing song: $e');
      // Optionally update state to reflect the error
    }
  }

  void stopSong() async {
    state = SongState(currentSong: state.currentSong, isPlaying: false);
    await _player.stop();
  }

  void resume() async {
    state = SongState(currentSong: state.currentSong, isPlaying: true);
    await _player.play();
  }

  void pause() async {
    state = SongState(currentSong: state.currentSong, isPlaying: false);
    await _player.pause();
  }
  void playPreviousSong() async {
    if (_songQueue.isEmpty) return;

    _currentIndex = (_currentIndex - 1 + _songQueue.length) % _songQueue.length; // Ensure index wraps around
    final previousSong = _songQueue[_currentIndex];
    final songUrl = previousSong.extras?['url'] ?? '';

    state = SongState(currentSong: previousSong, isPlaying: true);
     playSong(previousSong, songUrl);
  }
}

// Create an instance of AudioPlayer
final audioPlayerProvider = Provider<AudioPlayer>((ref) {
  return AudioPlayer();
});

// Create a Riverpod StateNotifierProvider
final songStateProvider = StateNotifierProvider<SongStateNotifier, SongState>((ref) {
  final audioPlayer = ref.watch(audioPlayerProvider);
  return SongStateNotifier(audioPlayer);
});
