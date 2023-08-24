// import 'package:flutter/material.dart';

// class SearchBar extends StatefulWidget {
//   const SearchBar({super.key});

//   @override
//   State<SearchBar> createState() => _SearchBarState();
// }

// class _SearchBarState extends State<SearchBar> {
//   @override
//   Widget build(BuildContext context) {
//     return PreferredSize(
//         preferredSize: const Size.fromHeight(60),
//         child: AppBar(
//           actions:  [
//             Icon(Icons.search, color: Colors.white, size: 22,)
//           ],
//           backgroundColor: Colors.red,
//           title: const Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   Text(
//                     "News App",
//                     style: TextStyle(
//                         color: Colors.white,
//                         fontWeight: FontWeight.w500,
//                         fontSize: 20),
//                   ),
//                   Icon(
//                     Icons.newspaper_rounded,
//                     size: 20,
//                     color: Colors.white,
//                   )
//                 ]),
//           ),
//           elevation: 10,
//         ));
//   }
// }