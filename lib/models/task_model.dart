class Task {
  int? id;
  String title;
  String? notes;
  int isDone; // 0=false, 1=true
  int createdAt;

  Task({
    this.id,
    required this.title,
    this.notes,
    this.isDone = 0,
    int? createdAt,
  }) : createdAt = createdAt ?? DateTime.now().millisecondsSinceEpoch;

  factory Task.fromMap(Map<String, dynamic> map) => Task(
    id: map['id'],
    title: map['title'],
    notes: map['notes'],
    isDone: map['isDone'],
    createdAt: map['createdAt'],
  );

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{
      'title': title,
      'notes': notes,
      'isDone': isDone,
      'createdAt': createdAt,
    };
    if (id != null) map['id'] = id;
    return map;
  }
}
