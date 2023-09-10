import 'package:flutter/material.dart';
import 'package:fultter_dart_sample/log_util.dart';

/// Flutter code sample for [PageView].

// void main() => runApp(const PageViewExampleApp());
//
// class PageViewExampleApp extends StatelessWidget {
//   const PageViewExampleApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(title: const Text('PageView Sample')),
//         body: const PageViewExample(),
//       ),
//     );
//   }
// }

class PageViewExample extends StatelessWidget {
  const PageViewExample({super.key});

  @override
  Widget build(BuildContext context) {
    myPrint('PageViewExample build ...');
    final PageController controller = PageController();
    return Scaffold(
      appBar: AppBar(title: const Text('PageView Sample')),
      body: PageView(
        scrollDirection: Axis.vertical,
        onPageChanged: (currentPage) {
          myPrint('onPageChanged currentPage = $currentPage');
        },

        /// [PageView.scrollDirection] defaults to [Axis.horizontal].
        /// Use [Axis.vertical] to scroll vertically.
        controller: controller,
        children: const <Widget>[
          Center(
            child: Text('First Page'),
          ),
          Center(
            child: Text('Second Page'),
          ),
          Center(
            child: Text('Third Page'),
          ),
        ],
      ),
    );
  }
}
