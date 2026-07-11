import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class VideoDetailController extends ChangeNotifier {
  VideoPlayerController? _videoPlayerController;
  ChewieController? _chewieController;
  final _yt = YoutubeExplode();

  bool _isLoading = true;
  String? _errorMessage;
  String? _videoTitle;
  String? _videoDescription;
  String? _videoAuthor;

  bool _isLiked = false;
  bool get isLiked => _isLiked;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  String? get videoTitle => _videoTitle;
  String? get videoDescription => _videoDescription;
  String? get videoAuthor => _videoAuthor;
  ChewieController? get chewieController => _chewieController;

  void toggleLike() {
    _isLiked = !_isLiked;
    notifyListeners();
  }

  Future<void> initializePlayer(String videoId) async {
    try {
      final video = await _yt.videos.get(videoId);
      final manifest = await _yt.videos.streamsClient.getManifest(videoId);
      final streamInfo = manifest.muxed.withHighestBitrate();

      _videoPlayerController = VideoPlayerController.networkUrl(streamInfo.url);
      await _videoPlayerController!.initialize();

      _chewieController = ChewieController(
        videoPlayerController: _videoPlayerController!,
        autoPlay: true,
        looping: false,
        aspectRatio: 16 / 9,
      );

      _videoTitle = video.title;
      _videoDescription = video.description;
      _videoAuthor = video.author;
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _videoPlayerController?.dispose();
    _chewieController?.dispose();
    _yt.close();
    super.dispose();
  }
}
