import 'package:dio/dio.dart';
import 'package:musicproject/home/moodels/singer.model.dart';
import 'package:musicproject/home/moodels/song.search.model.dart';
import 'package:musicproject/home/moodels/songs.model.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';

part 'home.service.g.dart';

@RestApi(baseUrl: 'http://165.232.185.159:8000/')
abstract class HomeSerivce {
  factory HomeSerivce(Dio dio) = _HomeSerivce;
  @GET('api/v1/get-artist')
  Future<Artist> singerList();
  @POST('api/v1/get-song?limit=10&offset=0')
  Future<SongsBySingerModel> getSong(@Body() SongsBySingerModelbody body);
}
