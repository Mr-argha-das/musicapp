import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

class CurrentSongModel {
  final String id;
  final String image;
  final String song;
  final String name;
  final String singer;
  final bool isplaying;
  CurrentSongModel(
      {required this.isplaying,
      required this.singer,
      required this.id,
      required this.image,
      required this.song,
      required this.name});
}

final songControllerSetSong =
    FutureProvider.family<CurrentSongModel?, CurrentSongModel?>(
        (ref, body) async {
  CurrentSongModel? returnValue;

  SharedPreferences pref = await SharedPreferences.getInstance();
  String? song = pref.getString('songurl');
  if (body == null) {
    if (song == null) {
      returnValue = null;
    } else {
      String? name = pref.getString('name');
      String? image = pref.getString('image');
      String? song = pref.getString('song');
      String? singer = pref.getString('singer');
      bool? isplaying = pref.getBool('isplaying');
      returnValue = CurrentSongModel(
          isplaying: false,
          singer: singer!,
          id: song!,
          image: image!,
          song: song!,
          name: name!);
    }
  } else {
    pref.setString('name', body.name);
    pref.setString('image', body.image);
    pref.setString('song', body.song);
    pref.setString('singer', body.singer);
    pref.setBool('isplaying', true);

    returnValue = CurrentSongModel(
        isplaying: true,
        singer: body.singer,
        id: body.song,
        image: body.image,
        song: body.song,
        name: body.name);
  }
  return returnValue;
});

class StoreSong {
  static String? name;
  static String? image;
  static String? song;
  static String? singer;
  static bool? isplaying;
  static void setValue() async {
   
  }
}
