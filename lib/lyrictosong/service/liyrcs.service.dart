import 'package:dio/dio.dart';
import 'package:musicproject/home/moodels/singer.model.dart';
import 'package:musicproject/home/moodels/song.search.model.dart';
import 'package:musicproject/home/moodels/songs.model.dart';
import 'package:musicproject/lyrictosong/model/lyrcs.model.dart';
import 'package:musicproject/lyrictosong/model/suggestion.song.model.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';

part 'liyrcs.service.g.dart';

@RestApi(baseUrl: 'http://159.89.160.247:8080/')
abstract class LyrcisService {
  factory LyrcisService(Dio dio) = _LyrcisService;
  @GET('api/v1/ml-data/{query}')
  Future<LyrcsSOngResult> searchSong(@Path("query") String value);
  @GET('api/v1/get-recomidation-song/{query}')
  Future<SuggestionSongModel> suggestion(@Path("query") String value);
  
}
