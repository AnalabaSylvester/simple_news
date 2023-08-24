// import 'package:flutter/material.dart';

// // ignore: camel_case_types
// class appBar extends StatefulWidget {
//   const appBar({
//     super.key,
//   });

//   @override
//   State<appBar> createState() => _appBarState();
// }

// // ignore: camel_case_types
// class _appBarState extends State<appBar> {
//   String? searching;
//   bool isSearching = false;
//   TextEditingController searchController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return AppBar(
//       actions: [
//         IconButton(
//             onPressed: () {
//               setState(() {
//                 isSearching = true;
//               });
//             },
//             icon: const Icon(Icons.search))
//       ],
//       backgroundColor: Colors.red,
//       title: const Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Text(
//                 "News App",
//                 style: TextStyle(
//                     color: Colors.white,
//                     fontWeight: FontWeight.w500,
//                     fontSize: 20),
//               ),
//             ]),
//       ),
//       elevation: 10,
//     );
//   }
// }
