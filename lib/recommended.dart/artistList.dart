import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:musicproject/home/controller/home.controller.dart';
import 'package:musicproject/recommended.dart/random.collor.dart';

class Artists extends ConsumerStatefulWidget {
  final Function callBack;
  final List<String> singernames;
  const Artists( {super.key, required this.callBack, required this.singernames});

  @override
  _ArtistsState createState() => _ArtistsState();
}

class _ArtistsState extends ConsumerState<Artists> {
  @override
  Widget build(BuildContext context) {
    // Retrieve screen width for responsive sizing
    final double screenWidth = MediaQuery.of(context).size.width;
    final double itemWidth =
        screenWidth * 0.3; // Adjust width as a percentage of the screen width
    final double itemHeight =
        itemWidth; // Set height equal to width for a square aspect ratio

    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: widget.singernames.length,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.symmetric(
              horizontal: 8.0), // Spacing between items
          width: itemWidth, // Responsive width
          height: itemHeight, // Responsive height
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.black,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: (){
                widget.callBack(widget.singernames[index].toString());
                 
                },
                child: Container(
                  height: itemWidth * 0.90, // Circle size based on item width
                  width: itemWidth * 0.90,
                  decoration:  BoxDecoration(
                    shape: BoxShape.circle,
                    color: generateRandomSoftColor(),
                  ),
                  child: Center(
                    child: Text(
                      "${widget.singernames[index][0]}",
                      style: TextStyle(
                        fontSize: itemWidth * 0.65, // Responsive font size
                        color: getContrastingTextColor(
                                            generateRandomSoftColor()),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                  height: 8), // Increased spacing for better visual appeal
              Text(
                "${widget.singernames[index]}",
                style: TextStyle(
                  fontSize: itemWidth * 0.09, // Responsive font size
                  color: Colors.white,
                ),
                textAlign: TextAlign.center, // Center-align text
              ),
            ],
          ),
        );
      },
    );
  }
}
