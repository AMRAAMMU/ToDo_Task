import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes/controllers/crud_controllers.dart';
import 'package:notes/screens/notes_screen.dart';

class NotesDetails extends StatefulWidget {
  const NotesDetails({Key? key}) : super(key: key);

  @override
  NotesDetailsState createState() => NotesDetailsState();
}

class NotesDetailsState extends State<NotesDetails> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _contentController = TextEditingController();
  bool _isEditing = false;

  @override
  Widget build(BuildContext context) {
    final arg = Get.arguments;
    final controller = Get.put(NotesScreenController());
    _titleController = TextEditingController(text: arg.title);
    _contentController = TextEditingController(text: arg.description);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey.shade900,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade900,
        iconTheme: IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit, color: Colors.white),
            onPressed: () {
              setState(() {

                _isEditing = !_isEditing;
                if (!_isEditing) {

                  _titleController.text = arg.title;
                  _contentController.text = arg.description;
                }
              });
            },
          ),
          IconButton(
            icon: const Icon(Icons.save, color: Colors.white),
            onPressed: () {
              controller.updateNote(
                title: _titleController.text,
                description: _contentController.text,
                id: arg.id,
              );
              Get.offAll(NotesScreen());
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 16, top: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: _titleController,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              readOnly: !_isEditing,
              decoration: const InputDecoration(
                hintText: 'Title',
                hintStyle: TextStyle(
                  color: Colors.grey,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                border: InputBorder.none,
              ),
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _contentController,
              style: const TextStyle(fontSize: 18, color: Colors.white),
              readOnly: !_isEditing,
              maxLines: 22,
              decoration: const InputDecoration(
                hintText: 'Content',
                hintStyle: TextStyle(color: Colors.grey, fontSize: 18),
                border: InputBorder.none,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
