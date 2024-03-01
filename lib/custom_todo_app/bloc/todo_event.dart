import 'package:flutter_application_1/custom_todo_app/model/todo_model.dart';

class Event {}

class AddEvent extends Event {
  String content;
  AddEvent(this.content);
}

class DeleEvent extends Event {
  TodoModel? todo;
  DeleEvent(this.todo);
}

class UpdateEvent extends Event {
  int id;
  String content;
  
  UpdateEvent(this.id, this.content);
}
