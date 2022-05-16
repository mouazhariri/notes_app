import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:notes_app/db/db.dart';
import 'package:notes_app/model/note_model.dart';
import 'package:notes_app/module/notes_Screen.dart';

class noteDetails extends StatefulWidget {
  noteModel model;
  noteDetails(this.model);
  @override
  _noteDetailsState createState() => _noteDetailsState();
}

class _noteDetailsState extends State<noteDetails> {
  @override
  TextEditingController noteController = TextEditingController();
  String? text;
  late DateTime date = DateTime.now();
  DbHelper? helper;

  @override
  void initState() {
    helper = DbHelper();

    super.initState();
    noteController.text = widget.model.Text!;
    // text = model!.Text!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'your Note',
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.ios_share,
                color: Colors.green,
              )),
        ],
      ),
      body: Form(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Stack(children: [
                  TextFormField(
                    style: Theme.of(context).textTheme.bodyText1,
                    maxLines: null,
                    controller: noteController,
                    decoration: InputDecoration(
                        border: InputBorder.none, hintText: 'Write Here.....'),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CircleAvatar(
                              radius: 30,
                              child: IconButton(
                                icon: Icon(
                                  Icons.save,
                                  color: Colors.blueAccent,
                                ),
                                onPressed: () {
                                  var note = noteModel(
                                    id: widget.model.id,
                                    Text: noteController.text,
                                    date: DateFormat("yyyy/MMM/dd {hh:mm} ")
                                        .format(DateTime.now()),
                                  );
                                  helper!.update(note);

                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => notesScreen()),
                                      (route) {
                                    return false;
                                  });
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ]),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                children: [
                  IconButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                  content: Text(
                                      'ARE YOU SURE YOU WANT TO DELETE THIS NOTE?'),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text('No')),
                                    TextButton(
                                        onPressed: () {
                                          helper!.delete(widget.model.id!);
                                          Navigator.pushAndRemoveUntil(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      notesScreen()), (route) {
                                            return false;
                                          });
                                        },
                                        child: Text('yes')),
                                  ],
                                ));
                      },
                      icon: Icon(
                        Icons.delete,
                        color: Colors.grey,
                      )),
                  Spacer(),
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.add_circle_rounded,
                        color: Colors.black38,
                      )),
                  Spacer(),
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.star,
                        color: Colors.yellow,
                      )),
                  Spacer(),
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.edit,
                        color: Colors.orange,
                      )),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
