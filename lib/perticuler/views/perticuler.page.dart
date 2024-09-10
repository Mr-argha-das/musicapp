import 'dart:developer';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
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
    return PlaySongPage(
      shortsinger: widget.shortSinger,
      image: widget.image,
      song: widget.song,
      name: widget.name,
      singer: widget.singer,
    );
  }
}

// class PerticulerSongPage extends ConsumerStatefulWidget {
//   final String shortsinger;
//   final String image;
//   final String song;
//   final String name;
//   final String singer;
//   const PerticulerSongPage({
//     super.key,
//     required this.shortsinger,
//     required this.image,
//     required this.song,
//     required this.name,
//     required this.singer,
//   });

//   @override
//   _PerticulerSongPageState createState() => _PerticulerSongPageState();
// }

// class _PerticulerSongPageState extends ConsumerState<PerticulerSongPage> {
//   bool _isplaying = false;
//   @override
//   final service = HomeSerivce(createDio());

//   @override
//   void initState() {
//     super.initState();

//     _initialize();

//     _isplaying = true;
//   }

//   Future<void> _initialize() async {
//     // Use a Future to initialize data or perform actions
//     await Future.delayed(Duration.zero); // Simulate delay
//     final mediaItem = MediaItem(
//       id: '${widget.image}',
//       album: '',
//       title: '${widget.name}',
//       artist: '${widget.singer}',
//       artUri: Uri.parse('${widget.image}'),
//     );
//     List<MediaItem> mediaList = [];
//     SongsBySingerModel futureAlbum = await service
//         .getSong(SongsBySingerModelbody(singername: widget.shortsinger));
//     for (int i = 0; i < futureAlbum.data.length; i++) {
//       if (futureAlbum.data[i].image != widget.image) {
//         mediaList.addAll([
//           MediaItem(
//               id: futureAlbum.data[i].image,
//               album: '',
//               title: futureAlbum.data[i].name,
//               artist: futureAlbum.data[i].singer,
//               extras: {'url': futureAlbum.data[i].songsaudio},
//               artUri: Uri.parse(futureAlbum.data[i].image))
//         ]);
//       }
//     }
//     // Ensure state modification ha ppens outside of the widget lifecycle methods
//     if (mediaList.isNotEmpty) {
//       ref.read(songStateProvider.notifier).addToQueue(mediaList);
//       ref.read(songStateProvider.notifier).playSong(mediaItem, widget.song);
//     } else {
//       log("nhi hai");
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final songController = ref.read(songStateProvider.notifier);

//     final songState = ref.watch(songStateProvider);

//     // if (songState.currentSong == null ||
//     //     songState.currentSong!.id != mediaItem.id) {
//     //   log(mediaList.length.toString());

//     //   songController.addToQueue(mediaList);

//     // }

