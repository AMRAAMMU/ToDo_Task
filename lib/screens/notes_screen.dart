import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes/controllers/crud_controllers.dart';
import 'package:notes/models/getmodel.dart';
import 'package:notes/search.dart';
import 'note_details.dart';
import 'notes_add.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({Key? key});

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  final controllers = Get.put(NotesScreenController());

  @override
  void initState() {
    super.initState();
    fetchNotes();
  }

  void fetchNotes() async {
    List<Getnotesmodel> fetchedNotes = await controllers.getNotes();
    setState(() {
      notesList = fetchedNotes;
    });
  }

  List<Getnotesmodel> notesList = [];

  List<Color> containerColors = [
    Colors.purpleAccent.shade100,
    Colors.pinkAccent.shade100,
    Colors.greenAccent.shade100,
    Colors.yellowAccent.shade100,
    Colors.orangeAccent.shade100,
  ];

  void onContainerTap(Getnotesmodel selectedNote) {}

  void _onDeleteIconTap(int index) {
    controllers.deleteNote(id: notesList[index].id);
    setState(() {
      notesList.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade900,
        title: const Text(
          'Notes',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 25,
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white),
            onPressed: () {
              showSearch(
                context: context,
                delegate: NotesSearchDelegate(
                  notesList: notesList,
                  resetNotes: fetchNotes,
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.info_outline, color: Colors.white),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(alignment: Alignment.center,
                    title: const Text('Designed by-\nRedesigned by-\nIllustration-\nIcons-\nFonts-'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('OK'),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
      body: notesList.isNotEmpty
          ? Column(children: [
        Expanded(
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: notesList.length,
            itemBuilder: (context, index) {
              return Dismissible(
                key: Key(notesList[index].id.toString()),
                onDismissed: (direction) {
                  _onDeleteIconTap(index);
                },
                background: Container(
                  color: Colors.red,
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.only(right: 16),
                  child: const Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                ),
                child: GestureDetector(
                  onTap: () {
                    Get.to(() => const NotesDetails(),
                        arguments: notesList[index]);
                  },
                  child: Container(
                    margin: const EdgeInsets.all(16),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: containerColors[
                      index % containerColors.length],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              notesList[index].title,
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Icon(
                              Icons.chevron_left,
                              color: Colors.white,
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Text(
                          notesList[index].description,
                          style: const TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ])
          : Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/img1.png',
              width: 200,
              height: 200,
            ),
            const SizedBox(height: 8),
            const Text(
              'Create your first note!',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white60,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Container(
        margin: const EdgeInsets.only(bottom: 16),
        child: FloatingActionButton(
          onPressed: () async {
            final newNote = await Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const NotesAdd()),
            );
          },
          backgroundColor: Colors.grey.shade900,
          child: const Icon(Icons.add, color: Colors.white),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }
}
