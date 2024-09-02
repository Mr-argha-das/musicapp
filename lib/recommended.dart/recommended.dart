import 'package:flutter/material.dart';

class Recommended extends StatelessWidget {
  const Recommended({super.key});

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
        itemCount: 10,
        itemBuilder: (context, index) {
          return Container(
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
                ),
                const SizedBox(height: 8), // Spacing between image and text
                Text(
                  "No Other Place",
                  style: TextStyle(
                    fontSize:
                        fontSizeTitle, // Responsive font size for the title
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center, // Center-align text
                ),
                Text(
                  "Umair",
                  style: TextStyle(
                    fontSize:
                        fontSizeSubtitle, // Responsive font size for the subtitle
                    color: const Color.fromARGB(255, 202, 192, 192),
                  ),
                  textAlign: TextAlign.center, // Center-align text
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
