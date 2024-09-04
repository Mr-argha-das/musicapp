import 'dart:developer';

import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:musicproject/config/pretty.dio.dart';
import 'package:musicproject/home/moodels/song.search.model.dart';
import 'package:musicproject/home/moodels/songs.model.dart';
import 'package:musicproject/home/service/home.service.dart';

import 'package:musicproject/perticuler/service/song.controller.dart';

class PeticulerSongScrollable extends ConsumerStatefulWidget {
  final String id;
  final String image;
  final String song;
  final String name;
  final String singer;
  final String shortSinger;
  const PeticulerSongScrollable(
      {super.key,
      required this.shortSinger, 
      required this.id,
      required this.image,
      required this.song,
      required this.name,
      required this.singer});

  @override
  _PeticulerSongScrollableState createState() =>
      _PeticulerSongScrollableState();
}

class _PeticulerSongScrollableState
    extends ConsumerState<PeticulerSongScrollable> {
  @override
  Widget build(BuildContext context) {
    return PerticulerSongPage(
      image: "${widget.image}",
      song: "${widget.song}",
      name: "${widget.name}",
      singer: "${widget.singer}", shortsinger: widget.shortSinger,
    );
  }
}

class PerticulerSongPage extends ConsumerStatefulWidget {
  final String shortsinger;
  final String image;
  final String song;
  final String name;
  final String singer;
  const PerticulerSongPage( {
    
    super.key,
    required this.shortsinger,
    required this.image,
    required this.song,
    required this.name,
    required this.singer,
  });

  @override
  _PerticulerSongPageState createState() => _PerticulerSongPageState();
}

class _PerticulerSongPageState extends ConsumerState<PerticulerSongPage> {
  bool _isplaying = false;
  @override
  final service = HomeSerivce(createDio());

  @override
  void initState() {
    super.initState();

    _initialize();

    _isplaying = true;
  }

  Future<void> _initialize() async {
    // Use a Future to initialize data or perform actions
    await Future.delayed(Duration.zero); // Simulate delay
    final mediaItem = MediaItem(
      id: '${widget.image}',
      album: '',
      title: '${widget.name}',
      artist: '${widget.singer}',
      artUri: Uri.parse('${widget.image}'),
    );
    List<MediaItem> mediaList = [];
    SongsBySingerModel futureAlbum = await service
        .getSong(SongsBySingerModelbody(singername: widget.shortsinger));
    for (int i = 0; i < futureAlbum.data.length; i++) {
      if(futureAlbum.data[i].image != widget.image){
        mediaList.addAll([
        MediaItem(
            id: futureAlbum.data[i].image,
            album: '',
            title: futureAlbum.data[i].name,
            artist: futureAlbum.data[i].singer,
            extras: {'url': futureAlbum.data[i].songsaudio},
            artUri: Uri.parse(futureAlbum.data[i].image))
      ]);
      }
    }
    // Ensure state modification ha ppens outside of the widget lifecycle methods
    if (mediaList.isNotEmpty) {
      ref.read(songStateProvider.notifier).addToQueue(mediaList);
      ref.read(songStateProvider.notifier).playSong(mediaItem, widget.song);
    } else {
      log("nhi hai");
    }
  }

  @override
  Widget build(BuildContext context) {
    final songController = ref.read(songStateProvider.notifier);

    final songState = ref.watch(songStateProvider);

    // if (songState.currentSong == null ||
    //     songState.currentSong!.id != mediaItem.id) {
    //   log(mediaList.length.toString());

    //   songController.addToQueue(mediaList);

    // }
    

    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(widget.image), fit: BoxFit.fitHeight)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Expanded(child: SizedBox()),
            Expanded(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 250,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: Colors.black54,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: const [
                          BoxShadow(
                              color: Colors.black54,
                              spreadRadius: 1,
                              blurRadius: 12,
                              offset: Offset(4, 4))
                        ]),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            widget.name,
                            style: GoogleFonts.montserrat(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 25),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: Text(
                            widget.singer,
                            style: GoogleFonts.montserrat(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 15),
                          ),
                        ),
                        SizedBox(
                          height: 100,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Center(
                                  child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.black,
                                          borderRadius:
                                              BorderRadius.circular(500)),
                                      child: const Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Icon(
                                          Icons.arrow_back_ios,
                                          color: Colors.white,
                                          size: 28,
                                        ),
                                      )),
                                ),
                              ),
                              Expanded(
                                  child: Center(
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _isplaying = !_isplaying;
                                        });
                                        if (_isplaying == true) {
                                          songController.resume();
                                        } else {
                                          songController.pause();
                                        }
                                      },
                                      child: Icon(
                                        _isplaying == false
                                            ? Icons.play_arrow_outlined
                                            : Icons.stop_circle_outlined,
                                        color: Colors.white,
                                        size: 40,
                                      )),
                                ),
                              )),
                              Expanded(
                                  child: Center(
                                child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.black,
                                        borderRadius:
                                            BorderRadius.circular(500)),
                                    child: const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Icon(
                                        Icons.arrow_forward_ios,
                                        color: Colors.white,
                                        size: 28,
                                      ),
                                    )),
                              ))
                            ],
                          ),
                        ),
                        // Slider(
                        //   min: 0,
                        //   max: SongService.duration.inMilliseconds.toDouble(),
                        //   value:
                        //       SongService.position.inMilliseconds.toDouble() -
                        //           1,
                        //   onChanged: (value) {
                        //     setState(() {
                        //       SongService.player
                        //           .seek(Duration(milliseconds: value.toInt()));
                        //     });
                        //   },
                        // ),
                      ],
                    ),
                  ),
                )
              ],
            ))
          ],
        ),
      ),
    );
  }
}
