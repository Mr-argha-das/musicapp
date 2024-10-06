import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:musicproject/home/moodels/songs.model.dart';
import 'package:musicproject/perticuler/service/song.controller.dart';
import 'package:musicproject/perticuler/views/perticuler.page.dart';

class MoreLike extends ConsumerStatefulWidget {
  final List<Datum> songslist;
  final String shortsinger;
  const MoreLike(
      {super.key, required this.songslist, required this.shortsinger});

  @override
  _MoreLikeState createState() => _MoreLikeState();
}

class _MoreLikeState extends ConsumerState<MoreLike> {
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double containerWidth =
        screenWidth * 0.30; // Adjust width as a percentage of the screen width
    final double containerHeight =
        containerWidth; // Square aspect ratio for the container
    final double imageHeight =
        containerHeight * 1; // Height for the image (75% of container height)
    final double fontSizeTitle =
        containerWidth * 0.10; // Font size based on container width
    final double fontSizeSubtitle =
        containerWidth * 0.08; // Font size for the subtitle

    return SizedBox(
      height: containerHeight, // Height of the horizontal ListView
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.songslist.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              ref.read(songStateProvider.notifier).stopSong();
              Navigator.push(
                  context,
                  CupertinoPageRoute(
                      builder: (context) => PeticulerSongScrollable(
                            id: widget.songslist[index].id.oid,
                            image: widget.songslist[index].image,
                            song: widget.songslist[index].songsaudio,
                            name: widget.songslist[index].name,
                            singer: widget.songslist[index].singer,
                            shortSinger: widget.shortsinger,
                          )));
            },
            child: SizedBox(
              height: 280,
              width: 200,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CachedNetworkImage(
                    height: 180,
                    width: 180,
                    fit: BoxFit.cover,
                    imageUrl: widget.songslist[index].image,
                    placeholder: (context, url) => SizedBox(),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                  const SizedBox(height: 8), // Spacing between image and text
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          "${widget.songslist[index].name}",
                          style: TextStyle(
                            fontSize:
                                fontSizeTitle, // Responsive font size for the title
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.left,
                          overflow: TextOverflow.fade, // Center-align text
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "${widget.songslist[index].singer}",
                    style: TextStyle(
                      fontSize:
                          fontSizeSubtitle, // Responsive font size for the subtitle
                      color: const Color.fromARGB(255, 202, 192, 192),
                    ),
                    textAlign: TextAlign.left, // Center-align text
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
