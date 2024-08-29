import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:just_audio/just_audio.dart';
import 'package:musicproject/main.dart';
import 'package:musicproject/perticuler/service/song.play.service.dart';

class PerticulerSongPage extends StatefulWidget {
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
  State<PerticulerSongPage> createState() => _PerticulerSongPageState();
}

class _PerticulerSongPageState extends State<PerticulerSongPage> {
  bool _isplaying = false;
  @override
  Widget build(BuildContext context) {
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
                    height: 200,
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
                                          final mediaItem = MediaItem(
                                            id: '${widget.song}',
                                            album: '',
                                            title: '${widget.name}',
                                            artist: '${widget.singer}',
                                            artUri:
                                                Uri.parse('${widget.image}'),
                                          );
                                          SongService.playSong(
                                              mediaItem, "${widget.song}");
                                        } else {
                                          SongService.stopSong();
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
                        )
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


// bottomSheet: Container(
//         height: 50,
//         color: Colors.grey.shade900,
//         child: Center(
//           child: IconButton(
//             onPressed: () async {
//               // Define the playlist
// //               

// // // Creating an AudioSource with MediaItem as tag
// //               final audioSource = AudioSource.uri(
// //                 Uri.parse('${widget.song}'),
// //                 tag: mediaItem,
// //               );
// //               final player = AudioPlayer(); // Create a player
// // // Adding the AudioSource to the player
// //               await player.setVolume(100);
// //               await player.setAudioSource(audioSource);
// //               await player.play();
//             },
//             icon: const Icon(
//               Icons.play_arrow_outlined,
//               color: Colors.white,
//             ),
//           ),
//         ),
      // ),