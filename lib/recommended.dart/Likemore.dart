import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:musicproject/home/moodels/songs.model.dart';
import 'package:musicproject/perticuler/views/perticuler.page.dart';

class MoreLike extends StatelessWidget {
  final List<Datum> songslist;
  const MoreLike({super.key, required this.songslist});

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
        itemCount: songslist.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: (){
              Navigator.push(context, CupertinoPageRoute(builder: (context) => PeticulerSongScrollable(
                id: songslist[index].id.oid, 
                image: songslist[index].image, 
                song: songslist[index].songsaudio, 
                name: songslist[index].name, 
                singer: songslist[index].singer,)));
            },
            child: Container(
              margin: const EdgeInsets.symmetric(
                  horizontal: 8.0), // Spacing between items
              width: containerWidth, // Responsive width
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(15), // Rounded corners
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: imageHeight, // Responsive height for the image
                    width: containerWidth, // Same width as the container
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                          15), // Rounded corners for the image
                      color: Colors.white,
                    ),
                    child: Center(
                      child: CachedNetworkImage(
                        height: imageHeight,
                        width: containerWidth,
                        fit: BoxFit.cover,
                        imageUrl: songslist[index].image,
                        placeholder: (context, url) => SizedBox(),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8), // Spacing between image and text
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                   children: [
                    Expanded(
                      child: Text(
                        "${songslist[index].name}",
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
                    "${songslist[index].singer}",
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
