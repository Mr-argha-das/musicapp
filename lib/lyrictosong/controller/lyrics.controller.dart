import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:musicproject/config/pretty.dio.dart';
import 'package:musicproject/lyrictosong/model/lyrcs.model.dart';
import 'package:musicproject/lyrictosong/service/liyrcs.service.dart';

final lyricssongProvider = FutureProvider.family<LyrcsSOngResult?, String>((ref, body)async {
final service = LyrcisService(createDio());
return service.searchSong(body.toLowerCase());
});