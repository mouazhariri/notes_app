import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:notes_app/Cubit/cubit.dart';
import 'package:notes_app/db/db.dart';
import 'package:notes_app/model/note_model.dart';
import 'package:notes_app/module/notes_Screen.dart';

class writenote extends StatefulWidget {
  @override
  State<writenote> createState() => _writenoteState();
}

class _writenoteState extends State<writenote> {
  TextEditingController noteController = TextEditingController();
  String? text;
  late DateTime date = DateTime.now();
  late DbHelper helper;
  noteModel? model;
  @override
  void initState() {
    helper = DbHelper();

    super.initState();
    // text = model!.Text!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Write your Note',
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.ios_share,
                color: Colors.green,
              )),
          SizedBox(
            width: 15,
          ),
          TextButton.icon(
            onPressed: () {
              noteModel note = noteModel(
                Text: text,
                date: DateFormat("yyyy/MMM/dd {hh:mm} ").format(DateTime.now()),
              );
              helper.insert(note: note);
              // setState(() {
              //   helper!.allCourses();
              // });
              Navigator.pushAndRemoveUntil(context,
                  MaterialPageRoute(builder: (context) => notesScreen()),
                  (route) {
                return false;
              });

              // setState(() {
              //   var note = noteModel({
              //     'Text': text,
              //   });
              // });
              // await helper!.createCourse(note);
            },
            icon: Icon(
              Icons.save,
              color: Colors.black12,
            ),
            label: Text('SAVE'),
          ),
        ],
      ),
      body: Form(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  style: Theme.of(context).textTheme.bodyText1,
                  maxLines: null,
                  onChanged: (e) {
                    setState(() {
                      text = e;
                    });
                  },
                  controller: noteController,
                  decoration: InputDecoration(
                      border: InputBorder.none, hintText: 'Write Here.....'),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                children: [
                  IconButton(
                      onPressed: () {},
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
