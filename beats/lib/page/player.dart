//Playe UI
import 'package:beats/consts/colors.dart';
import 'package:beats/consts/textStyle.dart';
import 'package:beats/controller/play_con.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';

class Player extends StatelessWidget {
  final List<SongModel> data;
  const Player({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<PlayerController>();
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Expanded(
                  child: Container(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                // height: ,
                decoration: const BoxDecoration(
                  color: Colors.black12,
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Obx(
                  () =>
                      // child:
                      QueryArtworkWidget(
                    id: data[controller.playIndex.value].id,
                    type: ArtworkType.AUDIO,
                    artworkWidth: double.infinity,
                    artworkHeight: double.infinity,
                    nullArtworkWidget: const Icon(
                      Icons.music_note_outlined,
                      size: 80,
                    ),
                  ),
                ),
              )),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                  child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(15.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  // color: Color.fromARGB(222, 195, 29, 29),
                ),
                child: Obx(
                  () =>
                      // child:
                      Column(children: [
                    Text(
                      data[controller.playIndex.value].displayNameWOExt,
                      style: ostyle(
                        color: bgdarkColor,
                        fam: bold,
                        size: 18,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      data[controller.playIndex.value].artist.toString(),
                      style: ostyle(
                        color: bgdarkColor,
                        fam: regular,
                        size: 14,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Obx(
                      () => Row(
                        children: [
                          Text(
                            controller.position.value,
                            style: ostyle(color: bgdarkColor),
                          ),
                          Expanded(
                            child: Slider(
                              inactiveColor: bgdarkColor,
                              value: controller.val.value,
                              thumbColor: sliderColor,
                              activeColor: sliderColor,
                              min: Duration(seconds: 0).inSeconds.toDouble(),
                              max: controller.max.value,
                              onChanged: (newValue) {
                                controller
                                    .changeDurationToSeconds(newValue.toInt());
                                newValue = newValue;
                              },
                            ),
                          ),
                          Text(
                            controller.duration.value,
                            style: ostyle(color: bgdarkColor),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        IconButton(
                            color: bgdarkColor,
                            onPressed: () {
                              controller.playSong(
                                  data[controller.playIndex.value - 1].uri,
                                  controller.playIndex.value - 1);
                            },
                            icon: const Icon(
                              Icons.skip_previous_rounded,
                              size: 40,
                            )),
                        Obx(
                          () => CircleAvatar(
                            radius: 35,
                            backgroundColor: bgdarkColor,
                            child: Transform.scale(
                              scale: 2,
                              child: IconButton(
                                onPressed: () {
                                  if (controller.isPlaying.value) {
                                    controller.audioPlayer.pause();
                                    controller.isPlaying(false);
                                  } else {
                                    controller.audioPlayer.play();
                                    controller.isPlaying(true);
                                  }
                                },
                                icon: controller.isPlaying.value
                                    ? const Icon(
                                        Icons.pause,
                                        color: whiteColor,
                                        size: 30,
                                      )
                                    : const Icon(
                                        Icons.play_arrow_rounded,
                                        color: whiteColor,
                                        size: 30,
                                      ),
                              ),
                            ),
                          ),
                        ),
                        IconButton(
                            color: bgdarkColor,
                            onPressed: () {
                              controller.playSong(
                                  data[controller.playIndex.value + 1].uri,
                                  controller.playIndex.value + 1);
                            },
                            icon: const Icon(
                              Icons.skip_next_rounded,
                              size: 40,
                            )),
                      ],
                    )
                  ]),
                ),
              ))
            ],
          )),
    );
  }
}
