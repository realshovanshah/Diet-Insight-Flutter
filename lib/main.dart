import 'package:flutter/material.dart';

import 'package:DietInsight/category_screen.dart';

/// The function that is called when main.dart is run.
void main() {
  runApp(UnitConverterApp());
}

/// This widget is the root of our application.
///
/// The first screen we see is a list [Categories].
class UnitConverterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Unit Converter',
      home: CategoryRoute(),
    );
  }
}


// void main() {
//   runApp(
//     MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Hello Rectangle',
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('Hello Rectangle'),
//         ),
//         body: HelloRectangle(),
//       ),
//     ),
//   );
// }

// class HelloRectangle extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Container(
//         color: Colors.greenAccent,
//         height: 400.0,
//         width: 300.0,
//         child: Center(
//           child: Text(
//             'Hello sahani!',
//             style: TextStyle(fontSize: 40.0),
//             textAlign: TextAlign.center,
//           ),
//         ),
//       ),
//     );
//   }
// }
