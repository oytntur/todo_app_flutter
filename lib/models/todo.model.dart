import 'package:uuid/uuid.dart';

class TodoItem {
  String? uuid;
  String title;
  String subtitle;

  TodoItem({required this.title, required this.subtitle, String? uuid})
      : uuid = (uuid ?? const Uuid().v4());
}
