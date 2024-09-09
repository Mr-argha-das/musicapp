import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class PlaylistPage extends StatefulWidget {
  const PlaylistPage({super.key});

  @override
  State<PlaylistPage> createState() => _PlaylistPageState();
}

class _PlaylistPageState extends State<PlaylistPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(
      backgroundColor: Colors.black,
      
      title: Text("Your Library", style: GoogleFonts.montserrat(color: Colors.white, fontWeight: FontWeight.bold),),
      actions: [
        IconButton(onPressed: (){}, icon: const Icon(Icons.search_outlined, color: Colors.white,))
      ],
     ),
     body: Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        color: Colors.black,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 200,
              width: MediaQuery.of(context).size.width,
              decoration:const BoxDecoration(
                image: DecorationImage(image: AssetImage("assets/music.jpg"), fit: BoxFit.cover)
              ),
            ),
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index){
              return SizedBox(
                height: 120,
                width: MediaQuery.of(context).size.width,
                child: Row(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      color: Colors.white
                    ),
                  )
                ],
                ),
              );
            })
          ],
        ),
      ),
     ),
    );
  }
}