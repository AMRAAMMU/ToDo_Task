import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:notes/models/getmodel.dart';
import 'package:notes/utils/utils.dart';

class NotesScreenController extends GetxController {
  //fetching the notes from the database
  Future<List<Getnotesmodel>> getNotes() async {
    try {
      const url = "http://159.89.161.169:3001/api/user/notes";
      final uri = Uri.parse(url);
      final response = await http.get(uri);
      final responseData = jsonDecode(response.body);
      final notesDataResponse = responseData["data"];
      List<Getnotesmodel> fetchedNotesData = [];
      if (!responseData["error"]) {
        for (var element in notesDataResponse) {
          Getnotesmodel eachNotesData = Getnotesmodel.fromJson(element);
          fetchedNotesData.add(eachNotesData);
        }
      } else {
        Utils.showErrorMessage(
            message: "Fetching of notes failed, please try later.");
      }
      return fetchedNotesData;
    } catch (e) {
      rethrow;
    }
  }

  //adding notes to the database
  void addNote({
    required String title,
    required String description,
  }) async {
    try {
      const url = "http://159.89.161.169:3001/api/user/notes";
      final uri = Uri.parse(url);
      final headers = {'Content-Type': 'application/json'};
      final body = {
        "title": title,
        "description": description,
      };
      await http.post(uri, headers: headers, body: jsonEncode(body));
    } catch (e) {
      rethrow;
    }
  }

  //updating the note
  void updateNote({
    required String title,
    required String description,
    required int id,
  }) async {
    try {
      final url = "http://159.89.161.169:3001/api/user/notes/$id";
      final uri = Uri.parse(url);
      final headers = {'Content-Type': 'application/json'};
      final body = {
        "title": title,
        "description": description,
      };
      await http.put(
        uri,
        headers: headers,
        body: jsonEncode(body),
      );
    } catch (e) {
      rethrow;
    }
  }

  //deleting the note
  void deleteNote({
    required int id,
  }) async {
    try {
      final url = "http://159.89.161.169:3001/api/user/notes/$id";
      final uri = Uri.parse(url);
      await http.delete(uri);
    } catch (e) {
      rethrow;
    }
  }
}
