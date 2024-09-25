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
import 'package:speech_to_text/speech_to_text.dart';

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
            response?.data.shuffle();
            return Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(color: Colors.black),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: response!.data.length+1,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(left: 0, right: 00),
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
                                              image: NetworkImage(response
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
                                          response.data![index].singer
                                              .toString(),
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 16),
                                        ),
                                        Text(
                                          response.data[index].singer
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
                                      // GestureDetector(
                                      //   onTap: () {
                                      //     ref
                                      //         .read(songStateProvider.notifier)
                                      //         .playQuaae(index);
                                      //   },
                                      //   child: Icon(
                                         
                                      //   ),
                                      // ),
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
                        })
                  ],
                ),
              ),
            );
          },
          error: (stack, err) {
            return Center(child: Text(err.toString(), style: TextStyle(color: Colors.white),));
          },
          loading: () => Center(
              child: LoadingAnimationWidget.staggeredDotsWave(
                  color: Colors.white, size: 40))),
    );
  }
}
