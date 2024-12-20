import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:marquee_text/marquee_text.dart';
import 'package:marquee_text/vertical_marquee_text.dart';
import 'package:musicproject/config/pretty.dio.dart';
import 'package:musicproject/config/userstorage/usersavedata.dart';
import 'package:musicproject/home/moodels/song.search.model.dart';
import 'package:musicproject/home/controller/home.controller.dart';
import 'package:musicproject/home/moodels/songs.model.dart';
import 'package:musicproject/home/service/home.service.dart';
import 'package:musicproject/lyrictosong/views/lyrics.to.song.page.dart';
import 'package:musicproject/perticuler/service/song.controller.dart';
import 'package:musicproject/perticuler/views/perticuler.page.dart';
import 'package:musicproject/playlist/views/playlist.page.dart';
import 'package:musicproject/recommended.dart/Likemore.dart';
import 'package:musicproject/recommended.dart/SlowRock.dart';

import 'package:musicproject/recommended.dart/artistList.dart';
import 'package:musicproject/recommended.dart/recommended.dart';
import 'package:musicproject/search/views/search.page.dart';
import 'package:musicproject/splash/splash.screen.dart';

class PageIndex {
  static int pageIndex = 0;
}

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  bool isExapnded = false;

  @override
  Widget build(BuildContext context) {
    final songState = ref.watch(songStateProvider);

    List<Widget> pages = [
      HomeSection(callback: (value) {
        Navigator.push(
            context, CupertinoPageRoute(builder: (context) => SearchPage()));
      }),
      const SearchPage(),
      const PlaylistPage(),
      const LyricsToSong(),
    ];
    return Scaffold(
      backgroundColor: Colors.black,
      body: pages[PageIndex.pageIndex],
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
                                PageIndex.pageIndex = 0;
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
                              ref
                                  .read(
                                      homeArtisittoSearchPageProvider.notifier)
                                  .state = null;
                              setState(() {
                                PageIndex.pageIndex = 1;

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
                      Expanded(
                        child: Center(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                PageIndex.pageIndex = 2;
                                isExapnded = false;
                              });
                            },
                            child: Icon(
                              Icons.library_music_outlined,
                              color: Colors.white,
                              size: 28,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              PageIndex.pageIndex = 3;
                              isExapnded = false;
                            });
                          },
                          child: Center(
                            child: Icon(
                              Icons.headphones_outlined,
                              color: Colors.white,
                              size: 28,
                            ),
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
  final Function callback;
  const HomeSection({required this.callback, super.key});

  @override
  _HomeSectionState createState() => _HomeSectionState();
}

class _HomeSectionState extends ConsumerState<HomeSection> {
  @override
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Widget build(BuildContext context) {
    final userSavedata = ref.watch(userProvider);
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    final _singerResult = ref.watch(homeSingerProvider(userSavedata!.id));
    final songState = ref.watch(songStateProvider);
    final songController = ref.read(songStateProvider.notifier);

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.black,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer();
          },
          icon: const Icon(
            Icons.menu_open_outlined,
            color: Colors.white,
            size: 30,
          ),
        ),
        actions: [
          GestureDetector(
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
          const SizedBox(width: 20,)
        ],
      ),
      drawer: Drawer(
        backgroundColor: Colors.black,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 100,
            ),
            GestureDetector(
              onTap: () async {
                final userController = ref.watch(userProvider.notifier);
                await userController.clearUser();
                Navigator.pushAndRemoveUntil(context, CupertinoPageRoute(builder: (context)=> SplashScreen()), (route)=> false);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  Icon(Icons.logout_outlined, color: Colors.white,),
                  SizedBox(width: 10,),
                  Text("Logout", style: GoogleFonts.montserrat(color: Colors.white, fontSize: 22),)
                ],
              ),
            )
          ],
        ),
      ),
      body: _singerResult.when(data: (snapshot) {
        return SingleChildScrollView(   
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text(
                  "HELLO",
                  style: GoogleFonts.montserrat(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 30),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text(
                  userSavedata!.username.toUpperCase(),
                  style: GoogleFonts.montserrat(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 30),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              if (songState.currentSong != null) ...[
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
                            imagepath: songState.currentSong!.id,
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
                                            text: songState.currentSong!.title,
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
                                            text: songState.currentSong!.artist,
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
                                      if (songState.isPlaying == true) {
                                        songController.pause();
                                      } else {
                                        // setState(() {
                                        //   data.isplaying = true;
                                        // });
                                        songController.resume();
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
                                          songState.isPlaying == true
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
                  callBack: (value) {
                    ref.read(homePageNavigatorIndex.notifier).state = 1;
                    ref.read(homeArtisittoSearchPageProvider.notifier).state =
                        value;
                    widget.callback(1);
                  },
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
                          image: item.image.toString(),
                          singerName: item.name.toString(),
                        ))
                    .toList(),
              ),
              const SizedBox(height: 150),
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 15),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     crossAxisAlignment: CrossAxisAlignment.center,
              //     children: [
              //       Text(
              //         "Recommended for today",
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
              //   height: height * 0.22,
              //   width: width,
              //   decoration: const BoxDecoration(color: Colors.black),
              //   child: const Recommended(),
              // ),
              const SizedBox(height: 20),
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 15),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     crossAxisAlignment: CrossAxisAlignment.center,
              //     children: [
              //       Text(
              //         "Slow Rock",
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
              //   height: MediaQuery.of(context)
              //       .size
              //       .height, // Adjusted height for better fit
              //   width: width,
              //   decoration: const BoxDecoration(color: Colors.black),
              //   child: const SlowRock(),
              // ),
            ],
          ),
        );
      }, error: (err, stack) {
        return Center(
          child: Text("${err.toString()}"),
        );
      }, loading: () {
        return Center(
          child: LoadingAnimationWidget.staggeredDotsWave(
              color: Colors.white, size: 40),
        );
      }),
    );
  }
}

class SongsBySingerTab extends ConsumerStatefulWidget {
  final String singerName;
  final String image;
  const SongsBySingerTab(
      {super.key, required this.singerName, required this.image});

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
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    image: DecorationImage(
                        image: NetworkImage(widget.image), fit: BoxFit.cover)),
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
                return Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Container(
                    height: 200,
                    width: width,
                    decoration: const BoxDecoration(color: Colors.black),
                    child: MoreLike(
                      songslist: snapshot.data!.data,
                      shortsinger: widget.singerName,
                    ),
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

  const SongAllTab({required this.callBack, super.key});

  @override
  _SongAllTabState createState() => _SongAllTabState();
}

class _SongAllTabState extends ConsumerState<SongAllTab> {
  @override
  Widget build(BuildContext context) {
    final songState = ref.watch(songStateProvider);
    final songController = ref.read(songStateProvider.notifier);
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
                  imagepath: songState.currentSong!.id,
                  width: 180,
                ),
                new SizedBox(
                  height: 10,
                ),
                Text(
                  songState.currentSong!.title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
                new SizedBox(
                  height: 5,
                ),
                Text(
                  songState.currentSong!.artist.toString(),
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
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                songController.playPreviousSong();
                              });
                            },
                            child: Container(
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
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          GestureDetector(
                            onTap: () {
                              log("hhey");
                              setState(() {
                                songController.playNextSong();
                              });
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
                                  Icons.arrow_forward_ios,
                                  color: Colors.black,
                                ),
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
                              if (songState.isPlaying == true) {
                                setState(() {
                                  songController.pause();
                                });
                              } else {
                                setState(() {
                                  songController.resume();
                                });
                              }
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
                                  songState.isPlaying == true
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
