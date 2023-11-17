import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/get_core.dart';
import 'package:notes/controllers/crud_controllers.dart';
import 'package:notes/screens/notes_screen.dart';

class NotesAdd extends StatefulWidget {
  final String? initialTitle;
  final String? initialContent;

  const NotesAdd({Key? key, this.initialTitle, this.initialContent})
      : super(key: key);

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
    final controller = Get.put(NotesScreenController());
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade900,
        iconTheme: IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            onPressed: () {
              controller.addNote(
                  title: _titleController.text,
                  description: _contentController.text);
              Get.offAll(NotesScreen());
            },
            icon: const Icon(Icons.save,color: Colors.white,),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              TextField(
                controller: _titleController,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
                maxLines: 2,
                decoration: const InputDecoration(
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
              TextField(
                controller: _contentController,
                style: const TextStyle(color: Colors.white, fontSize: 18),
                maxLines: 25,
                decoration: const InputDecoration(
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
