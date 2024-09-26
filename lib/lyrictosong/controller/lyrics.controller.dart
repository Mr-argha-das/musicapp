import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:musicproject/config/pretty.dio.dart';
import 'package:musicproject/lyrictosong/model/google.api.responsemode.dart';
import 'package:musicproject/lyrictosong/model/lyrcs.model.dart';
import 'package:musicproject/lyrictosong/model/suggestion.song.model.dart';
import 'package:musicproject/lyrictosong/service/google.youtube.service.dart';
import 'package:musicproject/lyrictosong/service/liyrcs.service.dart';

final lyricssongProvider = FutureProvider.family<LyrcsSOngResult?, String>((ref, body)async {
final service = LyrcisService(createDio());
return service.searchSong(body.toLowerCase());
});


final gooleApiController = FutureProvider.family<GoogleApiResponse, String>((ref, body)async {
  final service = GoogleYouTubeService(createDio());
  return service.getSongByYoutube(body.replaceAll(' ', '+'));
});

final suggestionSongs = FutureProvider.family<SuggestionSongModel, String>((ref, body) async {
  final service = LyrcisService(createDio());
  return service.suggestion("${body} | test");
});