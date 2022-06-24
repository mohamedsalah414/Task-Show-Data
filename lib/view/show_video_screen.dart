import 'dart:async';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerScreen extends StatefulWidget {



  const VideoPlayerScreen(
      {Key? key,   })
      : super(key: key);

  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;
  // Duration _currentPosition = Duration(minutes: 0);

  @override
  void initState() {
    super.initState();

    // Create and store the VideoPlayerController. The VideoPlayerController
    // offers several different constructors to play videos from assets, files,
    // or the internet.
    _controller = VideoPlayerController.network(
      'https://www.youtube.com/watch?v=0N9A9K0tTPw',
    );

    // Initialize the controller and store the Future for later use.
    _initializeVideoPlayerFuture = _controller.initialize();

    // Use the controller to loop the video.
    _controller.setLooping(false);
  }

  @override
  void dispose() {
    // Ensure disposing of the VideoPlayerController to free up resources.
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // print('url ${widget.url}');
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Video Player'),
      ),
      // Use a FutureBuilder to display a loading spinner while waiting for the
      // VideoPlayerController to finish initializing.
      body: GestureDetector(
        // onVerticalDragUpdate: (details) {
        //   if (details.delta.dy < 0) {
        //     print('up');
        //     widget.index < widget.length? Navigator.push(
        //         context,
        //         PageRouteBuilder(
        //           pageBuilder: (context, animation, secondaryAnimation) =>
        //               VideoPlayerScreen(
        //                 length: widget.length,
        //                 index: widget.index+1,
        //                   url:widget.index < widget.length? widget.list![widget.index+1]['image'].toString():null,
        //
        //               ),
        //           transitionsBuilder:
        //               (context, animation, secondaryAnimation, child) {
        //             const begin = Offset(0.0, 1.0);
        //             const end = Offset.zero;
        //             const curve = Curves.ease;
        //
        //             var tween = Tween(begin: begin, end: end)
        //                 .chain(CurveTween(curve: curve));
        //
        //             return SlideTransition(
        //               position: animation.drive(tween),
        //               child: child,
        //             );
        //           },
        //         )):null;
        //   } else if (details.delta.dy > 0) {
        //     print('down');
        //     Navigator.pop(context);
        //   }
        // },
        child: FutureBuilder(
          future: _initializeVideoPlayerFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              // If the VideoPlayerController has finished initialization, use
              // the data it provides to limit the aspect ratio of the video.
              // _currentPosition = _controller.value.duration;
              return Center(
                child: AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  // Use the VideoPlayer widget to display the video.
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        if (_controller.value.isPlaying) {
                          _controller.pause();
                        } else {
                          _controller.play();
                        }
                      });
                    },
                    child: Stack(
                      children: [
                        AspectRatio(
                            aspectRatio: _controller.value.aspectRatio,
                            child: VideoPlayer(_controller)),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Align(
                              alignment: Alignment.bottomRight,
                              child: Text(_controller.value.duration
                                  .toString()
                                  .split('.')[0])),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Align(
                              alignment: Alignment.bottomLeft,
                              child: Text(_controller.value.position
                                  .toString()
                                  .split('.')[0])),
                        ),
                        SizedBox(
                          child: IconButton(
                            onPressed: () {
                              setState(() {
                                // _controller.seekTo(Duration(seconds: 0));
                                _controller.value.volume == 0
                                    ? _controller.setVolume(1)
                                    : _controller.setVolume(0);
                              });
                            },
                            icon: Icon(_controller.value.volume == 0
                                ? Icons.volume_off
                                : Icons.volume_up),
                          ),
                        ),
                        Align(
                            alignment: Alignment.bottomCenter,
                            child: VideoProgressIndicator(_controller,
                                allowScrubbing: true)),
                        Visibility(
                          visible: !_controller.value.isPlaying,
                          child: AspectRatio(
                            aspectRatio: _controller.value.aspectRatio,
                            child: Container(
                              // height: size.height,
                              // width: size.width,
                              color: Colors.black.withOpacity(0.5),
                              child: Icon(
                                Icons.play_arrow,
                                color: Colors.white,
                                size: size.width * .2,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            } else {
              // If the VideoPlayerController is still initializing, show a
              // loading spinner.
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     // Wrap the play or pause in a call to `setState`. This ensures the
      //     // correct icon is shown.
      //     setState(() {
      //       // If the video is playing, pause it.
      //       if (_controller.value.isPlaying) {
      //         _controller.pause();
      //         // _currentPosition = _controller.value.position;
      //       } else {
      //         // If the video is paused, play it.
      //         // _currentPosition = _controller.value.position;
      //         _controller.play();
      //       }
      //     });
      //   },
      //   // Display the correct icon depending on the state of the player.
      //   child: Icon(
      //     _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
      //   ),
      // ),
    );
  }
}