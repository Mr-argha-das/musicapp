import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:musicproject/config/pretty.dio.dart';
import 'package:musicproject/lyrictosong/controller/lyrics.controller.dart';
import 'package:musicproject/lyrictosong/model/lyrcs.model.dart';
import 'package:musicproject/lyrictosong/service/liyrcs.service.dart';
import 'package:musicproject/lyrictosong/views/lyrics.resultpage.dart';
import 'package:musicproject/perticuler/service/song.controller.dart';
import 'package:musicproject/perticuler/views/perticuler.page.dart';
import 'package:musicproject/search/controller/search.controller.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:url_launcher/url_launcher.dart';

class LyricsToSong extends ConsumerStatefulWidget {
  const LyricsToSong({super.key});

  @override
  _LyricsToSongState createState() => _LyricsToSongState();
}

class _LyricsToSongState extends ConsumerState<LyricsToSong> {
  bool _listen = false;
  String mainValue = "";
  final SpeechToText _speech = SpeechToText();
  double _confidence = 1.0;
  String _text = 'Our own ai that help you to find your song';
  LyrcsSOngResult? response;
  void _listenFunction() async {
    if (!_listen) {
      bool available = await _speech.initialize(
        onStatus: (val) {
          log('onStatus: $val');
          // Check if speech recognition stopped and run a function after speech
          if (val == 'done') {
            Future.delayed(Duration(seconds: 2), () {
              songGet(mainValue);
            });
          }
        },
        onError: (val) => log('onError: $val'),
      );
      if (available) {
        setState(() => _listen = true);
        _speech.listen(
          onResult: (val) => setState(() {
            mainValue = val.recognizedWords;
            _text = val.recognizedWords;
            if (val.hasConfidenceRating && val.confidence > 0) {
              _confidence = val.confidence;
            }
          }),
        );
      }
    } else {
      setState(() => _listen = false);
      _speech.stop();
    }
  }

  void songGet(String value) async {
    Navigator.push(
        context,
        CupertinoPageRoute(
            builder: (context) => ResultPageSong(
                  value: value,
                )));
    setState(() {
      _listen = false;
      _text = 'Our own ai that help you to find your song';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Colors.black,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  _listenFunction();
                },
                child: Container(
                  height: 275,
                  width: 275,
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(500),
                      image: DecorationImage(
                          image: AssetImage(_listen
                              ? "assets/circle.gif"
                              : "assets/circle.png"),
                          fit: BoxFit.cover)),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                _listen ? "Finding.." : "Give me lyrics I will find",
                style: GoogleFonts.montserrat(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 28),
              ),
              Text(
                _text,
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ));
  }
}

class ResultPageSong extends ConsumerStatefulWidget {
  final String value;
  const ResultPageSong({
    super.key,
    required this.value,
  });

  @override
  _ResultPageSongState createState() => _ResultPageSongState();
}

