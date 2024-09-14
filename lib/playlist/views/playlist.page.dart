import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:musicproject/home/controller/home.controller.dart';
import 'package:musicproject/playlist/views/perticulerplaylistpage.dart';

class PlaylistPage extends ConsumerStatefulWidget {
  const PlaylistPage({super.key});

  @override
  _PlaylistPageState createState() => _PlaylistPageState();
}

class _PlaylistPageState extends ConsumerState<PlaylistPage> {
  @override
  Widget build(BuildContext context) {
    final _singerResult = ref.watch(homeSingerProvider);
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
      child: _singerResult.when(data: (snapshot){
        return SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            
            ListView(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: snapshot.data.map((item) => 
              GestureDetector(
                onTap: (){
                  Navigator.push(context, CupertinoPageRoute(builder: (context) => Perticulerplaylistpage(singer: item.name.toString(), image: item.image.toString(),)));
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: 80,
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: 65,
                          width: 65,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(500),
                            image: DecorationImage(image: NetworkImage(item.image.toString()), fit: BoxFit.cover)
                          ),
                        ),
                        new SizedBox(
                          width: 15,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(item.name.toString(), style: const TextStyle(
                              color: Colors.white, 
                              fontSize: 17
                            ),),
                            const Text("Artist", style: TextStyle(
                              color: Colors.white54, 
                              fontSize: 14
                            ),)
                          ],
                
                        )
                      ],
                    ),
                  ),
                ),
              )
              ).toList(),
            ),
            Container(
              height: 200,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.black
              ),
              
            ),
          ],
        ),
      );
      }, error: (err, stack)=> Center(child: Text(err.toString()),), loading: () => Center(
        child: LoadingAnimationWidget.staggeredDotsWave(
              color: Colors.white, size: 40),
        
      ))
     ),
    );
  }
}