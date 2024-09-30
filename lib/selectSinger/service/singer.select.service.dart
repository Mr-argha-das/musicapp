import 'package:dio/dio.dart';
import 'package:musicproject/selectSinger/model/delet.singer.res.dart';
import 'package:musicproject/selectSinger/model/select.singer.body.dart';
import 'package:musicproject/selectSinger/model/select.singer.response.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';

part 'singer.select.service.g.dart';

@RestApi(baseUrl: 'http://159.89.160.247:8080/')
abstract class SelectSingerService {
  factory SelectSingerService(Dio dio) = _SelectSingerService;
  @POST('api/v1/add-artist-for-user')
  Future<SelectSingerResModel> addSingerUSer(@Body() SelectSingerModel body);
  @DELETE('api/v1/add-artist-for-user/{artistid}/{userid}')
  Future<DeleteSingerResModel> deletSingerUSer(@Path('artistid') String srtistid, @Path('userid') String userid);
}
