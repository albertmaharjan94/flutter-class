import 'package:flutter/material.dart';

class LayoutDemo extends StatefulWidget {
  const LayoutDemo({Key? key}) : super(key: key);

  @override
  State<LayoutDemo> createState() => _LayoutDemoState();
}

class _LayoutDemoState extends State<LayoutDemo> {
  @override
  Widget build(BuildContext context) {
    return StackViewDemo();
  }
}

// class ListViewDemo extends StatelessWidget {
//   ListViewDemo({Key? key}) : super(key: key);
//
//   List<String> dummyData = List.generate(100, (index) => index.toString());
//
//   @override
//   Widget build(BuildContext context) {
//     return ListView(
//       children: dummyData
//           .map(
//             (e) => ListTile(
//               leading: Icon(Icons.play_arrow),
//               title: Container(
//                 child: Text(e),
//               ),
//               subtitle: Text('Sub: $e'),
//               trailing: Icon(Icons.delete),
//             ),
//           )
//           .toList(),
//     );
//   }
// }

class ListViewBuilderDemo extends StatelessWidget {
  ListViewBuilderDemo({Key? key}) : super(key: key);

  List<String> dummyData = List.generate(100, (index) => index.toString());
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: dummyData.length,
      itemBuilder: (context, index) {
        return Text(dummyData[index]);
      },
    );
  }
}

// class GridViewDemo extends StatelessWidget {
//   GridViewDemo({Key? key}) : super(key: key);
//
//   List<String> dummyData = List.generate(100, (index) => index.toString());
//   @override
//   Widget build(BuildContext context) {
//     return GridView.count(
//       crossAxisCount: 1,
//       children: dummyData.map((e) => Text(e)).toList(),
//     );
//   }
// }

class GridViewDemo extends StatelessWidget {
  GridViewDemo({Key? key}) : super(key: key);

  List<String> dummyData = List.generate(100, (index) => index.toString());
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 3,
      crossAxisSpacing: 20,
      mainAxisSpacing: 5,
      children: dummyData
          .map((e) => Container(
          color: Colors.red, margin: EdgeInsets.all(10), child: Text(e)))
          .toList(),
    );
  }
}

class StackViewDemo extends StatelessWidget {
  const StackViewDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        height: 300,
        width: 200,
        color: Colors.blue,
      ),
      Positioned(
        top: 0,
        left: 0,
        child: Container(
          height: 100,
          width: 100,
          color: Colors.red,
        ),
      ),
      Positioned(
        bottom: 0,
        right: 0,
        child: Container(
          height: 100,
          width: 100,
          color: Colors.red,
        ),
      )
    ]);
  }
}