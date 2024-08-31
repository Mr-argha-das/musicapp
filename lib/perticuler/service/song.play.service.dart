import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';

class SongService {
  static Duration duration = Duration.zero;
  static Duration position = Duration.zero;
  static final player = AudioPlayer();
  static void playSong(MediaItem song, String songurl) async {
    final audioSource = AudioSource.uri(
      Uri.parse('$songurl'),
      tag: song,
    );
    await player.stop();
    await player.setVolume(100);
    await player.setAudioSource(audioSource);
    await player.play();
  }

  static void stopSong() async {
    await player.stop();
  }

  static void ruseme() async {
    await player.play();
  }

  static void pause() async {
    await player.pause();
  }

}
