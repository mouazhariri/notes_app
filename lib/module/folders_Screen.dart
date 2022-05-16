// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:notes_app/Cubit/cubit.dart';
// import 'package:notes_app/Cubit/state.dart';
// import 'package:notes_app/module/notes_Screen.dart';
//
// class foldersScreen extends StatefulWidget {
//   @override
//   State<foldersScreen> createState() => _foldersScreenState();
// }
//
// class _foldersScreenState extends State<foldersScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0.5,
//         title: const Text(
//           'Folders',
//           style: TextStyle(
//             fontWeight: FontWeight.bold,
//             fontSize: 25,
//           ),
//         ),
//         actions: [TextButton(onPressed: () {}, child: Text('Edit'))],
//       ),
//       body: BlocProvider(
//           create: (BuildContext context) => cubit(),
//           child: BlocConsumer<cubit, noteState>(
//             listener: (context, state) {},
//             builder: (context, state) {
//               return Column(
//                 children: [
//                   Expanded(
//                     child: ListView.separated(
//                         physics: BouncingScrollPhysics(),
//                         itemBuilder: (context, index) {
//                           return buildnote();
//                         },
//                         separatorBuilder: (context, index) => Container(
//                               height: 1,
//                               color: Colors.black12,
//                             ),
//                         itemCount: 7),
//                   ),
//                   Column(
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     crossAxisAlignment: CrossAxisAlignment.stretch,
//                     children: [
//                       Divider(),
//                       Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: TextButton(
//                             onPressed: () {},
//                             child: Text(
//                               'New Folder',
//                               style: TextStyle(fontSize: 20),
//                             )),
//                       ),
//                     ],
//                   ),
//                 ],
//               );
//             },
//           )),
//     );
//   }
//
//   Widget buildnote() {
//     return Padding(
//       padding: const EdgeInsets.all(17.0),
//       child: Column(
//         children: [
//           InkWell(
//             onTap: () {
//               Navigator.push(context,
//                   MaterialPageRoute(builder: (context) => notesScreen()));
//             },
//             child: Padding(
//               padding: const EdgeInsets.symmetric(vertical: 8.0),
//               child: Row(
//                 children: [
//                   Text(
//                     'My Note',
//                     style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
//                   ),
//                   Spacer(),
//                   Text(
//                     '2',
//                     style: TextStyle(
//                         fontSize: 15,
//                         fontWeight: FontWeight.w700,
//                         color: Colors.blueAccent),
//                   ),
//                   SizedBox(
//                     width: 10,
//                   ),
//                   Icon(Icons.arrow_forward_ios_rounded)
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
