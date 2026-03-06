class AlertSetting {
  final int? id;
  final int accountId;
  final String keyName;
  final double value;
  final String unit;

  AlertSetting({this.id, required this.accountId, required this.keyName, required this.value, required this.unit});

  Map<String, dynamic> toMap() => {'id': id, 'account_id': accountId, 'key_name': keyName, 'value': value, 'unit': unit};

  factory AlertSetting.fromMap(Map<String, dynamic> map) => AlertSetting(
    id: map['id'], accountId: map['account_id'], keyName: map['key_name'], value: map['value'], unit: map['unit'],
  );
}