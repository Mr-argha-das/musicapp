import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:musicproject/config/pretty.dio.dart';
import 'package:musicproject/lyrictosong/model/lyrcs.model.dart';
import 'package:musicproject/lyrictosong/service/liyrcs.service.dart';
import 'package:musicproject/lyrictosong/views/lyrics.resultpage.dart';
import 'package:speech_to_text/speech_to_text.dart';

class LyricsToSong extends ConsumerStatefulWidget {
  const LyricsToSong({super.key});

  @override
  _LyricsToSongState createState() => _LyricsToSongState();
}

class _LyricsToSongState extends ConsumerState<LyricsToSong> {
  bool _listen = false;
  final SpeechToText _speech = SpeechToText();
  double _confidence = 1.0;
  String _text = 'Our own ai that help you to find your song';

  void _listenFunction() async {
    if (!_listen) {
      bool available = await _speech.initialize(
        onStatus: (val) {
          log('onStatus: $val');
          // Check if speech recognition stopped and run a function after speech
          if (val == 'done') {
            songGet(_text); 
          }
        },
        onError: (val) => log('onError: $val'),
      );
      if (available) {
        setState(() => _listen = true);
        _speech.listen(
          onResult: (val) => setState(() {
            _text = val.recognizedWords;
            if (val.hasConfidenceRating && val.confidence > 0) {
              _confidence = val.confidence;
            }
          }),
        );
      }
    } else {
      setState(() => _listen = false);
      _speech.stop();
    }
  }
   void _onSpeechComplete() {
    // Run your custom function here
    print('Speech completed! Running custom function...');
    // Example: Show a message or perform an action
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Speech recognition completed!'))
    );
  }
  void songGet(String value) async {
      final service = LyrcisService(createDio());
       LyrcsSOngResult  response = await service.searchSong(value.toLowerCase());
       if(response.data != null){
          setState(() {
           _text = response.data!.songs.the0.toString();
          _listen = false;
        });
        }else{
          setState(() {
            _text = "Sorry i cant find out";
            _listen = false;
          });
        }
        
    }
  @override
  Widget build(BuildContext context) {
    

    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.black,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                _listenFunction();
               
                
              },
              child: Container(
                height: 275,
                width: 275,
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(500),
                    image: DecorationImage(
                        image: AssetImage(_listen
                            ? "assets/circle.gif"
                            : "assets/circle.png"),
                        fit: BoxFit.cover)),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              _listen ? "Finding.." : "Play song I will find",
              style: GoogleFonts.montserrat(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 28),
            ),
            Text(
              _text,
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
