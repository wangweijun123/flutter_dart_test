import 'dart:io';

Future<String> _fetchUserId() {
  return Future.delayed(const Duration(seconds: 2), () => 'myId');
}

Future<String> _fetchFriendId(String userId) {
  return Future.delayed(const Duration(seconds: 1), () => 'friendId');
}

Future<List<String>> _fetchVideoList(String friendId) {
  return Future.delayed(const Duration(seconds: 2), () => ['a', 'b', 'c']);
}

// future implement
void main() {
  _fetchUserId().then((userId) {
    return _fetchFriendId(userId);
  }).then((friendId) {
    return _fetchVideoList(friendId);
  }).then((videoList) {
    print('videoList = $videoList');
  });

  sleep(const Duration(seconds: 6));
  print('main');
}

// await　阻塞當前線程，
void main2() async {
  var userId = await _fetchUserId();
  print('userId = $userId');
  var friendId = await _fetchFriendId(userId);
  print('friendId = $friendId');
  var videoList = await _fetchVideoList(friendId);
  print('videoList = $videoList');
}
