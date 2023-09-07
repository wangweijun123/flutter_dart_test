import 'package:fijkplayer/fijkplayer.dart';

import '../player_platform_interface.dart';

class Player extends FijkPlayer {
  void setCommonDataSource(String path,
      {bool autoPlay = false, bool showCover = false}) {
    setDataSource(path, autoPlay: autoPlay, showCover: showCover);
  }
}
