import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:marquee_text/marquee_text.dart';
import 'package:marquee_text/vertical_marquee_text.dart';
import 'package:musicproject/config/pretty.dio.dart';
import 'package:musicproject/home/moodels/song.search.model.dart';
import 'package:musicproject/home/controller/home.controller.dart';
import 'package:musicproject/home/moodels/songs.model.dart';
import 'package:musicproject/home/service/home.service.dart';
import 'package:musicproject/perticuler/service/song.controller.dart';
import 'package:musicproject/perticuler/views/perticuler.page.dart';
import 'package:musicproject/recommended.dart/Likemore.dart';
import 'package:musicproject/recommended.dart/SlowRock.dart';
import 'package:musicproject/recommended.dart/albumList.dart';
import 'package:musicproject/recommended.dart/artistList.dart';
import 'package:musicproject/recommended.dart/recommended.dart';
import 'package:musicproject/search/views/search.page.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  int pageIndex = 0;
  List<Widget> pages = [const HomeSection(), const SearchPage()];
  bool isExapnded = false;
  @override
  Widget build(BuildContext context) {
    final data = ref.watch(dataProvider);

    return Scaffold(
      backgroundColor: Colors.black,
      body: pages[pageIndex],
      floatingActionButton: Container(
        height: data == null && pageIndex != 0
            ? 72
            : isExapnded == true
                ? 600
                : 150,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (isExapnded == true && pageIndex != 0) ...[ SongAllTab(callBack: (){
              setState(() {
                isExapnded = !isExapnded;
              });
          }, data: data!,)],
            if (data != null && pageIndex != 0) ...[
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
                          Expanded(
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
                                "${data!.name}",
                                style: TextStyle(
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
                                    text: data.singer,
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
                              imagepath: data!.image,
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
            Padding(
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
                            blurRadius: 12)
                      ],
                      borderRadius: BorderRadius.circular(500)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Center(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                pageIndex = 0;
                                isExapnded = false;
                              });
                            },
                            child: const Icon(
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
                            onTap: () {
                              setState(() {
                                pageIndex = 1;
                                isExapnded = false;
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
            )
          ],
        ),
      ),
    );
  }
}

class HomeSection extends ConsumerStatefulWidget {
  const HomeSection({super.key});

  @override
  _HomeSectionState createState() => _HomeSectionState();
}

