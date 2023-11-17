import 'package:flutter/material.dart';
import 'package:notes/note.dart';
import 'note_details.dart';
import 'notes_add.dart';

class NotesScreen extends StatefulWidget {
  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  List<Note> notes = [];

  List<Color> containerColors = [
    Colors.purpleAccent.shade100,
    Colors.pinkAccent.shade100,
    Colors.greenAccent.shade100,
    Colors.yellowAccent.shade100,
    Colors.orangeAccent.shade100,
  ];

  void _onContainerTap(Note selectedNote) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NotesDetails(note: selectedNote),
      ),
    );
  }

  void _onDeleteIconTap(int index) {
    setState(() {
      notes.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade900,
        title: Text(
          'Notes',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 25,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      body: Center(
        child: notes.isEmpty
            ? Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/img1.png',
              width: 200,
              height: 200,
            ),
            SizedBox(height: 8),
            Text(
              'Create your first note!',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white60,
              ),
            ),
          ],
        )
            : ListView.builder(
          itemCount: notes.length,
          itemExtent: 110,
          itemBuilder: (context, index) {
            return Dismissible(
              key: Key(notes[index].id.toString()),
              onDismissed: (direction) {
                _onDeleteIconTap(index);
              },
              background: Container(
                color: Colors.red,
                alignment: Alignment.centerRight,
                padding: EdgeInsets.only(right: 16),
                child: Icon(
                  Icons.delete,
                  color: Colors.white,
                ),
              ),
              child: GestureDetector(
                onTap: () {
                  _onContainerTap(notes[index]);
                },
                child: Container(
                  margin: EdgeInsets.all(16),
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: containerColors[index % containerColors.length],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            notes[index].title,
                            style: TextStyle(color: Colors.white),
                          ),
                          Icon(
                            Icons.delete,
                            color: Colors.white,
                          ),
                        ],
                      ),
                      SizedBox(height: 6),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Text(
                            notes[index].content,
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: Container(
        margin: EdgeInsets.only(bottom: 16),
        child: FloatingActionButton(
          onPressed: () async {
            final newNote = await Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => NotesAdd()),
            );
            if (newNote != null) {
              setState(() {
                notes.add(newNote);
              });
            }
          },
          child: Icon(Icons.add),
          backgroundColor: Colors.grey.shade900,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }
}

