import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:musicproject/config/pretty.dio.dart';

import 'package:musicproject/perticuler/service/song.controller.dart';
import 'package:musicproject/search/models/search.model.dart';
import 'package:musicproject/search/service/search.service.dart';

class PeticulerSongScrollable extends ConsumerStatefulWidget {
  final String id;
  final String image;
  final String song;
  final String name;
  final String singer;
  const PeticulerSongScrollable(
      {super.key,
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
  final service = SearchService(createDio());
  late Future<SearchResultModel> futureAlbum;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    futureAlbum = service.searchsong("%7C");
    futureAlbum.then((value) {
      setState(() {
        value.data.insert(
            0,
            Datum(
                id: Id(oid: ""),
                name: widget.name,
                image: widget.image,
                songsaudio: widget.song,
                singer: widget.singer));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: FutureBuilder(
            future: futureAlbum,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return PageView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: snapshot.data!.data.length,
                    itemBuilder: (context, index) {
                      return PerticulerSongPage(
                          image: "${snapshot.data!.data[index].image}",
                          song: "${snapshot.data!.data[index].songsaudio}",
                          name: "${snapshot.data!.data[index].name}",
                          singer: "${snapshot.data!.data[index].singer}",
                          id: "${snapshot.data!.data[index].id.oid}");
                    });
              } else if (snapshot.hasError) {
                return Center(
                  child: Text("${snapshot.error}"),
                );
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            }));
  }
}

class PerticulerSongPage extends ConsumerStatefulWidget {
  final String id;
  final String image;
  final String song;
  final String name;
  final String singer;
  const PerticulerSongPage(
      {super.key,
      required this.image,
      required this.song,
      required this.name,
      required this.singer,
      required this.id});

  @override
  _PerticulerSongPageState createState() => _PerticulerSongPageState();
}

class _PerticulerSongPageState extends ConsumerState<PerticulerSongPage> {
  bool _isplaying = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SongService.player.durationStream.listen((duration) {
      setState(() {
        SongService.duration = duration ?? Duration.zero;
      });
    });

    // Listen to the position of the audio
    SongService.player.positionStream.listen((position) {
      setState(() {
        SongService.position = position;
      });
    });
    _isplaying = true;
    final mediaItem = MediaItem(
      id: '${widget.song}',
      album: '',
      title: '${widget.name}',
      artist: '${widget.singer}',
      artUri: Uri.parse('${widget.image}'),
    );

    SongService.playSong(mediaItem, "${widget.song}");
    setData();
  }

  void setData() {
    setState(() {
      StoreSong.image = widget.image;
      StoreSong.name = widget.name;
      StoreSong.singer = widget.singer;
      StoreSong.song = widget.song;
      StoreSong.isplaying = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 3), () {
      final dataController = ref.read(dataProvider.notifier);
      dataController.state = CurrentSongModel(
          isplaying: true,
          singer: widget.singer,
          id: widget.song,
          image: widget.image,
          song: widget.song,
          name: widget.name);
    });
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
            Expanded(child: SizedBox()),
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
                                          SongService.ruseme();
                                        } else {
                                          SongService.pause();
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
                        Slider(
                          min: 0,
                          max: SongService.duration.inMilliseconds.toDouble(),
                          value:
                              SongService.position.inMilliseconds.toDouble() -
                                  1,
                          onChanged: (value) {
                            setState(() {
                              SongService.player
                                  .seek(Duration(milliseconds: value.toInt()));
                            });
                          },
                        ),
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