//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: Container(
//         height: MediaQuery.of(context).size.height,
//         width: MediaQuery.of(context).size.width,
//         decoration: BoxDecoration(
//             image: DecorationImage(
//                 image: NetworkImage(widget.image), fit: BoxFit.fitHeight)),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             const Expanded(child: SizedBox()),
//             Expanded(
//                 child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Container(
//                     height: 250,
//                     width: MediaQuery.of(context).size.width,
//                     decoration: BoxDecoration(
//                         color: Colors.black54,
//                         borderRadius: BorderRadius.circular(10),
//                         boxShadow: const [
//                           BoxShadow(
//                               color: Colors.black54,
//                               spreadRadius: 1,
//                               blurRadius: 12,
//                               offset: Offset(4, 4))
//                         ]),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Text(
//                             widget.name,
//                             style: GoogleFonts.montserrat(
//                                 color: Colors.white,
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 25),
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.only(left: 8),
//                           child: Text(
//                             widget.singer,
//                             style: GoogleFonts.montserrat(
//                                 color: Colors.white,
//                                 fontWeight: FontWeight.w600,
//                                 fontSize: 15),
//                           ),
//                         ),
//                         SizedBox(
//                           height: 100,
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             children: [
//                               Expanded(
//                                 child: Center(
//                                   child: Container(
//                                       decoration: BoxDecoration(
//                                           color: Colors.black,
//                                           borderRadius:
//                                               BorderRadius.circular(500)),
//                                       child: const Padding(
//                                         padding: EdgeInsets.all(8.0),
//                                         child: Icon(
//                                           Icons.arrow_back_ios,
//                                           color: Colors.white,
//                                           size: 28,
//                                         ),
//                                       )),
//                                 ),
//                               ),
//                               Expanded(
//                                   child: Center(
//                                 child: Padding(
//                                   padding: EdgeInsets.all(8.0),
//                                   child: GestureDetector(
//                                       onTap: () {
//                                         setState(() {
//                                           _isplaying = !_isplaying;
//                                         });
//                                         if (_isplaying == true) {
//                                           songController.resume();
//                                         } else {
//                                           songController.pause();
//                                         }
//                                       },
//                                       child: Icon(
//                                         _isplaying == false
//                                             ? Icons.play_arrow_outlined
//                                             : Icons.stop_circle_outlined,
//                                         color: Colors.white,
//                                         size: 40,
//                                       )),
//                                 ),
//                               )),
//                               Expanded(
//                                   child: Center(
//                                 child: Container(
//                                     decoration: BoxDecoration(
//                                         color: Colors.black,
//                                         borderRadius:
//                                             BorderRadius.circular(500)),
//                                     child: const Padding(
//                                       padding: EdgeInsets.all(8.0),
//                                       child: Icon(
//                                         Icons.arrow_forward_ios,
//                                         color: Colors.white,
//                                         size: 28,
//                                       ),
//                                     )),
//                               ))
//                             ],
//                           ),
//                         ),
//                         // Slider(
//                         //   min: 0,
//                         //   max: SongService.duration.inMilliseconds.toDouble(),
//                         //   value:
//                         //       SongService.position.inMilliseconds.toDouble() -
//                         //           1,
//                         //   onChanged: (value) {
//                         //     setState(() {
//                         //       SongService.player
//                         //           .seek(Duration(milliseconds: value.toInt()));
//                         //     });
//                         //   },
//                         // ),
//                       ],
//                     ),
//                   ),
//                 )
//               ],
//             ))
//           ],
//         ),
//       ),
//     );
//   }
// }

Color primaryCol = Colors.transparent; // Maroon

int selectedSongIndex = 1;

class PlaySongPage extends ConsumerStatefulWidget {
  final String shortsinger;
  final String image;
  final String song;
  final String name;
  final String singer;

  PlaySongPage(
      {super.key,
      required this.shortsinger,
      required this.image,
      required this.song,
      required this.name,
      required this.singer});
  @override
  _PlaySongPageState createState() => _PlaySongPageState();
}

class _PlaySongPageState extends ConsumerState<PlaySongPage> {
  bool isFavorite = false; // Declare isFavorite as a state variable
  double currentTime = 0; // Current playback time in seconds
  final double maxTime =
      240; // Total song duration in seconds (e.g., 4 minutes)
  Timer? timer;

  @override
  void initState() {
    super.initState();
    _initialize();
    startTimer();
  }

  final service = HomeSerivce(createDio());
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
    List<MediaItem> mediaList2 = [];
    SongsBySingerModel futureAlbum = await service
        .getSong(SongsBySingerModelbody(singername: widget.shortsinger));
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
    ref.read(songStateProvider.notifier).playSong(mediaItem, widget.song);
    ref.read(currentSongRecomandationProvider.notifier).remove();
    ref.read(currentSongRecomandationProvider.notifier).setdata(mediaList2);
  }

  // Starts the timer to simulate the song playback
  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (Timer t) {
      setState(() {
        if (currentTime < maxTime) {
          currentTime++;
        } else {
          t.cancel();
        }
      });
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  // Format time from seconds to MM:SS
  String formatTime(double seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = (seconds % 60).toInt();
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    final songController = ref.read(songStateProvider.notifier);

    final songState = ref.watch(songStateProvider);
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.black,
      appBar: _homeAppBar(),
      body: songState.currentSong == null
          ? Center(
              child: LoadingAnimationWidget.staggeredDotsWave(
                  color: Colors.white, size: 22),
            )
          : _homeBody(),
      bottomNavigationBar: homeBottomMenu(),
    );
  }

  SizedBox homeBottomMenu() {
    final songController = ref.read(songStateProvider.notifier);

    final songState = ref.watch(songStateProvider);

    return SizedBox(
      height: 120,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
                child: const Icon(
                  Icons.shuffle,
                  color: Colors.white,
                ),
                onTap: () {
                  songController.shuffle();
                }),
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    songController.playPreviousSong();
                  },
                  child: const Icon(
                    Icons.fast_rewind,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 20),
                GestureDetector(
                  onTap: () {
                    if (songState.isPlaying == true) {
                      songController.pause();
                    } else {
                      songController.resume();
                    }
                  },
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.white24,
                          offset: Offset(0, 10),
                          blurRadius: 15,
                        ),
                      ],
                    ),
                    child: Icon(
                      songState.isPlaying == true
                          ? Icons.pause_circle_filled
                          : Icons.play_arrow_rounded,
                      color: Colors.white,
                      size: 60,
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                GestureDetector(
                  onTap: () {
                    songController.playNextSong();
                  },
                  child: const Icon(
                    Icons.fast_forward,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            InkWell(
                child: const Icon(
                  Icons.toc,
                  color: Colors.white,
                ),
                onTap: () {}),
          ],
        ),
      ),
    );
  }

  Widget _homeBody() {
    final songController = ref.read(songStateProvider.notifier);

    final songState = ref.watch(songStateProvider);
    final currentSong = songState.totalPlayTime;

    final duration = currentSong.inSeconds.toDouble();
    // final recomandeationsog = ref.watch();
    final songList = ref.watch(currentSongRecomandationProvider);
    log(duration.toString());
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: 275,
                height: 390,
                decoration: BoxDecoration(
                  color: Colors.black,
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.white30,
                      offset: Offset(0, 20),
                      blurRadius: 30,
                    ),
                  ],
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(200),
                    bottomRight: Radius.circular(200),
                  ),
                  image: DecorationImage(
                    colorFilter:
                        ColorFilter.mode(primaryCol, BlendMode.multiply),
                    fit: BoxFit.cover,
                    image: NetworkImage(songState.currentSong!.id),
                  ),
                ),
              ),
              Positioned(
                bottom: -45,
                left: -40,
                child: SleekCircularSlider(
                  min: 0, // Song start time
                  max: duration, // Song end time (duration)
                  initialValue: songState.currentPosition.inSeconds
                      .toDouble(), // Current playback position
                  appearance: CircularSliderAppearance(
                    size: 360,
                    counterClockwise: true,
                    startAngle: 150,
                    angleRange: 120,
                    customWidths: CustomSliderWidths(
                      trackWidth: 3,
                      progressBarWidth: 10,
                      shadowWidth: 0,
                    ),
                    customColors: CustomSliderColors(
                      trackColor: Colors.white12,
                      progressBarColor: Colors.white,
                    ),
                    infoProperties: InfoProperties(
                      mainLabelStyle: const TextStyle(
                        color: Colors.transparent,
                      ),
                      modifier: (double value) {
                        return formatTime(
                            value); // Display current time in MM:SS format
                      },
                    ),
                  ),
                  onChange: (double value) {
                    setState(() {
                      currentTime = value; // Update current time
                    });
                  },
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              formatTime(songState.currentPosition.inSeconds.toDouble()),
              style: const TextStyle(color: Colors.white, fontSize: 15),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                songState.currentSong!.title,
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                songState.currentSong!.artist.toString(),
                style: GoogleFonts.lato(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          if (songList.data != null)
            Center(
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: songList.data!.length,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return SizedBox(
                        height: 80,
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              height: 65,
                              width: 65,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          songList.data![index].id.toString()),
                                      fit: BoxFit.cover)),
                            ),
                            new SizedBox(
                              width: 15,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  songList.data![index].title.toString(),
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
                            if (songState.currentSong!.id ==
                                songList.data![index].id) ...[
                              Expanded(
                                  child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.asset("assets/BHFO.gif"),
                                  SizedBox(
                                    width: 30,
                                  )
                                ],
                              )),
                            ]
                          ],
                        ),
                      );
                    })),
          SizedBox(
            height: 300,
          )
        ],
      ),
    );
  }

  AppBar _homeAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      leading: IconButton(
        icon: Icon(
          Icons.chevron_left,
          color: Colors.white,
          size: 35,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      actions: [
        GestureDetector(
          onTap: () {
            setState(() {
              isFavorite = !isFavorite; // Toggle favorite status
            });
          },
          child: Padding(
            padding:
                const EdgeInsets.all(8.0), // Add padding to increase tap area
            child: AnimatedContainer(
              duration: Duration(milliseconds: 300), // Animation duration
              curve: Curves.easeInOut, // Animation curve
              child: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border_outlined,
                size: 35, // Size of the heart icon
                color: isFavorite
                    ? Colors.red
                    : Colors.grey.shade600, // Change color on tap
              ),
            ),
          ),
        ),
      ],
    );
  }
}

