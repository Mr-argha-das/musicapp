


import 'package:dio/dio.dart';
import 'package:musicproject/home/moodels/singer.model.dart';
import 'package:musicproject/home/moodels/song.search.model.dart';
import 'package:musicproject/home/moodels/songs.model.dart';
import 'package:musicproject/lyrictosong/model/google.api.responsemode.dart';
import 'package:musicproject/lyrictosong/model/lyrcs.model.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';

part 'google.youtube.service.g.dart';

@RestApi(baseUrl: 'https://www.googleapis.com/')
abstract class GoogleYouTubeService {
  factory GoogleYouTubeService(Dio dio) = _GoogleYouTubeService;
  @GET('youtube/v3/search?part=snippet&q={query}&type=video&key=AIzaSyAIZKkz_HoyU5cTQRB2Pp2V4QwcReNgR0U')
  Future<GoogleApiResponse> getSongByYoutube(@Path("query") String value);
  
}
