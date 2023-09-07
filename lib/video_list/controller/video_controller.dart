import '../../log_util.dart';
import '../model/video_model.dart';

class VideoController {
  List<VideoModel>? dataList;
  // 模拟网络
  Future<void> fetchVideoList() async {
    myPrint('Awaiting get video list...');
    var list = await _fetchVideoList();
    dataList = list;
    myPrint('result finished:');
  }

  Future<List<VideoModel>> _fetchVideoList() {
    // Imagine that this function is more complex and slow.
    return Future.delayed(const Duration(seconds: 1), () {
      return List.generate(20, (index) => VideoModel('$index', 'xx', 1));
    });
  }
}