///////
///
class LyricsScreen extends ConsumerStatefulWidget {
  @override
  _LyricsScreenState createState() => _LyricsScreenState();
}

class _LyricsScreenState extends ConsumerState<LyricsScreen> {
  final String lyrics = '''
O Billo Ni Eh Jatt Mehkma
Poora Fatte Chak Mehkma
Tere Sheher Vich Khauff Yaar Da
Punda Phire Dhakk Mehkma

Soch Ton Vi Paar Chalde
Naal Jede Yaar Chalde
Kaale Karobaar Chalde
Te Dinda Naio Fuck Mekhma

O Billo Ni Eh Jatt Mehkma
Poora Fatte Chak Mehkma
Tere Sheher Vich Khauff Yaar Da
Punda Phire Dhakk Mehkma

O Billo Ni Eh Jatt Mehkma
Poora Fatte Chak Mehkma
Tere Sheher Vich Khauff Yaar Da
Punda Phire Dhakk Mehkma

Yaari Bahmnaa Naal Pakki Jatt Di
Kaali Caddi Lucky Jatt Di
Nit Hi Threat Milde
Akh Poori Shakki Jatt Di

Tadke Hi Maal Chhak Le
Yaar Beli Naal Chakle
Chamber Ch Raund Dhakk Le
Keda Lau Ga Dak Mehkma

O Billo Ni Eh Jatt Mehkma
Poora Fatte Chak Mehkma
Tere Sheher Vich Khauff Yaar Da
Punda Phire Dhakk Mehkma

Samjeya Chala Si Attach Ni Me Hoya
Karde Si Kaabu Par Catch Ni Me Hoya
Ohi Ohi Yaar Bus Kar Ge Gadari
Jinna Jinna Kolo Encash Ni Me Hoya

Chup Mere Ajj Vi Satuandi Ohna Nu
Yaad Meri Ajj Vi Rawaundi Ohna Nu
Karde O Firde Group Baaziyaan
Chadai Meri Ajj Vi Tapaundi Ohna Nu

Panjeya Te Keete Hoye Aa Oh Beh Ke Kithon Aun
Sabar Ni Pal Da Oh Seh Ke Kithon Aun
Paise Naal Mull Naio Mildi Class
Mere Jeha Rutba Oh Laike Kithon Aun

Asle Naal Mag Peya Dash Uttey
Ferrariyaan Da Joda Chakka Cash Uttey
Oh Firde A Sheher Tere Kam Piche
Te Jatt Ethe Aaya Hoya Aish Uttey

O Billo Ni Eh Jatt Mehkma
Poora Fatte Chak Mehkma
Tere Sheher Vich Khauff Yaar Da
Punda Phire Dhakk Mehkma

Soch Ton Vi Paar Chalde
Naal Jede Yaar Chalde
Kaale Karobaar Chalde
Te Dinda Naio Fuck Mekhma

O Billo Ni Eh Jatt Mehkma
Poora Fatte Chak Mehkma
Tere Sheher Vich Khauff Yaar Da
Punda Phire Dhakk Mehkma

O Billo Ni Eh Jatt Mehkma
Poora Fatte Chak Mehkma
Tere Sheher Vich Khauff Yaar Da
Punda Phire Dhakk Mehkma
''';

