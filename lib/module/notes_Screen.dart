import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/Cubit/cubit.dart';
import 'package:notes_app/Cubit/state.dart';
import 'package:notes_app/Network/remote/dio_helper.dart';
import 'package:notes_app/db/db.dart';
import 'package:notes_app/model/note_model.dart';
import 'package:notes_app/module/note_details.dart';
import 'package:notes_app/module/write_note.dart';

class notesScreen extends StatefulWidget {
  @override
  State<notesScreen> createState() => _notesScreenState();
}

class _notesScreenState extends State<notesScreen> {
  late DbHelper helper;
  noteModel? model;
  TextEditingController tsearch = TextEditingController();
  List alnote = [];
  var items = [];
  @override
  void initState() {
    setState(() {});
    super.initState();
    helper = DbHelper();
    // helper.allnotes();
    // model = noteModel();
    helper.allnotes().then((value) {
      setState(() {
        alnote = value;
        items = alnote;
      });
    });
  }

  void Search(String query) async {
    var search = alnote;
    if (query.isNotEmpty) {
      var dData = [];
      search.forEach((element) {
        var note = noteModel.fromMap(element);
        if (note.Text!.toLowerCase().contains(query.toLowerCase())) {
          dData.add(element);
        }
      });
      setState(() {
        items = [];
        items.addAll(dData);
      });
      return;
    } else {
      setState(() {
        items = [];
        items = alnote;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
          title: const Text(
            'Notes',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  setState(() {
                    helper.allnotes();
                  });
                },
                child: Text(
                  'REFRESH',
                  style: TextStyle(color: Colors.green),
                )),
            PopupMenuButton(
              itemBuilder: (
                BuildContext context,
              ) =>
                  <PopupMenuItem>[
                PopupMenuItem(
                  height: 7,
                  onTap: () {},
                  child: TextButton(
                    child: Text('Settings'),
                    onPressed: () {},
                  ),
                ),
                PopupMenuItem(
                  height: 7,
                  onTap: () {},
                  child: TextButton(
                    child: Text('Favorite'),
                    onPressed: () {},
                  ),
                ),
              ],
            )
          ]),
      body: Container(
        child: ConditionalBuilder(
            condition: items != null,
            builder: (context) => Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if (items.length == 0)
                      Center(
                        child: Text(
                          'NO NOTES YET....',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.brown),
                        ),
                      )
                    else
                      Expanded(
                        child: CustomScrollView(
                          slivers: [
                            SliverAppBar(
                              expandedHeight: 50,
                              title: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height: 45,
                                  child: TextField(
                                    controller: tsearch,
                                    onChanged: ((v) {
                                      setState(() {
                                        Search(v);
                                      });
                                    }),
                                    decoration: InputDecoration(
                                        hintText: 'Search',
                                        labelText: 'Search',
                                        prefixIcon: Icon(Icons.search),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(25)),
                                        )),
                                  ),
                                ),
                              ),
                              flexibleSpace: FlexibleSpaceBar(),
                            ),

                            SliverList(
                              delegate: SliverChildBuilderDelegate(
                                (_, int index) {
                                  noteModel note =
                                      noteModel.fromMap(items[index]);

                                  return ListTile(
                                    title: buildnote(note),
                                  );
                                },
                                childCount: items.length,
                              ),
                            ),

                            // ConditionalBuilder(
                            //     condition: items != null,
                            //     builder: (context) => Column(
                            //       mainAxisAlignment: MainAxisAlignment.start,
                            //       children: [
                            //         Padding(
                            //           padding: const EdgeInsets.all(8.0),
                            //           child: Container(
                            //             height: 45,
                            //             child: TextField(
                            //               controller: tsearch,
                            //               onChanged: ((v) {
                            //                 setState(() {
                            //                   Search(v);
                            //                 });
                            //               }),
                            //               decoration: InputDecoration(
                            //                   hintText: 'Search',
                            //                   labelText: 'Search',
                            //                   prefixIcon: Icon(Icons.search),
                            //                   border: OutlineInputBorder(
                            //                     borderRadius:
                            //                     BorderRadius.all(Radius.circular(25)),
                            //                   )),
                            //             ),
                            //           ),
                            //         ),
                            //         Expanded(
                            //             child: ListView.separated(
                            //               scrollDirection: Axis.vertical,
                            //               physics: BouncingScrollPhysics(),
                            //               itemBuilder: (context, index) {
                            //                 noteModel note = noteModel.fromMap(items[index]);
                            //                 if (note == 0) {
                            //                   return Column(
                            //                     children: [
                            //                       Center(
                            //                         child: Text(
                            //                           'NO NOTES YET....',
                            //                           style: TextStyle(
                            //                               fontWeight: FontWeight.bold,
                            //                               color: Colors.brown),
                            //                         ),
                            //                       ),
                            //                     ],
                            //                   );
                            //                 } else
                            //                   return buildnote(note);
                            //               },
                            //               separatorBuilder: (context, index) => Padding(
                            //                 padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            //                 child: Container(
                            //                   height: 1,
                            //                   color: Colors.black12,
                            //                 ),
                            //               ),
                            //               itemCount: items.length,
                            //             )),
                            //         Column(
                            //           mainAxisAlignment: MainAxisAlignment.end,
                            //           children: [
                            //             Divider(),
                            //             Padding(
                            //               padding: const EdgeInsets.all(5.0),
                            //               child: Row(
                            //                 mainAxisSize: MainAxisSize.max,
                            //                 crossAxisAlignment: CrossAxisAlignment.center,
                            //                 children: [
                            //                   TextButton(
                            //                       onPressed: () {},
                            //                       child: Text('SELECT',
                            //                           style: TextStyle(
                            //                             color: Colors.brown,
                            //                             textBaseline: TextBaseline.ideographic,
                            //                           ))),
                            //                   Spacer(),
                            //                   Center(
                            //                     child: Text(
                            //                       '${items.length} notes',
                            //                       style: TextStyle(
                            //                           fontSize: 14, color: Colors.blueAccent),
                            //                     ),
                            //                   ),
                            //                   Spacer(),
                            //                   IconButton(
                            //                       onPressed: () {
                            //                         Navigator.push(
                            //                             context,
                            //                             MaterialPageRoute(
                            //                                 builder: (context) => writenote()));
                            //                       },
                            //                       icon: Icon(
                            //                         Icons.library_add_sharp,
                            //                         color: Colors.orange,
                            //                       ))
                            //                 ],
                            //               ),
                            //             ),
                            //           ],
                            //         ),
                            //       ],
                            //     ),
                            //     fallback: (context) => Center(child: CircularProgressIndicator())),
                          ],
                        ),
                      ),
                    SizedBox(
                      height: 300,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Divider(),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              TextButton(
                                  onPressed: () {},
                                  // ignore: prefer_const_constructors
                                  child: Text('SELECT',
                                      style: TextStyle(
                                        color: Colors.brown,
                                        textBaseline: TextBaseline.ideographic,
                                      ))),
                              Spacer(),
                              Center(
                                child: Text(
                                  '${items.length} notes',
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.blueAccent),
                                ),
                              ),
                              Spacer(),
                              IconButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => writenote()));
                                  },
                                  icon: Icon(
                                    Icons.library_add_sharp,
                                    color: Colors.orange,
                                  ))
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
            fallback: (context) => Center(child: CircularProgressIndicator())),
      ),

      // FutureBuilder(
      //   future: helper.allnotes(),
      //   builder: (context, AsyncSnapshot snapshot) {
      //     if (!snapshot.hasData) {
      //       return Center(
      //         child: CircularProgressIndicator(),
      //       );
      //     } else if (snapshot.data!.length == 0) {
      //       return Column(
      //         children: [
      //           Spacer(),
      //           Text(
      //             'NO NOTES YET....',
      //             style: TextStyle(
      //                 fontWeight: FontWeight.bold, color: Colors.brown),
      //           ),
      //           Spacer(),
      //           Column(
      //             mainAxisAlignment: MainAxisAlignment.end,
      //             children: [
      //               Divider(),
      //               Padding(
      //                 padding: const EdgeInsets.all(5.0),
      //                 child: Row(
      //                   mainAxisSize: MainAxisSize.max,
      //                   crossAxisAlignment: CrossAxisAlignment.center,
      //                   children: [
      //                     TextButton(
      //                         onPressed: () {},
      //                         child: Text('SELECT',
      //                             style: TextStyle(
      //                               color: Colors.brown,
      //                               // textBaseline: TextBaseline.ideographic,
      //                             ))),
      //                     Spacer(),
      //                     Center(
      //                       child: Text(
      //                         '${snapshot.data!.length} notes',
      //                         style: TextStyle(
      //                             fontSize: 14, color: Colors.blueAccent),
      //                       ),
      //                     ),
      //                     Spacer(),
      //                     IconButton(
      //                         onPressed: () {
      //                           Navigator.push(
      //                               context,
      //                               MaterialPageRoute(
      //                                   builder: (context) => writenote()));
      //                         },
      //                         icon: Icon(
      //                           Icons.library_add_sharp,
      //                           color: Colors.orange,
      //                         ))
      //                   ],
      //                 ),
      //               ),
      //             ],
      //           ),
      //         ],
      //       );
      //     } else {
      //       return
      //     }
      //   },
      // ),
    );
  }

  Widget buildnote(noteModel note) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(17.0),
          child: InkWell(
            splashColor: Colors.orangeAccent,
            onLongPress: () {
              showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                        content:
                            Text('ARE YOU SURE YOU WANT TO DELETE THIS NOTE?'),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text('No')),
                          TextButton(
                              onPressed: () {
                                setState(() {
                                  helper.delete(note.id!);
                                });
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => notesScreen()),
                                    (route) {
                                  return false;
                                });
                              },
                              child: Text('yes')),
                        ],
                      ));
            },
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => noteDetails(note)));
            },
            child: Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      '${note.Text}',
                      maxLines: 3,
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          overflow: TextOverflow.fade),
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        'Created on:',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        '${note.date}',
                        style: TextStyle(
                          color: Colors.blueAccent,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
