import 'package:flutter/material.dart';
import 'package:notes/notes_add.dart';

class NotesScreen extends StatelessWidget {
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
            onPressed: () {

            },
          ),
        ],
      ),
      body: Center(
        child: Column(
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
        ),
      ),
      floatingActionButton: Container(
        margin: EdgeInsets.only(bottom: 16),
        child: FloatingActionButton(
          onPressed: () {

            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => NotesAdd()),
            );
          },
          child: Icon(Icons.add),
          backgroundColor: Colors.grey.shade900,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }
}