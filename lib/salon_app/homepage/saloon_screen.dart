import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class SaloonDemoVideoPlayer extends StatefulWidget {
  const SaloonDemoVideoPlayer({Key? key}) : super(key: key);

  @override
  _SaloonDemoVideoPlayerState createState() => _SaloonDemoVideoPlayerState();
}

class _SaloonDemoVideoPlayerState extends State<SaloonDemoVideoPlayer> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;
  bool _showAds = true; // Control whether to show ads or not

  @override
  void initState() {
    super.initState();
    // ignore: deprecated_member_use
    _controller = VideoPlayerController.network(
        'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4');
    _initializeVideoPlayerFuture = _controller.initialize();
    _controller.setLooping(true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FutureBuilder(
              future: _initializeVideoPlayerFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: VideoPlayer(_controller),
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Barber Services',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed consectetur turpis at ligula interdum, eu efficitur felis sollicitudin. Nulla vel ultrices nisl. Aliquam nec est a odio dignissim tincidunt.',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 20),
                  Image.asset(
                    'assets/Hair_salon.png',
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(height: 40),
                  Text(
                    'Makeup Services',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Sed eu tortor dignissim, dignissim ex non, fermentum arcu. Integer at mi risus.',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 20),
                  Image.asset(
                    'assets/Hair_salon.png',
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ],
              ),
            ),
            if (_showAds) // Show ads based on the condition
              AnimatedOpacity(
                duration: Duration(milliseconds: 500), // Duration of the animation
                opacity: _showAds ? 1.0 : 0.0, // Fade-in animation
                child: Container(
                  height: 200, // Set the height of the ad container
                  width: double.infinity, // Set the width to match the screen
                  color: Colors.grey[300], // Placeholder color for the ad container
                  child: Center(
                //    child: Image.asset('assets/Hair_salon.png'), // Replace 'your_ad_image.png' with your asset image path
                  ),
                ),
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            if (_controller.value.isPlaying) {
              _controller.pause();
            } else {
              _controller.play();
            }
          });
        },
        child: Icon(
          _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
        ),
      ),
    );
  }
}
