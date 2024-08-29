import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';

class SongService {
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
  static void stopSong()async {
    await player.stop();
  }
}
