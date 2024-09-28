import 'package:dio/dio.dart';
import 'package:musicproject/home/moodels/singer.model.dart';
import 'package:musicproject/home/moodels/song.search.model.dart';
import 'package:musicproject/home/moodels/songs.model.dart';
import 'package:musicproject/splash/model/login.model.dart';
import 'package:musicproject/splash/model/login.res.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';

part 'login.service.g.dart';

@RestApi(baseUrl: 'http://159.89.160.247:8080/')
abstract class LoginService {
  factory LoginService(Dio dio) = _LoginService;
  @POST('api/v1/user-create-login')
  Future<LoginModelResponse> login(@Body() LoginModelBody body);
}
