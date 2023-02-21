import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

class NetworkService {
  /// baseUrl API for emulator we can use "http://10.0.2.2:3000". `NetworkService()`.
  final baseUrl = "http://10.0.2.2:3000";

  /// This function will fetching/get Todos then return json decode as `List`
  Future<List<dynamic>> fetchTodos() async {
    try {
      final response = await get(Uri.parse("$baseUrl/todos"));
      debugPrint(response.body); // For Testing.
      return jsonDecode(response.body) as List;
    } catch (e) {
      debugPrint("fetchTodos: $e");
      return [];
    }
  }

  /// This function will patch/updating/editing Todos then return `bool`.
  Future<bool> patchTodo(Map<String, String> patchObj, int id) async {
    try {
      await patch(Uri.parse("$baseUrl/todos/$id"), body: patchObj);
      return true;
    } catch (e) {
      return false;
    }
  }

  /// This function will post/adding Todos then return jsonDecode(response.body).
  Future<Map?> addTodo(Map<String, String> todoObj) async {
    try {
      final response = await post(Uri.parse("$baseUrl/todos"), body: todoObj);
      return jsonDecode(response.body);
    } catch (e) {
      return null;
    }
  }

  /// This function will delete Todos then return `bool`.
  Future<bool?> deleteTodo(int id) async {
    try {
      await delete(Uri.parse("$baseUrl/todos/$id"));
      return true;
    } catch (e) {
      return null;
    }
  }
}
