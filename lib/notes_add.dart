import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notes/notes_screen.dart';

class NotesAdd extends StatefulWidget {
  const NotesAdd({Key? key}) : super(key: key);

  @override
  State<NotesAdd> createState() => _NotesAddState();
}

class _NotesAddState extends State<NotesAdd> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade900,

        actions: [ IconButton(
          onPressed: () {},
          icon: Icon(Icons.edit),
        ),
          IconButton(
            onPressed: () {
              String title = _titleController.text;
              String content = _contentController.text;


              print('Title: $title, Content: $content');
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NotesScreen()),
              );
            },
            icon: Icon(Icons.save),
          ),

        ],
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 8),
            TextField(
              controller: _titleController,
              style: TextStyle(color: Colors.white),
              maxLines: 2,
              decoration: InputDecoration(
                hintText: 'Title',
                border: InputBorder.none,
                hintStyle: TextStyle(color: Colors.grey, fontSize: 28),
              ),
              onEditingComplete: () {

                FocusScope.of(context).nextFocus();
              },
            ),
            SizedBox(height: 16),
            TextField(
              controller: _contentController,
              style: TextStyle(color: Colors.white),
              maxLines: 25,
              decoration: InputDecoration(
                hintText: 'Type Something...',
                border: InputBorder.none,
                hintStyle: TextStyle(color: Colors.grey, fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}