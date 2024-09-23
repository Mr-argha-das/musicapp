import 'package:dio/dio.dart';
import 'package:musicproject/home/moodels/singer.model.dart';
import 'package:musicproject/home/moodels/song.search.model.dart';
import 'package:musicproject/home/moodels/songs.model.dart';
import 'package:musicproject/lyrictosong/model/lyrcs.model.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';

part 'liyrcs.service.g.dart';

@RestApi(baseUrl: 'https://p5h8zcdp-8080.inc1.devtunnels.ms/')
abstract class LyrcisService {
  factory LyrcisService(Dio dio) = _LyrcisService;
  @GET('api/v1/search-song-by/{query}')
  Future<LyrcsSOngResult> searchSong(@Path("query") String value);
  
}
