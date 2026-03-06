class UserProfile {
  final int? id;
  final int accountId;
  final String? fullName;
  final String? dob;
  final String? gender;
  final double? height;
  final double? weight;
  final String? updatedAt;

  UserProfile({this.id, required this.accountId, this.fullName, this.dob, this.gender, this.height, this.weight, this.updatedAt});

  Map<String, dynamic> toMap() => {
    'id': id, 'account_id': accountId, 'full_name': fullName, 'dob': dob, 'gender': gender, 'height': height, 'weight': weight, 'updated_at': updatedAt,
  };

  factory UserProfile.fromMap(Map<String, dynamic> map) => UserProfile(
    id: map['id'], accountId: map['account_id'], fullName: map['full_name'], dob: map['dob'], gender: map['gender'], height: map['height'], weight: map['weight'], updatedAt: map['updated_at'],
  );
}