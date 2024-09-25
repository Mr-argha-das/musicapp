import 'package:dio/dio.dart';
import 'package:musicproject/search/models/search.model.dart';
import 'package:retrofit/retrofit.dart';

part 'search.service.g.dart';

@RestApi(baseUrl: 'http://159.89.160.247:8080/')
abstract class SearchService {
  factory SearchService(Dio dio) = _SearchService;
  @GET('api/v1/get-search/{query}')
  Future<SearchResultModel> searchsong(@Path('query') String value);

}
