class AppNotification {
  final int? id;
  final int recordId;
  final String title;
  final String content;
  final String level; // 'stable', 'warning', 'danger'
  final int isRead; // 0 hoặc 1
  final String createdAt;

  AppNotification({this.id, required this.recordId, required this.title, required this.content, required this.level, this.isRead = 0, required this.createdAt});

  Map<String, dynamic> toMap() => {
    'id': id, 'record_id': recordId, 'title': title, 'content': content, 'level': level, 'is_read': isRead, 'created_at': createdAt,
  };

  factory AppNotification.fromMap(Map<String, dynamic> map) => AppNotification(
    id: map['id'], recordId: map['record_id'], title: map['title'], content: map['content'], level: map['level'], isRead: map['is_read'], createdAt: map['created_at'],
  );
}