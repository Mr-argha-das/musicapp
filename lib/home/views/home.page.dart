import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:musicproject/home/moodels/song.search.model.dart';
import 'package:musicproject/home/controller/home.controller.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: pages[pageIndex],
      floatingActionButton: Padding(
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
      ),
    );
  }
}

class HomeSection extends ConsumerStatefulWidget {
  const HomeSection({super.key});

  @override
  _HomeSectionState createState() => _HomeSectionState();
}

class _HomeSectionState extends ConsumerState<HomeSection>  {
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    final _singerResult = ref.watch(homeSingerProvider);
    return Scaffold(
      backgroundColor: Colors.black,
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
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Container(
                  height: height * 0.12,
                  width: width * 0.9,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 203, 190, 190),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: 60,
                          width: 60,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.black,
                          ),
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
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Despacito",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: width *
                                              0.05, // responsive font size
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        "Luis Fonsi",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: width *
                                              0.04, // responsive font size
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Container(
                                  height: 30,
                                  width: 30,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white,
                                  ),
                                  child: const Center(
                                    child: Icon(
                                      Icons.keyboard_double_arrow_left_sharp,
                                      color: Colors.black,
                                      size: 25,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 5),
                                Container(
                                  height: 50,
                                  width: 50,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white,
                                  ),
                                  child: const Center(
                                    child: Icon(
                                      Icons.arrow_right_rounded,
                                      color: Colors.black,
                                      size: 50,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 5),
                                Container(
                                  height: 30,
                                  width: 30,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white,
                                  ),
                                  child: const Center(
                                    child: Icon(
                                      Icons.keyboard_double_arrow_right_sharp,
                                      color: Colors.black,
                                      size: 25,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Your favourite artists",
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
                child: Artists(
                  singernames: snapshot.data,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Now Released",
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
                height: height * 0.20,
                width: width,
                decoration: const BoxDecoration(color: Colors.black),
                child: const AlbumList(),
              ),
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

class _SongsBySingerTabState extends ConsumerState<SongsBySingerTab>
     {
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    final _songsSingerResult = ref.watch(homeSingerSongsProvide(
        SongsBySingerModelbody(singername: widget.singerName)));
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
        _songsSingerResult.when(data: (data) {
          return Container(
            height: height * 0.20,
            width: width,
            decoration: const BoxDecoration(color: Colors.black),
            child:  MoreLike(songslist: data.data,),
          );
        }, loading: () {
          return SizedBox();
        }, error: (err, stack) {
          return Center(
            child: Text(err.toString()),
          );
        }),
        const SizedBox(height: 20),
      ],
    );
  }
}
