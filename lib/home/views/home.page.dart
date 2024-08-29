import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:musicproject/config/pretty.dio.dart';
import 'package:musicproject/home/moodels/singer.model.dart';
import 'package:musicproject/home/moodels/song.search.model.dart';
import 'package:musicproject/home/moodels/songs.model.dart';
import 'package:musicproject/home/service/home.service.dart';
import 'package:musicproject/perticuler/views/perticuler.page.dart';
import 'package:musicproject/search/views/search.page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int pageIndex =0 ;
  List<Widget> pages = [
    HomeSection(),
    SearchPage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: pages[pageIndex],
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(left: 30),
        child: Container(
            height: 60,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: Colors.grey.shade900,
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black87,
                    offset: Offset(4, 4),
                    spreadRadius: 1,
                    blurRadius: 12
                  )
                ],
                borderRadius: BorderRadius.circular(500)),
            child:  Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Center(
                    child: GestureDetector(
                      onTap: (){
                        setState(() {
                          pageIndex = 0;
                        });
                      },
                      child: Icon(
                        Icons.home_mini_outlined,
                        color: Colors.white,
                        size: 28,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: GestureDetector(
                      onTap: (){
                         setState(() {
                          pageIndex = 1;
                        });
                      },
                      child: const Icon(
                        Icons.search,
                        color: Colors.white,
                        size: 28,
                      ),
                    ),
                  ),
                ),
                const Expanded(
                  child: Center(
                    child: Icon(
                      Icons.library_music_outlined,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
                ),
                const Expanded(
                  child: Center(
                    child: Icon(
                      Icons.person_2_outlined,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}



class HomeSection extends StatefulWidget {
  const HomeSection({super.key});

  @override
  State<HomeSection> createState() => _HomeSectionState();
}

class _HomeSectionState extends State<HomeSection> {
  final service = HomeSerivce(createDio());
  late Future<SingerModel> futureAlbum;

 
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    futureAlbum = service.singerList();
  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<SingerModel>(
        future: futureAlbum,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  new SizedBox(
                    height: 100,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Soome Playlist",
                      style: GoogleFonts.bodoniModa(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 30),
                    ),
                  ),
                  SizedBox(
                    height: 190,
                    width: MediaQuery.of(context).size.width,
                    child: ListView.builder(
                        itemCount: 5,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 150,
                              width: 180,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      color: Colors.black, width: 2)),
                              child: Padding(
                                padding: const EdgeInsets.all(1.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Expanded(
                                              child: Container(
                                            color: Colors.blue,
                                          )),
                                          Expanded(
                                              child: Container(
                                            color: Colors.black,
                                          ))
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Expanded(
                                              child: Container(
                                            color: Colors.yellow,
                                          )),
                                          Expanded(
                                              child: Container(
                                            color: Colors.green,
                                          ))
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                  ),
                  ListView.builder(
                      itemCount: snapshot.data!.data.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        if (snapshot.data?.data[index] != null) {
                          return Tabs(
                              singername:
                                  snapshot.data!.data[index].toString());
                        }
                      }),
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }

          // By default, show a loading spinner.
          return const Center(child: CircularProgressIndicator());
        },
      );
  }
}


class Tabs extends StatefulWidget {
  final String singername;
  const Tabs({super.key, required this.singername});

  @override
  State<Tabs> createState() => _TabsState();
}

class _TabsState extends State<Tabs> {
  final service = HomeSerivce(createDio());
  late Future<SongsBySingerModel> futureAlbum;
  @override
  void initState() {
    super.initState();
    futureAlbum =
        service.getSong(SongsBySingerModelbody(singername: widget.singername));
  }

  @override
  Widget build(BuildContext context) {
    log(widget.singername);
    return FutureBuilder<SongsBySingerModel>(
      future: futureAlbum,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Padding(
            padding: const EdgeInsets.only(top: 20),
            child: SizedBox(
              width: MediaQuery.of(context).size.width - 20,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      widget.singername,
                      style: GoogleFonts.bodoniModa(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 30),
                    ),
                  ),
                  new SizedBox(
                    height: 200,
                    width: MediaQuery.of(context).size.width,
                    child: ListView.builder(
                        itemCount: snapshot.data!.data.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    CupertinoPageRoute(
                                        builder: (context) =>
                                            PerticulerSongPage(
                                              image: snapshot
                                                  .data!.data[index].image,
                                              song: snapshot
                                                  .data!.data[index].songsaudio,
                                              id: snapshot
                                                  .data!.data[index].id.oid,
                                              name: snapshot
                                                  .data!.data[index].name,
                                              singer: snapshot
                                                  .data!.data[index].singer,
                                            )));
                              },
                              child: Hero(
                                tag: "${snapshot.data!.data[index].id.oid}",
                                child: Container(
                                  height: 150,
                                  width: 180,
                                  decoration: BoxDecoration(
                                      color: Colors.grey.shade900,
                                      borderRadius: BorderRadius.circular(10),
                                      image: DecorationImage(
                                          image: NetworkImage(
                                            snapshot.data!.data[index].image,
                                          ),
                                          fit: BoxFit.cover)),
                                ),
                              ),
                            ),
                          );
                        }),
                  )
                ],
              ),
            ),
          );
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }

        // By default, show a loading spinner.
        return SizedBox();
      },
    );
  }
}


