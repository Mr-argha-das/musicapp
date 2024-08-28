
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class PerticulerSongPage extends StatefulWidget {
  final String id;
  final String image;
  final String song;
  final String name;
  final String singer;
  const PerticulerSongPage({super.key, required this.image, required this.song, required this.name, required this.singer, required this.id});

  @override
  State<PerticulerSongPage> createState() => _PerticulerSongPageState();
}

class _PerticulerSongPageState extends State<PerticulerSongPage> {
  AudioPlayer _audioPlayer = AudioPlayer();
  void _playAudio() async {
    String url = "${widget.song}"; // Replace with your MP3 URL
    await _audioPlayer.play(UrlSource(url));
    
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Hero(
              tag: "${widget.id}",
              child: Container(
                height: 300,
                width: 300,
                decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(10), image: DecorationImage(image: NetworkImage(widget.image), fit: BoxFit.cover)),
              ),
            )
          ],
          
        ),
      ),
      bottomSheet: Container(
        height: 50,
        color: Colors.grey.shade900,
        child: Center(
          child: IconButton(onPressed: (){
            _playAudio();
          },
            icon: Icon(Icons.play_arrow_outlined, color: Colors.white,),),
        ),
      ),
    );
  }
}