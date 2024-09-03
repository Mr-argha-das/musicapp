import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:musicproject/perticuler/service/song.controller.dart';

class AdDataProvider with ChangeNotifier {
  String _adData = '';

  String get adData => _adData;

  void setAdData(String data) {
    _adData = data;
    notifyListeners();
  }
}


// class SongAdaptore with ChangeNotifier{
//   String _id = '';
//   String _image = '';
//   String _song = '';
//   String _name = '';
//   String _singer = '';
//   bool _isplaying = false;

//   void setSong(CurrentSongModel song){
//     _id = song.id;
//     _image = song.image;
//     _song = song.song;
//     _name = song.name;
//     _singer = song.singer;
//     _isplaying = song.isplaying;
//     notifyListeners();
//   }
// }


