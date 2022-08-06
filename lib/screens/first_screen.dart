import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class FirstScreen extends StatelessWidget {
  const FirstScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(

          // child: Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: SizedBox(
          //     width: MediaQuery.of(context).size.width,
          //     height: 150,
          //     child: Row(
          //       children: [
          //         Column(
          //           children: [
          //             Icon(
          //               Icons.gif_box,
          //               size: 50,
          //             ),
          //             Icon(
          //               Icons.approval,
          //               size: 20,
          //             ),
          //           ],
          //         ),
          //         Container(
          //           width: 6,
          //           height: 2,
          //           color: Colors.black87,
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
          ),
    );
  }
}
