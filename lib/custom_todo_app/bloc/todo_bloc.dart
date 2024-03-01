import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/custom_todo_app/bloc/todo_event.dart';
import 'package:flutter_application_1/custom_todo_app/db/todo_table_custom.dart';
import 'package:flutter_application_1/custom_todo_app/model/todo_model.dart';

abstract class BaseBloc2 {
  final StreamController<Event> _eventController = StreamController();

  Sink<Event> get event => _eventController.sink;

  BaseBloc2() {
    _eventController.stream.listen((event) {
      dispatchEvent(event);
    }); 
  }

  void dispatchEvent(Event event);


  void dispose() {
    _eventController.close();
  }
}

class TodoBloc2 extends BaseBloc2 {
  final StreamController<List<TodoModel>> _streamController =
      StreamController<List<TodoModel>>();

  Stream<List<TodoModel>> get stream => _streamController.stream;

  List<TodoModel> _listTodo = [];
  final _randomId = Random();
  TodoTableCustom _todoTable = TodoTableCustom();

  initData() async {
    _listTodo =  await _todoTable.getAllTodo();

    _listTodo ??= [];

    _streamController.sink.add(_listTodo);
  }

  _addEvent(TodoModel todo) {
    _todoTable.insertTable(todo);

    _listTodo.insert(0, todo);
    _streamController.sink.add(_listTodo);
  }

  _deleEvent(TodoModel? todo)  {
     _todoTable.deleItem(todo);

    _listTodo.remove(todo);
    _streamController.sink.add(_listTodo);
  }

  _updateData(TodoModel todo)  {
     _todoTable.updateTable(todo);
  }

  @override
  void dispatchEvent(Event event) {
    if (event is AddEvent) {
      TodoModel todo =
          TodoModel(id: _randomId.nextInt(1000), content: event.content);

      _addEvent(todo);
    } else if (event is DeleEvent) {
      _deleEvent(event.todo);
    } else if (event is UpdateEvent) {
      print(event.content);

      TodoModel updatedTodo = TodoModel(id: event.id, content: event.content);
      _updateData(updatedTodo);

      print('${event.id}');
      _listTodo[_listTodo.indexWhere((todo) => todo.id == event.id)] =
          updatedTodo;

      _streamController.sink.add(_listTodo);
    }
  }

  @override
  void dispose() {
    _streamController.close();
    super.dispose();
  }
}
