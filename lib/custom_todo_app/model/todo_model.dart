class TodoModel {

  int? id;
  String? content;

  TodoModel({this.id, this.content});

  factory TodoModel.fromData(Map<String, dynamic> map){
    return TodoModel(
      id: map['id'],
      content: map['content']
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'content': content,
    };
  }
}
