import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:musicproject/config/pretty.dio.dart';
import 'package:musicproject/search/models/search.model.dart';
import 'package:musicproject/search/service/search.service.dart';

final searchResultProvider = FutureProvider.family<SearchResultModel, String>((ref, query) async {
    final searchService = SearchService(createDio());
    return await searchService.searchsong(query);
  });