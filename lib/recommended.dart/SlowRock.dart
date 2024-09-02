import 'package:flutter/material.dart';

class SlowRock extends StatelessWidget {
  const SlowRock({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double itemWidth = screenWidth *
        0.8; // Width of each item as a percentage of the screen width
    // final double itemHeight = 60.0; // Fixed height for each item
    final double imageSize = 50.0; // Fixed size for the image
    final double fontSizeTitle =
        itemWidth * 0.06; // Responsive font size for the title
    final double fontSizeSubtitle = itemWidth * 0.04;
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      itemCount: 6,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Container(
                height: imageSize, // Fixed size for the image
                width: imageSize, // Fixed size for the image
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 15), // Spacing between image and text
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Love Yourself",
                      style: TextStyle(
                        fontSize:
                            fontSizeTitle, // Responsive font size for the title
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "Justin Bieber",
                      style: TextStyle(
                        fontSize:
                            fontSizeSubtitle, // Responsive font size for the subtitle
                        color: const Color.fromARGB(255, 201, 190, 190),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8.0), // Spacing before the icon
              Icon(
                Icons.more_horiz_outlined,
                color: Colors.white,
              ),
            ],
          ),
        );
      },
    );
  }
}
