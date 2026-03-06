class Disease {
  final int? id;
  final String name;

  Disease({this.id, required this.name});

  factory Disease.fromMap(Map<String, dynamic> map) => Disease(id: map['id'], name: map['name']);
}