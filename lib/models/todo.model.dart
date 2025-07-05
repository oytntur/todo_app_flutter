import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class TodoItem {
  String uuid;
  String title;
  String subtitle;
  bool isDone = false;

  TodoItem(
      {required this.title, required this.subtitle, bool? isDone, String? uuid})
      : uuid = (uuid ?? const Uuid().v4());

  Map<String, dynamic> toJson() => {
        'uuid': uuid,
        'title': title,
        'subtitle': subtitle,
        'isDone': isDone,
      };

  factory TodoItem.fromJson(Map<String, dynamic> json) => TodoItem(
        uuid: json['uuid'],
        title: json['title'],
        subtitle: json['subtitle'],
        isDone: json['isDone'] ?? false,
      );

  Future<void> addOrUpdateTodo() async {
    final todos = FirebaseFirestore.instance.collection('todos');
    final query = await todos.where('uuid', isEqualTo: uuid).limit(1).get();

    if (query.docs.isNotEmpty) {
      // Güncelle
      await query.docs.first.reference.update(toJson());
    } else {
      // Yeni kayıt
      await todos.add(toJson());
    }
  }
}
