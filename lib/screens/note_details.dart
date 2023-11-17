import 'package:flutter/material.dart';
import '../note.dart';


class NotesDetails extends StatefulWidget {
  final Note note;

  const NotesDetails({Key? key, required this.note}) : super(key: key);

  @override
  _NotesDetailsState createState() => _NotesDetailsState();
}

class _NotesDetailsState extends State<NotesDetails> {
  late TextEditingController _titleController;
  late TextEditingController _contentController;
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.note.title);
    _contentController = TextEditingController(text: widget.note.content);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade900,
        actions: [
          IconButton(
            icon: _isEditing ? Icon(Icons.save) : Icon(Icons.edit),
            onPressed: () {
              if (_isEditing) {
                _showSaveAlert();
              } else {
                setState(() {
                  _isEditing = true;
                });
              }
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 16, top: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: _titleController,
              style: TextStyle(fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
              readOnly: !_isEditing,
              decoration: InputDecoration(
                hintText: 'Title',
                hintStyle: TextStyle(color: Colors.grey,
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
                border: InputBorder.none, // Remove input border
              ),
            ),
            SizedBox(height: 12),
            TextFormField(
              controller: _contentController,
              style: TextStyle(fontSize: 18, color: Colors.white),
              readOnly: !_isEditing,
              maxLines: 22,
              decoration: InputDecoration(
                hintText: 'Content',
                hintStyle: TextStyle(color: Colors.grey, fontSize: 18),
                border: InputBorder.none, // Remove input border
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showSaveAlert() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.grey.shade800,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Info Icon
              Icon(
                Icons.info_outline,
                color: Colors.grey,
                size: 40,
              ),
              SizedBox(height: 10),
              Text(
                "Save Changes?",
                style: TextStyle(color: Colors.white, fontSize: 25),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.red,
                        padding: EdgeInsets.symmetric(horizontal: 20),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Cancel",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.green,
                        padding: EdgeInsets.symmetric(horizontal: 20),
                      ),
                      onPressed: () {
                        Navigator.pop(context, widget.note);
                      },
                      child: Text(
                        "Save",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    ).then((result) {
      // Show another alert when "Cancel" is pressed or "Keep" is pressed
      if (result == null) {
        _showDiscardAlert();
      }
    });
  }

  void _showDiscardAlert() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.grey.shade800,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Info Icon
              Icon(
                Icons.info_outline,
                color: Colors.grey,
                size: 40,
              ),
              SizedBox(height: 10),
              Text(
                "Are you sure you want to discard your changes?",
                style: TextStyle(color: Colors.white, fontSize: 25),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.red,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Discard",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.green,
                      ),
                      onPressed: () {
                        Navigator.pop(context, true);
                      },
                      child: Text(
                        "Keep",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    ).then((secondResult) {
      if (secondResult == true) {
        // User confirmed to cancel changes, show the first alert box again
        _showSaveAlert();
      }
    });
  }
}