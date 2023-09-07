
import 'player_platform_interface.dart';

class Player {
  Future<String?> getPlatformVersion() {
    return PlayerPlatform.instance.getPlatformVersion();
  }
}
