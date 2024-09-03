import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:musicproject/perticuler/views/perticuler.page.dart';
import 'package:musicproject/recommended.dart/random.collor.dart';
import 'package:musicproject/search/controller/search.controller.dart';

import '../models/search.model.dart';

class SearchPage extends ConsumerStatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends ConsumerState<SearchPage> {
  final _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final searchresult = ref.watch(searchResultProvider(
        _searchController.text.isEmpty ? " | " : _searchController.text));

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("Search",
            style: TextStyle(color: Colors.white, fontSize: 25)),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: Container(
                height: MediaQuery.of(context).size.height * .06,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.search_outlined,
                        color: Colors.black,
                        size: 30,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: TextFormField(
                          controller: _searchController,
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                          decoration: const InputDecoration(
                            hintText: 'What would you prefer to listen to?',
                            hintStyle: TextStyle(fontSize: 18),
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                          ),
                          onChanged: (value) {
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            if (_searchController.text.isEmpty ||
                _searchController.text == "") ...[
              searchresult.when(
                  data: (snapshot) => AlboumFavourite(
                        songslist: snapshot.data,
                      ),
                  loading: () => Center(
                        child: CircularProgressIndicator(),
                      ),
                  error: (err, stack) {
                    return Center(
                      child: Text(err.toString()),
                    );
                  }),
              SizedBox(
                height: 10,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 6),
                child: Text(
                  "Browse All",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: Colors.white),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                color: Colors.black,
                child: BrowseChoise(),
              ),
            ],
            if (_searchController.text.isNotEmpty ||
                _searchController.text != "") ...[
              searchresult.when(
                  data: (snapshot) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 50),
                      child: ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(left: 15.0),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      CupertinoPageRoute(
                                          builder: (context) =>
                                              PeticulerSongScrollable(
                                                  image: snapshot
                                                      .data[index].image,
                                                  song: snapshot
                                                      .data[index].songsaudio,
                                                  name:
                                                      snapshot.data[index].name,
                                                  singer: snapshot
                                                      .data[index].singer,
                                                  id: snapshot
                                                      .data[index].id.oid)));
                                },
                                child: SizedBox(
                                  height: 80,
                                  width: MediaQuery.of(context).size.width,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        height: 70,
                                        width: 70,
                                        decoration: BoxDecoration(
                                          color: Colors.grey.shade900,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Center(
                                          child: CachedNetworkImage(
                                            height: 70,
                                            width: 70,
                                            fit: BoxFit.cover,
                                            imageUrl:
                                                snapshot.data[index].image,
                                            placeholder: (context, url) =>
                                                SizedBox(),
                                            errorWidget:
                                                (context, url, error) =>
                                                    Icon(Icons.error),
                                          ),
                                        ),
                                      ),
                                      new SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                          child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "${snapshot.data[index].name}",
                                            style: GoogleFonts.montserrat(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20),
                                          ),
                                          SizedBox(
                                            height: 2,
                                          ),
                                          Text(
                                            "${snapshot.data[index].singer}",
                                            style: GoogleFonts.montserrat(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 10),
                                          ),
                                          SizedBox(
                                            height: 4,
                                          ),
                                        ],
                                      ))
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }),
                    );
                  },
                  loading: () => Center(
                        child: CircularProgressIndicator(),
                      ),
                  error: (err, stack) {
                    return Center(
                      child: Text(
                        err.toString(),
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    );
                  }),
            ]
          ],
        ),
      ),
    );
  }
}

class AlboumFavourite extends StatelessWidget {
  final List<Datum> songslist;
  const AlboumFavourite({super.key, required this.songslist});

  @override
  Widget build(BuildContext context) {
    return MasonryGridView.count(
      itemCount: 40,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      crossAxisSpacing: 15,
      mainAxisSpacing: 10,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                CupertinoPageRoute(
                    builder: (context) => PeticulerSongScrollable(
                        image: songslist[index].image,
                        song: songslist[index].songsaudio,
                        name: songslist[index].name,
                        singer: songslist[index].singer,
                        id: songslist[index].id.oid)));
          },
          child: Container(
            width: (MediaQuery.of(context).size.width / 2) -
                12, // Half the screen width minus padding
            height: MediaQuery.of(context).size.height * .06,
            decoration: BoxDecoration(
              color: Colors.grey.shade900,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: MediaQuery.of(context).size.width * .15,
                  width: MediaQuery.of(context).size.width * .15,
                  decoration: const BoxDecoration(
                      color: Colors.purple,
                      borderRadius:
                          BorderRadius.only(topLeft: Radius.circular(4))),
                  child: CachedNetworkImage(
                    height: MediaQuery.of(context).size.width * .15,
                    width: MediaQuery.of(context).size.width * .15,
                    fit: BoxFit.cover,
                    imageUrl: songslist[index].image,
                    placeholder: (context, url) => SizedBox(),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ),
                Expanded(
                  child: Padding(
                      padding: EdgeInsets.only(top: 5, left: 10),
                      child: Text(songslist[index].name,
                          textAlign: TextAlign.left,
                          overflow: TextOverflow.fade,
                          style: GoogleFonts.montserrat(color: Colors.white))),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

class BrowseChoise extends StatelessWidget {
  const BrowseChoise({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: NeverScrollableScrollPhysics(),
      itemCount: 12,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // Two items per row
        mainAxisSpacing: 12, // Vertical spacing between grid items
        crossAxisSpacing: 12, // Horizontal spacing between grid items
        childAspectRatio: ((MediaQuery.of(context).size.width / 2) - 12) /
            (MediaQuery.of(context).size.height * 0.12),
      ),
      itemBuilder: (context, index) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.12,
          width: (MediaQuery.of(context).size.width / 2) - 12,
          decoration: BoxDecoration(
            color: generateRandomSoftColor(),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Hindi',
                      style: TextStyle(
                          color: getContrastingTextColor(
                              generateRandomSoftColor()),
                          fontSize: 18),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Transform.rotate(
                          angle:
                              0.5, // Rotation angle in radians (e.g., 0.5 radians ~ 28.6 degrees)
                          child: Container(
                            width: 70,
                            height: 70,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.white, width: 2),
                            ),
                          ),
                        ),
                        SizedBox(width: 20,)
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
