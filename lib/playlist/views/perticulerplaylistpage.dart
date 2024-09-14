import 'dart:ui';

import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:musicproject/config/pretty.dio.dart';
import 'package:musicproject/home/moodels/song.search.model.dart';
import 'package:musicproject/home/moodels/songs.model.dart';
import 'package:musicproject/home/service/home.service.dart';
import 'package:musicproject/perticuler/service/song.controller.dart';
import 'package:palette_generator/palette_generator.dart';

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
    // ref.read(songStateProvider.notifier).playSong(mediaItem, widget.song);
    ref.read(currentSongRecomandationProvider.notifier).remove();
    ref.read(currentSongRecomandationProvider.notifier).setdata(mediaList2);
  }

  @override
  Widget build(BuildContext context) {
    final songController = ref.read(songStateProvider.notifier);

    final songState = ref.watch(songStateProvider);
    final currentSong = songState.totalPlayTime;

    final duration = currentSong.inSeconds.toDouble();
    // final recomandeationsog = ref.watch();
    final songList = ref.watch(currentSongRecomandationProvider);
    return Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          alignment: AlignmentDirectional.topStart,
          children: [
            Container(
              height: 250,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [_dominantColor, _secondaryColor],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 250,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          
                          
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Flexible(
                                  child: Text(
                                    widget.singer.toString(),
                                    overflow: TextOverflow.clip,
                                    style:  GoogleFonts.signika(
                                        color: Colors.white, fontSize: 45, fontWeight: FontWeight.w900),
                                  ),
                                ),
                                
                              ],
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                )
              ],
            )
          ],
        ));
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
//               if (songList.data != null)
//                 Center(
//                     child: ListView.builder(
//                         shrinkWrap: true,
//                         itemCount: songList.data!.length,
//                         physics: const NeverScrollableScrollPhysics(),
//                         itemBuilder: (context, index) {
//                           return Padding(
//                             padding: const EdgeInsets.only(left: 10, right: 20),
//                             child: SizedBox(
//                               height: 80,
//                               width: MediaQuery.of(context).size.width,
//                               child: Row(
//                                 mainAxisAlignment: MainAxisAlignment.start,
//                                 crossAxisAlignment: CrossAxisAlignment.center,
//                                 children: [
//                                   Container(
//                                     height: 65,
//                                     width: 65,
//                                     decoration: BoxDecoration(
//                                         borderRadius: BorderRadius.circular(10),
//                                         image: DecorationImage(
//                                             image: NetworkImage(songList
//                                                 .data![index].id
//                                                 .toString()),
//                                             fit: BoxFit.cover)),
//                                   ),
//                                   new SizedBox(
//                                     width: 15,
//                                   ),
//                                   Column(
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       Text(
//                                         songList.data![index].title.toString(),
//                                         style: const TextStyle(
//                                             color: Colors.white, fontSize: 16),
//                                       ),
//                                       Text(
//                                         songList.data![index].artist.toString(),
//                                         style: TextStyle(
//                                             color: Colors.white54,
//                                             fontSize: 11),
//                                       )
//                                     ],
//                                   ),
//                                   // if (songState.currentSong!.id ==
//                                   //     songList.data![index].id) ...[
//                                   //   Expanded(
//                                   //       child: Row(
//                                   //     mainAxisAlignment: MainAxisAlignment.end,
//                                   //     crossAxisAlignment:
//                                   //         CrossAxisAlignment.center,
//                                   //     children: [
//                                   //       Image.asset("assets/BHFO.gif"),
//                                   //       SizedBox(
//                                   //         width: 30,
//                                   //       )
//                                   //     ],
//                                   //   )),
//                                   // ]
//                                 ],
//                               ),
//                             ),
//                           );
//                         })),