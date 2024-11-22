import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:musicproject/firebase_options.dart';
import 'package:musicproject/home/views/home.page.dart';
import 'package:musicproject/login/view/login.page.dart';
import 'package:musicproject/perticuler/service/song.controller.dart';
import 'package:musicproject/selectSinger/views/selectsinger.dart';
import 'package:musicproject/splash/splash.screen.dart';
import 'package:permission_handler/permission_handler.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await JustAudioBackground.init(
    androidNotificationChannelId: 'com.ryanheise.bg_demo.channel.audio',
    androidNotificationChannelName: 'Audio playback',
    androidNotificationOngoing: true,
  );

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future<void> _requestPermissions() async {
    // Request Internet permissions (by default handled by manifest)
    

    // Request Microphone permissions
    PermissionStatus micStatus = await Permission.microphone.request();
    if (micStatus.isGranted) {
      print('Microphone permission granted');
    } else {
      print('Microphone permission denied');
    }

    // Request Audio Recording permissions
    PermissionStatus recordStatus = await Permission.microphone.request();
    if (recordStatus.isGranted) {
      print('Audio recording permission granted');
    } else {
      print('Audio recording permission denied');
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _requestPermissions();
  }
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: SplashScreen(),
    );
  }
}
