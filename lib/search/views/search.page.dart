import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:musicproject/config/pretty.dio.dart';
import 'package:musicproject/perticuler/views/perticuler.page.dart';
import 'package:musicproject/search/models/search.model.dart';
import 'package:musicproject/search/service/search.controller.dart';
import 'package:musicproject/search/service/search.service.dart';

class SearchPage extends ConsumerWidget {
 SearchPage({super.key});

  // final service = SearchService(createDio());
  final _searchController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchresult = ref.watch(searchResultProvider(_searchController.text));
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(0, 0, 0, 1),
        title: TextFormField(
          controller: _searchController,
          style: GoogleFonts.montserrat(color: Colors.white),
          decoration: InputDecoration(
              fillColor: Colors.grey.shade900,
              filled: true,
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.grey.shade900)),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.grey.shade900)),
              suffixIcon: const Icon(
                Icons.search,
                color: Colors.white,
              )),
          onChanged: (value) {
            // if (value == "" || value.isEmpty) {
            //   setState(() {
            //     futureAlbum = service.searchsong("%7C");
            //   });
            // } else {
            //   setState(() {
            //     futureAlbum = service.searchsong(value);
            //   });
            // }
          },
        ),
      ),
      body: FutureBuilder(
          future: ref.watch(searchResultProvider(_searchController.text)),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Padding(
                padding: const EdgeInsets.only(top: 50),
                child: ListView.builder(
                    itemCount: snapshot.data!.data.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: GestureDetector(
                          onTap: (){
                            Navigator.push(context, CupertinoPageRoute(builder: (context) => 
                            PeticulerSongScrollable(
                              image: snapshot.data!.data[index].image, 
                              song: snapshot.data!.data[index].songsaudio, 
                              name: snapshot.data!.data[index].name, 
                              singer: snapshot.data!.data[index].singer, 
                              id: snapshot.data!.data[index].id.oid)));

                          },
                          child: SizedBox(
                            height: 80,
                            width: MediaQuery.of(context).size.width,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  height: 70,
                                  width: 70,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade900,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Center(
                                    child: CachedNetworkImage(
                                      height: 70,
                                      width: 70,
                                      fit: BoxFit.cover,
                                      imageUrl: snapshot.data!.data[index].image,
                                      placeholder: (context, url) => SizedBox(),
                                      errorWidget: (context, url, error) =>
                                          Icon(Icons.error),
                                    ),
                                  ),
                                ),
                                new SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                    child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${snapshot.data!.data[index].name}",
                                      style: GoogleFonts.montserrat(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    ),
                                    SizedBox(
                                      height: 2,
                                    ),
                                    Text(
                                      "${snapshot.data!.data[index].singer}",
                                      style: GoogleFonts.montserrat(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 10),
                                    ),
                                    SizedBox(
                                      height: 4,
                                    ),
                                  ],
                                ))
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          })
    );
  }
}

