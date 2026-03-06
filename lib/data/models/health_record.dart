class HealthRecord {
  final int? id;
  final int accountId;
  final String type; // 'Huyết Áp', 'Đường Huyết',...
  final double value1;
  final double? value2;
  final int? heartRate;
  final String unit;
  final String? note;
  final String measuredAt;

  HealthRecord({this.id, required this.accountId, required this.type, required this.value1, this.value2, this.heartRate, required this.unit, this.note, required this.measuredAt});

  Map<String, dynamic> toMap() => {
    'id': id, 'account_id': accountId, 'type': type, 'value_1': value1, 'value_2': value2, 'heart_rate': heartRate, 'unit': unit, 'note': note, 'measured_at': measuredAt,
  };

  factory HealthRecord.fromMap(Map<String, dynamic> map) => HealthRecord(
    id: map['id'], accountId: map['account_id'], type: map['type'], value1: map['value_1'], value2: map['value_2'], heartRate: map['heart_rate'], unit: map['unit'], note: map['note'], measuredAt: map['measured_at'],
  );
}