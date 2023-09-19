import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerControllerEx extends GetxController {
  late VideoPlayerController videoController;

  Future<void> initialize(String videoUrl) async {
    videoController = VideoPlayerController.networkUrl(Uri.parse(videoUrl));

    await videoController.initialize();
    videoController.setLooping(true);

    // Ensure that the widget is rebuilt when video playback state changes
    videoController.addListener(() {
      update(); // Trigger a rebuild when the playback state changes
    });
  }

  @override
  void onClose() {
    videoController
        .dispose(); // Dispose of the video controller when no longer needed
    super.onClose();
  }
}
