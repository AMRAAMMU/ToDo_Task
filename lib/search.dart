import 'package:flutter/material.dart';
import 'package:notes/models/getmodel.dart';

class NotesSearchDelegate extends SearchDelegate {
  final List<Getnotesmodel> notesList;
  final VoidCallback resetNotes;

  NotesSearchDelegate({required this.notesList, required this.resetNotes});

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
          resetNotes();
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  Widget _buildListView(List<Getnotesmodel> itemList) {
    if (itemList.isEmpty) {
      return Center(
        child: Container(
          color: Colors.grey.shade900,
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/img2.png',
                height: 200.0,
                width: 500,
              ),
              SizedBox(height: 16.0),
              Text(
                'No results found',
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
      );
    }

    return Container(
      color: Colors.grey.shade900,
      child: ListView.builder(
        itemCount: itemList.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(
              itemList[index].title,
              style: TextStyle(color: Colors.white),
            ),
            onTap: () {
              close(context, itemList[index]);
            },
          );
        },
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final List<Getnotesmodel> searchResults = query.isEmpty
        ? []
        : notesList
        .where((note) =>
        note.title.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return _buildListView(searchResults);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final List<Getnotesmodel> suggestionList = query.isEmpty
        ? []
        : notesList
        .where((note) =>
        note.title.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return _buildListView(suggestionList);
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return theme.copyWith(
      primaryColor: Colors.grey.shade900,
      textTheme: theme.textTheme.copyWith(
        headline6: theme.textTheme.headline6!.copyWith(
          color: Colors.black,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: TextStyle(color: Colors.black),
      ),
    );
  }
}
