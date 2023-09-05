
// 异步函数
import 'dart:io';

Future<String> fetchUsername() {
  return Future.delayed(const Duration(seconds: 2),
                      () {
                      return "ane_smith_92";
                      }
          );
}

Future<String> changeUsername() async{
  try {
    return await fetchUsername();
  } catch (err) {
   return err.toString();
  }
}


String addHello(String user) => 'Hello $user';

Future<String> greetUser() async {
  var username = await fetchUsername();
  return addHello(username);
}

// Future<String> sayGoodbye() async {
//   try {
//     var result = await logoutUser();
//     return '$result Thanks, see you next time';
//   } catch (e) {
//     return 'Failed to logout user: $e';
//   }
// }


const oneSecond = Duration(seconds: 1);
// ···
Future<void> printWithDelay(String message) async {
  await Future.delayed(oneSecond);
  print(message);
}
// 上面的方法相当于：
Future<void> printWithDelay2(String message) {
  return Future.delayed(oneSecond).then((_) {
    print(message);
  });
}

Future<void> createDescriptions(Iterable<String> objects) async {
  for (final object in objects) {
    try {
      var file = File('$object.txt');
      if (await file.exists()) {
        var modified = await file.lastModified();
        print(
            'File for $object already exists. It was modified on $modified.');
        continue;
      }
      await file.create();
      await file.writeAsString('Start describing $object in this file.');
    } on IOException catch (e) {
      print('Cannot create description for $object: $e');
    }
  }
}

class Spacecraft {
  String name;
  DateTime? launchDate;

  // Read-only non-final property
  int? get launchYear => launchDate?.year;

  // Constructor, with syntactic sugar for assignment to members.
  Spacecraft(this.name, this.launchDate) {
    // Initialization code goes here.
  }

  // Named constructor that forwards to the default one.
  Spacecraft.unlaunched(String name) : this(name, null);

  // Method.
  void describe() {
    print('Spacecraft: $name');
    // Type promotion doesn't work on getters.
    var launchDate = this.launchDate;
    if (launchDate != null) {
      int years = DateTime.now().difference(launchDate).inDays ~/ 365;
      print('Launched: $launchYear ($years years ago)');
    } else {
      print('Unlaunched');
    }
  }
}

Stream<String> report(Spacecraft craft, Iterable<String> objects) async* {
  for (final object in objects) {
    await Future.delayed(oneSecond);
    yield '${craft.name} flies by $object';
  }
}

Future<void> describeFlybyObjects(List<String> flybyObjects) async {
  try {
    for (final object in flybyObjects) {
      var description = await File('$object.txt').readAsString();
      print(description);
    }
  } on IOException catch (e) {
    print('Could not describe object: $e');
  } finally {
    flybyObjects.clear();
  }
}


Future<void> main() async{
  var list = ['duanxia'];
  await createDescriptions(list);

  await describeFlybyObjects(list);
}




