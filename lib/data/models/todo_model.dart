class TodoModel {
  String todoMessage;
  bool isCompleted;
  int id;

  TodoModel.fromJson(Map json)
      : todoMessage = json["todo"],
        isCompleted = json["isCompleted"] == "true",
        id = json["id"] as int;
}
