import 'dart:developer';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:retrofit/http.dart';

// Define the SongState class
class SongState {
  final MediaItem? currentSong;
  final bool isPlaying;
  final int playCount;
  final Duration totalPlayTime;
  final Duration currentPosition;
  final List<MediaItem>? songQueue;

  SongState({
    this.songQueue = null,
    this.currentSong,
    this.isPlaying = false,
    this.playCount = 0,
    this.totalPlayTime = Duration.zero,
    this.currentPosition = Duration.zero,
  });
}

// Define the SongStateNotifier class
class SongStateNotifier extends StateNotifier<SongState> {
  final AudioPlayer _player;
  int _currentIndex = 0;
  List<MediaItem> _songQueue = [];
  Duration _currentPlayTime = Duration.zero;

  SongStateNotifier(this._player) : super(SongState()) {
    _setupPlayerListeners();
  }

  // Expose the song queue through a getter
  List<MediaItem> get songQueue => _songQueue;

  void _setupPlayerListeners() {
    _player.playbackEventStream.listen((event) {
      if (event.processingState == ProcessingState.completed) {
        playNextSong();
      }
      if (_player.playing) {
        _currentPlayTime = _player.position;
      }
    }, onError: (error) {
      print('Playback error: $error');
    });

    _player.positionStream.listen((position) {
      if (state.currentSong != null) {
        state = SongState(
          currentSong: state.currentSong,
          isPlaying: state.isPlaying,
          playCount: state.playCount,
          totalPlayTime: state.totalPlayTime,
          currentPosition: position,
        );
      }
    });
  }

  void addToQueue(List<MediaItem> songs) {
    _songQueue.addAll(songs);
  }

  void playNextSong() async {
    if (_songQueue.isEmpty) return;

    final currentSong = state.currentSong;
    if (currentSong != null) {
      final updatedPlayCount = state.playCount + 1;
      final updatedPlayTime = state.totalPlayTime + _currentPlayTime;

      state = SongState(
          currentSong: currentSong,
          isPlaying: false,
          playCount: updatedPlayCount,
          totalPlayTime: updatedPlayTime,
          currentPosition: _currentPlayTime,
          songQueue: _songQueue);
    }

    final nextSong = _songQueue[_currentIndex];
    _currentIndex = (_currentIndex + 1) % _songQueue.length;
    final songUrl = nextSong.extras?['url'] ?? '';

    playSong(nextSong, songUrl);
  }

  void playSong(MediaItem song, String songUrl) async {
    try {
      final audioSource = AudioSource.uri(
        Uri.parse(songUrl),
        tag: song,
      );

      await _player.setVolume(1.0);
      await _player.setAudioSource(audioSource);
      _player.play();
      _player.durationStream.listen((duration) {
        log("======================");
        log(duration!.inSeconds.toString());
        state = SongState(
            currentSong: song,
            isPlaying: true,
            playCount: state.playCount,
            totalPlayTime: duration,
            currentPosition: _player.position,
            songQueue: _songQueue);
      });
    } catch (e) {
      print('Error playing song: $e');
    }
  }
  void playQuaae(int index) async {
    try {
      final audioSource = AudioSource.uri(
        Uri.parse(_songQueue[index].extras?['url'] ??
                                                    ''),
        tag: _songQueue[index],
      );

      await _player.setVolume(1.0);
      await _player.setAudioSource(audioSource);
      _player.play();
      _player.durationStream.listen((duration) {
        log("======================");
        log(duration!.inSeconds.toString());
        state = SongState(
            currentSong: _songQueue[index],
            isPlaying: true,
            playCount: state.playCount,
            totalPlayTime: duration,
            currentPosition: _player.position,
            songQueue: _songQueue);
      });
    } catch (e) {
      print('Error playing song: $e');
    }
  }

  void shuffle() async {
    await _player.shuffle();
  }

  void stopSong() async {
    final currentSong = state.currentSong;
    if (currentSong != null) {
      state = SongState(
        currentSong: null,
        isPlaying: false,
        playCount: state.playCount,
        totalPlayTime: state.totalPlayTime + _currentPlayTime,
        currentPosition: Duration.zero,
      );
    }
    await _player.stop();
  }

  void resume() async {
    state = SongState(
        currentSong: state.currentSong,
        isPlaying: true,
        playCount: state.playCount,
        totalPlayTime: state.totalPlayTime,
        currentPosition: _player.position,
        songQueue: songQueue);
    await _player.play();
  }

  void pause() async {
    state = SongState(
        currentSong: state.currentSong,
        isPlaying: false,
        playCount: state.playCount,
        totalPlayTime: state.totalPlayTime + _currentPlayTime,
        currentPosition: _player.position,
        songQueue: songQueue);
    await _player.pause();
  }

  void playPreviousSong() async {
    if (_songQueue.isEmpty) return;

    final currentSong = state.currentSong;
    if (currentSong != null) {
      state = SongState(
        currentSong: currentSong,
        isPlaying: false,
        playCount: state.playCount + 1,
        totalPlayTime: state.totalPlayTime + _currentPlayTime,
        currentPosition: _player.position,
      );
    }

    _currentIndex = (_currentIndex - 1 + _songQueue.length) % _songQueue.length;
    final previousSong = _songQueue[_currentIndex];
    final songUrl = previousSong.extras?['url'] ?? '';

    state = SongState(
      currentSong: previousSong,
      isPlaying: true,
      currentPosition: Duration.zero,
    );
    playSong(previousSong, songUrl);
  }
}

// Create an instance of AudioPlayer
final audioPlayerProvider = Provider<AudioPlayer>((ref) {
  return AudioPlayer();
});

// Create a Riverpod StateNotifierProvider
final songStateProvider =
    StateNotifierProvider<SongStateNotifier, SongState>((ref) {
  final audioPlayer = ref.watch(audioPlayerProvider);
  return SongStateNotifier(audioPlayer);
});

class CurrentsongsRecommandationState {
  final List<MediaItem>? data;

  CurrentsongsRecommandationState({this.data = null});
}

class CurrentSongRecomandationNotifire
    extends StateNotifier<CurrentsongsRecommandationState> {
  CurrentSongRecomandationNotifire(super.state);

  void setdata(List<MediaItem> songs) {
    state = CurrentsongsRecommandationState(data: songs);
  }
  void remove(){
    state = CurrentsongsRecommandationState(data: null);
  }
}


final currentSongRecomandationProvider = StateNotifierProvider<CurrentSongRecomandationNotifire,CurrentsongsRecommandationState >((ref){
 return CurrentSongRecomandationNotifire(CurrentsongsRecommandationState());
});