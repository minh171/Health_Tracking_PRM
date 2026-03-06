class HealthTip {
  final int? id;
  final String type;
  final String level;
  final String content;

  HealthTip({this.id, required this.type, required this.level, required this.content});

  factory HealthTip.fromMap(Map<String, dynamic> map) => HealthTip(
    id: map['id'], type: map['type'], level: map['level'], content: map['content'],
  );
}