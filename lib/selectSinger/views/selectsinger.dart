import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:musicproject/config/pretty.dio.dart';
import 'package:musicproject/config/userstorage/usersavedata.dart';
import 'package:musicproject/home/controller/home.controller.dart';
import 'package:musicproject/home/views/home.page.dart';
import 'package:musicproject/selectSinger/controller/selectsingerprovider.dart';
import 'package:musicproject/selectSinger/model/delet.singer.res.dart';
import 'package:musicproject/selectSinger/model/select.singer.body.dart';
import 'package:musicproject/selectSinger/model/select.singer.response.dart';
import 'package:musicproject/selectSinger/service/singer.select.service.dart';

class SelectSingerPage extends ConsumerStatefulWidget {
  const SelectSingerPage({super.key});

  @override
  _SelectSingerPageState createState() => _SelectSingerPageState();
}

class _SelectSingerPageState extends ConsumerState<SelectSingerPage> {
  final _searchController = TextEditingController();
  List<SelectedSinger> selectSingerList = [];
  final apiService = SelectSingerService(createDio());
  @override
  Widget build(BuildContext context) {
    final _singerResult = ref.watch(filteredItemsProvider);
    final userSavedata = ref.watch(userProvider);
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.black,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Container(
                  height: MediaQuery.of(context).size.height * .06,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.search_outlined,
                          color: Colors.black,
                          size: 30,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: TextFormField(
                            controller: _searchController,
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                            decoration: const InputDecoration(
                              hintText: 'Search your favrite artist',
                              hintStyle: TextStyle(fontSize: 18),
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                            ),
                            onChanged: (value) {
                             ref.read(searchQueryProvider.notifier).state = value;
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              if (_singerResult == null) ...[
                Center(
                  child: LoadingAnimationWidget.staggeredDotsWave(
                      color: Colors.white, size: 40),
                )
              ],
              if (_singerResult != null) ...[
                GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3, // Number of items in a row
                    crossAxisSpacing: 10.0, // Space between columns
                    mainAxisSpacing: 10.0, // Space between rows
                    childAspectRatio:
                        0.75, // Ratio of width to height of grid items
                  ),
                  itemCount:
                      _singerResult.length, // Number of items in the grid
                  itemBuilder: (context, index) {
                    return SingerSelectTab(
                      image: _singerResult[index].image.toString(),
                      name: _singerResult[index].name.toString(), callBack: (value) async {
                        if(value == true){
                          final SelectSingerResModel res = await apiService.addSingerUSer(SelectSingerModel(userid: userSavedata!.id, artistId: _singerResult[index].id!.oid.toString()));
                          setState(() {
                            selectSingerList.add(SelectedSinger(data: res, index: index));
                          });
                        }

                        if(value == false){
                          final DeleteSingerResModel res = await apiService.deletSingerUSer(selectSingerList[index].data.data.artistId, selectSingerList[index].data.data.userid);
                          setState(() {
                            selectSingerList.removeWhere((item) => item.index == index);
                          });
                        }
                      },
                    );
                  },
                  padding: EdgeInsets.all(10.0), // Padding around the grid
                )
              ],
            ],
          ),
        ),
      ),
      floatingActionButton: GestureDetector(
        onTap: (){
           Navigator.pushAndRemoveUntil(
                                            context,
                                            CupertinoPageRoute(
                                                builder: (context) =>
                                                    const HomePage()),
                                            (routet) => false);

        },
        child: Container(
          height: 60,
          width: 60,
          decoration: BoxDecoration(
              color: const Color.fromARGB(255, 198, 28, 133),
              borderRadius: BorderRadius.circular(500)),
          child: const Center(
            child: Icon(
              Icons.next_plan_outlined,
              color: Colors.white,
              size: 55,
            ),
          ),
        ),
      ),
    );
  }
}

class SingerSelectTab extends StatefulWidget {
  final String name;
  final String image;
  final Function callBack;
  const SingerSelectTab({super.key, required this.name, required this.image, required this.callBack});

  @override
  State<SingerSelectTab> createState() => _SingerSelectTabState();
}

class _SingerSelectTabState extends State<SingerSelectTab> {
  bool isSelected = false;
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.transparent,
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  isSelected = !isSelected;
                });
                widget.callBack(isSelected);
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 350),
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(500),
                    border: Border.all(
                        color: isSelected ? Colors.white : Colors.transparent,
                        width: 3),
                    image: DecorationImage(
                        image: NetworkImage(widget.image), fit: BoxFit.cover)),
              ),
            ),
            new SizedBox(
              height: 5,
            ),
            Text(
              widget.name,
              textAlign: TextAlign.center,
              style: GoogleFonts.montserrat(color: Colors.white),
            )
          ],
        ));
  }
}


class SelectedSinger{
  final int index;
  final SelectSingerResModel data;

  SelectedSinger({required this.index, required this.data});
}