import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';
class VideoPlayerWidget extends StatefulWidget {
String url;
VideoPlayerWidget(this.url);
  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController videoPlayerController;
  late ChewieController chewieController;
  bool initalise= false;
  @override
  void initState() {
    videoPlayerController = VideoPlayerController.network(widget.url);
    videoPlayerController.initialize().then((value) {
      chewieController=ChewieController(
        videoPlayerController:videoPlayerController,
        autoPlay:true,
        looping:false,
      );
      initalise = true;
      setState(() {

      });

    });
    // TODO: implement initState
    super.initState();
  }
  @override
  void dispose() {
    videoPlayerController.dispose();
    chewieController.dispose();
    super.dispose();
    videoPlayerController.dispose();
    chewieController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: initalise?Chewie(controller: chewieController):Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