class _HomeSectionState extends ConsumerState<HomeSection> {
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    final _singerResult = ref.watch(homeSingerProvider);
    final data = ref.watch(dataProvider);
    final songisPlaying = ref.watch(songIsPlayingChecker);
    final isplayingProvider = ref.read(songIsPlayingChecker.notifier);
    return Scaffold(
      backgroundColor: Colors.black,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: ListTile(
          leading: const Icon(
            Icons.menu_open_outlined,
            color: Colors.white,
            size: 30,
          ),
          trailing: GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => const SearchPage(),
                  ));
            },
            child: const Icon(
              Icons.search,
              color: Colors.white,
              size: 30,
            ),
          ),
        ),
      ),
      body: _singerResult.when(data: (snapshot) {
        return SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Container(
                  height: height * 0.10,
                  width: width * 0.9,
                  decoration: const BoxDecoration(
                    color: Colors.black,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: 50,
                          width: 50,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          child: Text(
                            "Hey Hey Hey",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              if (data != null) ...[
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                  child: Container(
                    height: height * 0.11,
                    width: width,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade900,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SpiningCirculerContainer(
                            height: 75,
                            width: 75,
                            imagepath: data.image,
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: SizedBox(
                              height: height * 0.12,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        MarqueeText(
                                          alwaysScroll: false,
                                          text: TextSpan(
                                            text: data.name,
                                          ),
                                          style: TextStyle(
                                            fontSize: width * 0.06,
                                            color: Colors.white,
                                          ),
                                          speed: 10,
                                        ),
                                        const SizedBox(height: 5),
                                        MarqueeText(
                                          alwaysScroll: true,
                                          text: TextSpan(
                                            text: data.singer,
                                          ),
                                          style: TextStyle(
                                            fontSize: width * 0.04,
                                            color: Colors.white,
                                          ),
                                          speed: 10,
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  GestureDetector(
                                    onTap: () {
                                      if (songisPlaying == true) {
                                        SongService.pause();
                                        isplayingProvider.state = false;
                                        
                                      } else {
                                        // setState(() {
                                        //   data.isplaying = true;
                                        // });
                                        SongService.ruseme();
                                        isplayingProvider.state = true;
                                        
                                      }
                                    },
                                    child: Container(
                                      height: 50,
                                      width: 50,
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white,
                                      ),
                                      child: Center(
                                        child: Icon(
                                          songisPlaying == true
                                              ? const IconData(0xe47c,
                                                  fontFamily: 'MaterialIcons')
                                              : Icons.arrow_right_rounded,
                                          color: Colors.black,
                                          size: 45,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
              const SizedBox(height: 20),
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 15),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     crossAxisAlignment: CrossAxisAlignment.center,
              //     children: [
              //       Text(
              //         "Your favourite artists",
              //         style: TextStyle(
              //           color: Colors.white,
              //           fontSize: width * 0.05, // responsive font size
              //         ),
              //       ),
              //       Icon(
              //         Icons.keyboard_double_arrow_right_outlined,
              //         color: Colors.blue.shade700,
              //         size: width * 0.07, // responsive icon size
              //       ),
              //     ],
              //   ),
              // ),
              const SizedBox(height: 20),
              Container(
                height: height * 0.22,
                width: width,
                decoration: const BoxDecoration(color: Colors.black),
                child: Artists(
                  singernames: snapshot.data,
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 15),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     crossAxisAlignment: CrossAxisAlignment.center,
              //     children: [
              //       Text(
              //         "Now Released",
              //         style: TextStyle(
              //           color: Colors.white,
              //           fontSize: width * 0.05, // responsive font size
              //         ),
              //       ),
              //       Icon(
              //         Icons.keyboard_double_arrow_right_outlined,
              //         color: Colors.blue.shade700,
              //         size: width * 0.07, // responsive icon size
              //       ),
              //     ],
              //   ),
              // ),
              // const SizedBox(height: 20),
              // Container(
              //   height: height * 0.20,
              //   width: width,
              //   decoration: const BoxDecoration(color: Colors.black),
              //   child: const AlbumList(),
              // ),
              const SizedBox(height: 20),
              ListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: snapshot.data
                    .map((item) => SongsBySingerTab(
                          singerName: item,
                        ))
                    .toList(),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Recommended for today",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: width * 0.05, // responsive font size
                      ),
                    ),
                    Icon(
                      Icons.keyboard_double_arrow_right_outlined,
                      color: Colors.blue.shade700,
                      size: width * 0.07, // responsive icon size
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Container(
                height: height * 0.22,
                width: width,
                decoration: const BoxDecoration(color: Colors.black),
                child: const Recommended(),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Slow Rock",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: width * 0.05, // responsive font size
                      ),
                    ),
                    Icon(
                      Icons.keyboard_double_arrow_right_outlined,
                      color: Colors.blue.shade700,
                      size: width * 0.07, // responsive icon size
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Container(
                height: MediaQuery.of(context)
                    .size
                    .height, // Adjusted height for better fit
                width: width,
                decoration: const BoxDecoration(color: Colors.black),
                child: const SlowRock(),
              ),
            ],
          ),
        );
      }, error: (err, stack) {
        return Center(
          child: Text("${err.toString()}"),
        );
      }, loading: () {
        return Center(
          child: CircularProgressIndicator(),
        );
      }),
    );
  }
}

class SongsBySingerTab extends ConsumerStatefulWidget {
  final String singerName;
  const SongsBySingerTab({super.key, required this.singerName});

  @override
  _SongsBySingerTabState createState() => _SongsBySingerTabState();
}

class _SongsBySingerTabState extends ConsumerState<SongsBySingerTab> {
  late Future<SongsBySingerModel> futureAlbum;

  @override
  void initState() {
    super.initState();
    final homserviec = HomeSerivce(createDio());
    futureAlbum = homserviec
        .getSong(SongsBySingerModelbody(singername: widget.singerName));
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 45,
                width: 45,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child: Center(
                  child: Text(
                    "${widget.singerName[0]}",
                    style: TextStyle(color: Colors.black, fontSize: 24),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    new Text(
                      "More like",
                      style: TextStyle(
                        color: Color.fromARGB(255, 202, 192, 192),
                        fontSize: 10,
                      ),
                    ),
                    Text(
                      "${widget.singerName}",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        FutureBuilder<SongsBySingerModel>(
          future: futureAlbum,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Container(
                height: height * 0.20,
                width: width,
                decoration: const BoxDecoration(color: Colors.black),
                child: MoreLike(
                  songslist: snapshot.data!.data,
                ),
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }

            // By default, show a loading spinner.
            return SizedBox();
          },
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}

class SpiningCirculerContainer extends StatefulWidget {
  final String imagepath;
  final double height;
  final double width;
  const SpiningCirculerContainer(
      {super.key,
      required this.imagepath,
      required this.height,
      required this.width});

  @override
  State<SpiningCirculerContainer> createState() =>
      _SpiningCirculerContainerState();
}

class _SpiningCirculerContainerState extends State<SpiningCirculerContainer>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 8), // Duration of the animation
      vsync: this,
    )..repeat(); // Repeat the animation indefinitely
  }

  @override
  void dispose() {
    _controller
        .dispose(); // Dispose the controller when the widget is removed from the widget tree
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns:
          _controller, // Uses the animation controller to control the rotation
      child: Container(
        height: widget.height,
        width: widget.width,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.black,
            boxShadow: [
              BoxShadow(
                color: Colors.black54,
                spreadRadius: 1,
                blurRadius: 12,
                offset: Offset(4, 4),
              )
            ],
            image: DecorationImage(
                image: NetworkImage(widget.imagepath), fit: BoxFit.cover)),
      ),
    );
  }
}

class SongAllTab extends ConsumerStatefulWidget {
  final Function callBack;
  final CurrentSongModel data;
  const SongAllTab( {required this.data,required this.callBack, super.key});

  @override
  _SongAllTabState createState() => _SongAllTabState();
}

class _SongAllTabState extends ConsumerState<SongAllTab> {
  @override
  Widget build(BuildContext context) {
    final songisPlaying = ref.watch(songIsPlayingChecker);
    final isplayingProvider = ref.read(songIsPlayingChecker.notifier);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 30, bottom: 10),
          child: Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.grey.shade900,
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                    color: Colors.black,
                    spreadRadius: 1,
                    blurRadius: 14,
                    offset: Offset(4, 4))
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 40,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                          onPressed: () {
                            widget.callBack();
                          },
                          icon: const Icon(
                            Icons.close,
                            color: Colors.white60,
                          ))
                    ],
                  ),
                ),
                SpiningCirculerContainer(
                  height: 180,
                  imagepath: widget.data!.image,
                  width: 180,
                ),
                new SizedBox(
                  height: 10,
                ),
                Text(
                  widget.data.name,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
                new SizedBox(
                  height: 5,
                ),
                Text(
                  widget.data.singer,
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 80,
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                          child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 20,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(500),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black54,
                                    spreadRadius: 1,
                                    blurRadius: 12,
                                    offset: Offset(4, 4),
                                  )
                                ]),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Icon(
                                Icons.arrow_back_ios,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(500),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black54,
                                    spreadRadius: 1,
                                    blurRadius: 12,
                                    offset: Offset(4, 4),
                                  )
                                ]),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.black,
                              ),
                            ),
                          )
                        ],
                      )),
                      Expanded(
                          child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              
                              if (isplayingProvider.state == true) {
                                SongService.pause();
                              } else {
                                SongService.ruseme();
                              }
                              isplayingProvider.state =
                                  !isplayingProvider.state;

                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(500),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Colors.black54,
                                      spreadRadius: 1,
                                      blurRadius: 12,
                                      offset: Offset(4, 4),
                                    )
                                  ]),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Icon(
                                  isplayingProvider.state == true

                                      ? Icons.pause
                                      : Icons.play_arrow,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          )
                        ],
                      ))
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
