import 'package:beats/consts/colors.dart';
import 'package:beats/consts/textStyle.dart';
import 'package:beats/controller/play_con.dart';
import 'package:beats/page/player.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';

class home extends StatelessWidget {
  const home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(PlayerController());
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.amberAccent,
          actions: [
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.search,
                  color: newColor,
                ))
          ],
          leading: Padding(
            padding: const EdgeInsets.all(10),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), color: ic),
              child: const Icon(
                Icons.sort_rounded,
                color: bgdarkColor,
              ),
            ),
          ),
          title: Text(
            "Beats",
            style: ostyle(
              fam: bold,
              size: 18,
              color: newColor,
            ),
          ),
        ),
        body: FutureBuilder<List<SongModel>>(
            future: controller.audioQuery.querySongs(
              ignoreCase: true,
              orderType: OrderType.DESC_OR_GREATER,
              sortType: null,
              uriType: UriType.EXTERNAL,
            ),
            builder: (BuildContext context, snapshot) {
              if (snapshot.data == null) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.data!.isEmpty) {
                return Center(
                  child: Text(
                    "No Songs",
                    style: ostyle(color: bgdarkColor),
                  ),
                );
              } else {
                return Padding(
                  padding: const EdgeInsets.all(8.5),
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: snapshot.data!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                          margin: const EdgeInsets.only(bottom: 4),
                          child: Obx(
                            () => ListTile(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)),
                              tileColor: bgColor,
                              title: Text(snapshot.data![index].displayName,
                                  style: ostyle(
                                    fam: bold,
                                    size: 14,
                                    color: newColor,
                                  )),
                              // subtitle: Text("${snapshot.data![index].artist}",
                              subtitle: Text("${snapshot.data![index].artist}",
                                  style: ostyle(
                                    fam: regular,
                                    size: 12,
                                    color: newColor,
                                  )),
                              leading: QueryArtworkWidget(
                                id: snapshot.data![index].id,
                                type: ArtworkType.AUDIO,
                                nullArtworkWidget: const Icon(
                                  Icons.music_note,
                                  color: newColor,
                                  size: 32,
                                ),
                              ),
                              trailing: controller.playIndex.value == index &&
                                      controller.isPlaying.value
                                  ? const Icon(
                                      Icons.pause,
                                      color: newColor,
                                      size: 32,
                                    )
                                  : const Icon(
                                      Icons.play_arrow,
                                      color: newColor,
                                      size: 32,
                                    ),
                              // ? const Icon(
                              //     Icons.play_arrow,
                              //     color: newColor,
                              //     size: 32,
                              //   )
                              // : null,
                              onTap: () {
                                Get.to(
                                    () => Player(
                                          data: snapshot.data!,
                                        ),
                                    transition: Transition.fade,
                                    duration: const Duration(
                                      milliseconds: 500,
                                    ));
                                if (controller.kk ==
                                    snapshot.data![index].uri) {
                                  controller.audioPlayer.pause();
                                  controller.isPlaying(false);
                                } else {
                                  controller.playSong(
                                      snapshot.data![index].uri, index);
                                }
                              },
                            ),
                          ));
                    },
                  ),
                );
              }
            }));
  }
}
