

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:musicproject/home/moodels/singer.model.dart';
import 'package:musicproject/home/moodels/song.search.model.dart';
import 'package:musicproject/home/moodels/songs.model.dart';
import 'package:musicproject/home/service/home.service.dart';
import 'package:retrofit/http.dart';
import '../../config/pretty.dio.dart';



final homeSingerProvider = FutureProvider.family<Artist, String>((ref, body) async {
    final homeService = HomeSerivce(createDio());
    return await homeService.usersingerList(body);
  });
  final homeSingerSongsProvide =
      FutureProvider.family<SongsBySingerModel, SongsBySingerModelbody>(
          (ref, body) async {
    final service = HomeSerivce(createDio());
    return await service.getSong(body);
  });


final allSingerProvider =  FutureProvider<Artist>((ref) async {
    final homeService = HomeSerivce(createDio());
    return await homeService.singerList();
  });



final homeArtisittoSearchPageProvider = StateProvider<String?>((ref) => null);
final homePageNavigatorIndex = StateProvider<int>((ref) => 0);