  // Mock current line index
  int currentLineIndex = 0;

  // Split lyrics into a list of lines
  List<String> get lyricsLines => lyrics.split('\n');

  @override
  Widget build(BuildContext context) {
    final songController = ref.read(songStateProvider.notifier);

    final songState = ref.watch(songStateProvider);
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: ListView.builder(
          itemCount: lyricsLines.length,
          itemBuilder: (context, index) {
            // Highlight the current line
            bool isCurrentLine = index == currentLineIndex;
            return AnimatedContainer(
              duration: Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              padding: EdgeInsets.symmetric(vertical: 5),
              child: Text(
                lyricsLines[index],
                textAlign: TextAlign.center,
                style: GoogleFonts.lato(
                  fontSize: isCurrentLine ? 18 : 16,
                  fontWeight:
                      isCurrentLine ? FontWeight.bold : FontWeight.normal,
                  height: 1.5,
                  color: isCurrentLine ? Colors.white : Colors.white54,
                ),
              ),
            );
          },
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: _nextLine, // Simulates moving to the next line
      //   child: Icon(Icons.play_arrow),
      //   backgroundColor: Colors.green,
      // ),
    );
  }

  // Mock function to simulate highlighting the next line
  void _nextLine() {
    setState(() {
      if (currentLineIndex < lyricsLines.length - 1) {
        currentLineIndex++;
      } else {
        currentLineIndex = 0; // Restart for demonstration purposes
      }
    });
  }
}
