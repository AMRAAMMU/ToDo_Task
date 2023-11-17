import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notes/note.dart';

class NotesAdd extends StatefulWidget {
  final String? initialTitle;
  final String? initialContent;

  NotesAdd({Key? key, this.initialTitle, this.initialContent}) : super(key: key);

  @override
  State<NotesAdd> createState() => _NotesAddState();
}

class _NotesAddState extends State<NotesAdd> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _titleController.text = widget.initialTitle ?? '';
    _contentController.text = widget.initialContent ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade900,
        actions: [
          IconButton(
            onPressed: () {
              String title = _titleController.text;
              String content = _contentController.text;
              Note newNote = Note(title: title, content: content, id: 1);
              Navigator.pop(context, newNote);
            },
            icon: Icon(Icons.save),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 8),
              TextField(
                controller: _titleController,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
                maxLines: 2,
                decoration: InputDecoration(
                  hintText: 'Title',
                  border: InputBorder.none,
                  hintStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
                onEditingComplete: () {
                  FocusScope.of(context).nextFocus();
                },
              ),
              SizedBox(height: 16),
              TextField(
                controller: _contentController,
                style: TextStyle(color: Colors.white, fontSize: 18),
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
      ),
    );
  }
}