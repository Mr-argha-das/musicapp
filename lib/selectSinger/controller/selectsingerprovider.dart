import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:musicproject/home/controller/home.controller.dart';
import 'package:musicproject/home/moodels/singer.model.dart';


final searchQueryProvider = StateProvider<String>((ref) => '');

final filteredItemsProvider = Provider<List<Datum>>((ref) {
  final items = ref.watch(homeSingerProvider);
  final query = ref.watch(searchQueryProvider).toLowerCase();


  if (query.isEmpty) {
    return items.value!.data;
  }

  return items.value!.data
      .where((item) => item.name!.toLowerCase().contains(query))
      .toList();
});