class _ResultPageSongState extends ConsumerState<ResultPageSong> {
  @override
  Widget build(BuildContext context) {
    final speecResult = ref.watch(lyricssongProvider("${widget.value}"));
    final songController = ref.read(songStateProvider.notifier);

    final songState = ref.watch(songStateProvider);
    final currentSong = songState.totalPlayTime;

    final duration = currentSong.inSeconds.toDouble();
    // final recomandeationsog = ref.watch();

    final songList = ref.watch(currentSongRecomandationProvider);

    //  for(int i = 0; i <songList.data!.length;){
    //   if(songState.currentSong?.id == songList.data![i].id){
    //     isExapnded = true;
    //   }
    //  }
    // bool checkSong(index) {
    //   bool value = false;
    //   if (songState.currentSong?.id == songList.data![index].id &&
    //       songState.isPlaying == true) {
    //     value = true;
    //   } else {
    //     value = false;
    //   }
    //   return value;
    // }

    return Scaffold(
      backgroundColor: Colors.black,
      body: speecResult.when(
          data: (response) {
            final suggestionData =
                ref.watch(suggestionSongs(response!.data!.singer!));
            final songAccordingSinger = ref.watch(searchResultProvider(
                response!.data!.singer!.split('|').first.trim()));
            final youtubeData =
                ref.watch(gooleApiController(response.data!.name.toString()));
            
            return Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(color: Colors.black),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 60,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        height: 200,
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              height: 150,
                              width: 150,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                  image: DecorationImage(
                                      image: NetworkImage(
                                        response!.data!.image!,
                                      ),
                                      fit: BoxFit.cover)),
                              child: Center(
                                child: Container(
                                  height: 70,
                                  width: 70,
                                  decoration: BoxDecoration(
                                      color: Colors.white54,
                                      borderRadius:
                                          BorderRadius.circular(5000)),
                                  child: Center(
                                    child: Icon(
                                      Icons.play_arrow,
                                      color: Colors.black,
                                      size: 40,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        children: [
                          const SizedBox(
                            width: 8,
                          ),
                          Container(
                            height: 40,
                            width: 40,
                            decoration: const BoxDecoration(
                                color: Colors.black,
                                image: DecorationImage(
                                    image: AssetImage("assets/circle.gif"),
                                    fit: BoxFit.contain)),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                response!.data!.name!,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.montserrat(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                response!.data!.singer!,
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.montserrat(
                                    color: Colors.white60,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(
                          width: 8,
                        ),
                        Text(
                          "TOP SONG",
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.montserrat(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    songAccordingSinger.when(data: (snapshot) {
                      return ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: snapshot.data.length > 4
                              ? 4
                              : snapshot.data.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding:
                                  const EdgeInsets.only(left: 0, right: 00),
                              child: SizedBox(
                                height: 80,
                                width: MediaQuery.of(context).size.width,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: SizedBox(
                                        width: 30,
                                        child: Text(
                                          "${index + 1}".toString(),
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Center(
                                      child: Container(
                                        height: 60,
                                        width: 60,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            image: DecorationImage(
                                                image: NetworkImage(snapshot
                                                    .data![index].image
                                                    .toString()),
                                                fit: BoxFit.cover)),
                                      ),
                                    ),
                                    new SizedBox(
                                      width: 15,
                                    ),
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            snapshot.data![index].name
                                                .toString(),
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 16),
                                          ),
                                          Text(
                                            snapshot.data![index].singer
                                                .toString(),
                                            style: TextStyle(
                                                color: Colors.white54,
                                                fontSize: 11),
                                          )
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                        child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            ref
                                                .read(
                                                    songStateProvider.notifier)
                                                .playQuaae(index);
                                          },
                                          child: Icon(
                                            // checkSong(index)
                                            Icons.play_arrow_rounded
                                            // : Icons.play_arrow_rounded,
                                            ,
                                            color: Colors.white,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 25,
                                        ),
                                        Icon(
                                          Icons.graphic_eq_outlined,
                                          color: Colors.greenAccent,
                                        ),
                                      ],
                                    )),
                                  ],
                                ),
                              ),
                            );
                          });
                    }, error: (stack, eerr) {
                      return Text("");
                    }, loading: () {
                      return LoadingAnimationWidget.staggeredDotsWave(
                          color: Colors.white, size: 40);
                    }),
                    SizedBox(
                      height: 30,
                    ),
                    youtubeData.when(
                        data: (value) {
                          return Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    "YOUTUBE",
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.montserrat(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: GestureDetector(
                                  onTap: () async {
                                    final url =
                                        'https://www.youtube.com/watch?v=${value.items[0].id.videoId}'; // Replace with the actual video URL

                                    await launchUrl(Uri.parse(url));
                                  },
                                  child: Container(
                                    height: 210,
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                        color: Colors.grey.shade700,
                                        image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(value.items[0]
                                                .snippet.thumbnails.high.url)),
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                    child: Center(
                                        child: Container(
                                      height: 50,
                                      width: 70,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          boxShadow: const [
                                            BoxShadow(
                                                color: Colors.black45,
                                                spreadRadius: 1,
                                                blurRadius: 12,
                                                offset: Offset(4, 4))
                                          ],
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          image: const DecorationImage(
                                              image: AssetImage(
                                                  "assets/youtube-6616310_1280.webp"),
                                              fit: BoxFit.contain)),
                                    )),
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Flexible(
                                    child: Text(
                                      value.items[0].snippet.title,
                                      overflow: TextOverflow.clip,
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.montserrat(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              suggestionData.when(
                                  data: (suggestion) {
                                    return Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            const SizedBox(
                                              width: 8,
                                            ),
                                            Text(
                                              "YOU MAY ALSO LIKE",
                                              overflow: TextOverflow.ellipsis,
                                              style: GoogleFonts.montserrat(
                                                  color: Colors.white,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 30,
                                        ),
                                        SizedBox(
                                          height: 300,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: ListView.builder(
                                              itemCount: suggestion.data.length,
                                              scrollDirection: Axis.horizontal,
                                              itemBuilder: (context, index) {
                                                return GestureDetector(
                                                  onTap: (){
                                                     ref
                                        .read(songStateProvider.notifier)
                                        .stopSong();
                                    Navigator.push(
                                        context,
                                        CupertinoPageRoute(
                                            builder: (context) =>
                                                PeticulerSongScrollable(
                                                  id: suggestion
                                                      .data[index].id.oid,
                                                  image: suggestion
                                                      .data[index].image,
                                                  song: suggestion
                                                      .data[index].songsaudio,
                                                  name: suggestion
                                                      .data[index].name,
                                                  singer: suggestion
                                                      .data[index].singer,
                                                  shortSinger: response!.data!.singer!.split('|').first.trim(),
                                                )));
                                                  },
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(8.0),
                                                    child: SizedBox(
                                                      height: 280,
                                                      width: 150,
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Container(
                                                            height: 150,
                                                            width: 150,
                                                            decoration: BoxDecoration(
                                                                color:
                                                                    Colors.grey.shade600,
                                                                image: DecorationImage(
                                                                    image: NetworkImage(
                                                                        suggestion
                                                                            .data[
                                                                                index]
                                                                            .image),
                                                                    fit: BoxFit
                                                                        .cover),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5)),
                                                          ),
                                                          SizedBox(
                                                            height: 10,
                                                          ),
                                                          Flexible(
                                                              child: Text(
                                                            suggestion
                                                                .data[index].name,
                                                            overflow:
                                                                TextOverflow.clip,
                                                            textAlign:
                                                                TextAlign.left,
                                                            style: GoogleFonts
                                                                .montserrat(
                                                                    color: Colors
                                                                        .white,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize: 15),
                                                          )),
                                                          SizedBox(
                                                            height: 2,
                                                          ),
                                                          Flexible(
                                                              child: Text(
                                                            suggestion.data[index]
                                                                .singer,
                                                            overflow: TextOverflow
                                                                .ellipsis,
                                                            style: GoogleFonts
                                                                .montserrat(
                                                                    color: Colors
                                                                        .grey,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize: 12),
                                                          ))
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              }),
                                        ),
                                      ],
                                    );
                                  },
                                  error: (stack, err) {
                                    return SizedBox();
                                  },
                                  loading: () => SizedBox()),
                              SizedBox(
                                height: 50,
                              ),
                            ],
                          );
                        },
                        error: (stack, err) {
                          return Text("");
                        },
                        loading: () => SizedBox()),
                  ],
                ),
              ),
            );
          },
          error: (stack, err) {
            return Center(
                child: Text(
              err.toString(),
              style: TextStyle(color: Colors.white),
            ));
          },
          loading: () => Center(
              child: LoadingAnimationWidget.staggeredDotsWave(
                  color: Colors.white, size: 40))),
    );
  }
}
