import 'dart:ui';

import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:marquee_text/marquee_text.dart';
import 'package:musicproject/config/pretty.dio.dart';
import 'package:musicproject/home/moodels/song.search.model.dart';
import 'package:musicproject/home/moodels/songs.model.dart';
import 'package:musicproject/home/service/home.service.dart';
import 'package:musicproject/home/views/home.page.dart';
import 'package:musicproject/perticuler/service/song.controller.dart';
import 'package:palette_generator/palette_generator.dart';

import '../../home/controller/home.controller.dart';

class Perticulerplaylistpage extends ConsumerStatefulWidget {
  final String singer;
  final String image;
  const Perticulerplaylistpage(
      {super.key, required this.singer, required this.image});

  @override
  _PerticulerplaylistpageState createState() => _PerticulerplaylistpageState();
}

class _PerticulerplaylistpageState
    extends ConsumerState<Perticulerplaylistpage> {
  Color _dominantColor = Colors.white; // Default color
  Color _secondaryColor = Colors.grey; // Default secondary color
  @override
  void initState() {
    super.initState();
    _getImageDominantColor();
    _initialize();
  }

  bool isExapnded = false;
  Future<void> _getImageDominantColor() async {
    final imageProvider = NetworkImage(widget.image.toString());
    final paletteGenerator = await PaletteGenerator.fromImageProvider(
      imageProvider,
      maximumColorCount: 20,
    );

    setState(() {
      _dominantColor = paletteGenerator.dominantColor?.color ?? Colors.white;
      // Optionally, you can use the `Vibrant` color or any other color from the palette
      _secondaryColor =
          paletteGenerator.lightVibrantColor?.color ?? Colors.grey;
    });
  }

  final service = HomeSerivce(createDio());
  Future<void> _initialize() async {
    // Use a Future to initialize data or perform actions
    await Future.delayed(Duration.zero); // Simulate delay

    List<MediaItem> mediaList = [];
    List<MediaItem> mediaList2 = [];
    SongsBySingerModel futureAlbum = await service
        .getSong(SongsBySingerModelbody(singername: widget.singer));
    for (int i = 0; i < futureAlbum.data.length; i++) {
      if (futureAlbum.data[i].image != widget.image) {
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
      mediaList2.addAll([
        MediaItem(
            id: futureAlbum.data[i].image,
            album: '',
            title: futureAlbum.data[i].name,
            artist: futureAlbum.data[i].singer,
            extras: {'url': futureAlbum.data[i].songsaudio},
            artUri: Uri.parse(futureAlbum.data[i].image))
      ]);
    }
    ref.read(songStateProvider.notifier).addToQueue(mediaList);

    ref.read(currentSongRecomandationProvider.notifier).remove();
    ref.read(currentSongRecomandationProvider.notifier).setdata(mediaList2);
  }

  bool isPlaying = false;
  bool expandesong = false;
  @override
  Widget build(BuildContext context) {
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
    bool checkSong(index) {
      bool value = false;
      if (songState.currentSong!.id == songList.data![index].id &&
          songState.isPlaying == true) {
        value = true;
      } else {
        value = false;
      }
      return value;
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            )),
        centerTitle: true,
        title: Text(
          "Artist",
          style: GoogleFonts.montserrat(
              color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      backgroundColor: Colors.black,
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: ListView(
          scrollDirection: Axis.vertical,
          children: [
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 150,
                  width: 150,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(widget.image), fit: BoxFit.cover),
                      color: Colors.grey.shade700,
                      borderRadius: BorderRadius.circular(500)),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                  child: Text(
                    widget.singer.toString(),
                    overflow: TextOverflow.clip,
                    style: GoogleFonts.montserrat(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.w900),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    ref.read(songStateProvider.notifier).shuffle();
                  },
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.white)),
                    child: const Center(
                      child: Center(
                          child: Icon(
                        Icons.shuffle,
                        color: Colors.green,
                      )),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                Container(
                  height: 50,
                  width: 123,
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.white)),
                  child: Center(
                    child: Center(
                      child: Text(
                        "Follow",
                        overflow: TextOverflow.clip,
                        style: GoogleFonts.montserrat(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w900),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                GestureDetector(
                  onTap: () {
                    if (songState.currentSong == null) {
                      setState(() {
                        isPlaying = true;
                      });
                      ref.read(songStateProvider.notifier).playQuaae(0);
                    } else {
                      if (isPlaying == true) {
                        setState(() {
                          isPlaying = false;
                        });
                        ref.read(songStateProvider.notifier).pause();
                      } else {
                        setState(() {
                          isPlaying = true;
                        });
                        ref.read(songStateProvider.notifier).resume();
                      }
                    }
                  },
                  child: AnimatedContainer(
                    duration: Duration(seconds: 0),
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius:
                            BorderRadius.circular(isPlaying ? 10 : 500),
                        border: Border.all(color: Colors.white, width: 0.1)),
                    child: Center(
                      child: Center(
                          child: Icon(
                        isPlaying == true
                            ? Icons.pause
                            : Icons.play_arrow_rounded,
                        size: 28,
                      )),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(17.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "POPULAR",
                    overflow: TextOverflow.clip,
                    style: GoogleFonts.montserrat(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w900),
                  ),
                ],
              ),
            ),
            if (songList.data != null)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: expandesong == false ? 3 : songList.data!.length,
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
                                      borderRadius: BorderRadius.circular(10),
                                      image: DecorationImage(
                                          image: NetworkImage(songList
                                              .data![index].id
                                              .toString()),
                                          fit: BoxFit.cover)),
                                ),
                              ),
                              new SizedBox(
                                width: 15,
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      songList.data![index].title.toString(),
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                          color: Colors.white, fontSize: 16),
                                    ),
                                    Text(
                                      songList.data![index].artist.toString(),
                                      style: TextStyle(
                                          color: Colors.white54, fontSize: 11),
                                    )
                                  ],
                                ),
                              ),
                              Expanded(
                                  child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      ref
                                          .read(songStateProvider.notifier)
                                          .playQuaae(index);
                                    },
                                    child: Icon(
                                      checkSong(index)
                                          ? Icons.pause
                                          : Icons.play_arrow_rounded,
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
                    }),
              ),
            if (expandesong == false) ...[Padding(
              padding: const EdgeInsets.only(left: 17.0),
              child: InkWell(
                onTap: (){
                  expandesong = true;
                },
                child: Text("SEE MORE", style: GoogleFonts.montserrat(fontWeight: FontWeight.bold ,color: Colors.white, fontSize: 15),)),
            )],
            SizedBox(
              height: 300,
            )
          ],
        ),
      ),
      floatingActionButton: Container(
        height: songState.currentSong == null
            ? 72
            : isExapnded == true
                ? 600
                : 150,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (isExapnded == true) ...[
              SongAllTab(
                callBack: () {
                  setState(() {
                    isExapnded = !isExapnded;
                  });
                },
              )
            ],
            if (songState.currentSong != null) ...[
              GestureDetector(
                onTap: () {
                  setState(() {
                    isExapnded = !isExapnded;
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: Container(
                    decoration: BoxDecoration(
                        boxShadow: const [
                          BoxShadow(
                              color: Colors.black,
                              spreadRadius: 1,
                              blurRadius: 14,
                              offset: Offset(4, 4))
                        ],
                        color: Colors.grey.shade900,
                        borderRadius: BorderRadius.circular(500)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Expanded(
                              child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(
                                  Icons.favorite_border,
                                  color: Colors.white,
                                ),
                              )
                            ],
                          )),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                songState.currentSong!.title,
                                style: const TextStyle(
                                  fontSize:
                                      16, // Responsive font size for the title
                                  color: Colors.white,
                                ),
                                textAlign: TextAlign.left,
                                overflow:
                                    TextOverflow.fade, // Center-align text
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width - 150,
                                child: MarqueeText(
                                  alwaysScroll: true,
                                  text: TextSpan(
                                    text: songState.currentSong!.artist,
                                  ),
                                  style: const TextStyle(
                                    fontSize: 13,
                                    color: Colors.white,
                                  ),
                                  speed: 10,
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SpiningCirculerContainer(
                              height: 42,
                              width: 42,
                              imagepath: songState.currentSong!.id,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
            new SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}




// Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Container(
//                   height: 65,
//                   width: MediaQuery.of(context).size.width,
//                   decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(15),
//                       color: Colors.grey.shade900,
//                       border: Border.all(color: _secondaryColor, width: 2)),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       InkWell(
//                           child: const Icon(
//                             Icons.shuffle_outlined,
//                             color: Colors.green,
//                             size: 34,
//                           ),
//                           onTap: () {
//                             songController.shuffle();
//                           }),
//                       const SizedBox(
//                         width: 20,
//                       ),
//                       GestureDetector(
//                         onTap: () {
//                           if (songState.isPlaying == true) {
//                             songController.pause();
//                           } else {
//                             songController.resume();
//                           }
//                         },
//                         child: Container(
//                           width: 60,
//                           height: 60,
//                           decoration: const BoxDecoration(
//                             shape: BoxShape.circle,
//                             boxShadow: [
//                               BoxShadow(
//                                 color: Colors.white24,
//                                 offset: Offset(0, 5),
//                                 blurRadius: 10,
//                               ),
//                             ],
//                           ),
//                           child: Icon(
//                             songState.isPlaying == true
//                                 ? Icons.pause_circle_filled
//                                 : Icons.play_arrow_rounded,
//                             color: Colors.white,
//                             size: 60,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
