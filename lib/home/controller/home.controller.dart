import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:musicproject/home/moodels/singer.model.dart';
import 'package:musicproject/home/moodels/song.search.model.dart';
import 'package:musicproject/home/moodels/songs.model.dart';
import 'package:musicproject/home/service/home.service.dart';
import '../../config/pretty.dio.dart';



final homeSingerProvider = FutureProvider<SingerModel>((ref) async {
    final homeService = HomeSerivce(createDio());
    return await homeService.singerList();
  });
  final homeSingerSongsProvide =
      FutureProvider.family<SongsBySingerModel, SongsBySingerModelbody>(
          (ref, body) async {
    final service = HomeSerivce(createDio());
    return await service.getSong(body);
  });


final homeAllSingerSongDataProvder = FutureProvider<List<SongBySingerModel2>>((ref) async {
  List<SongBySingerModel2> songsandSingers = [];
  
  final service = HomeSerivce(createDio());
  final SingerModel singers  = await service.singerList();
  for (int i = 0; i < singers.data.length; i++){
   final SongsBySingerModel songs = await service.getSong(SongsBySingerModelbody(singername: singers.data[i]));
   songsandSingers.add(SongBySingerModel2(name: singers.data[i], data: songs.data));
  }
  return songsandSingers;
});

class SongBySingerModel2{
  final String name;
  final List<Datum> data;

  SongBySingerModel2({required this.name, required this.data});

}