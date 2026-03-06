class UserDisease {
  final int accountId;
  final int diseaseId;

  UserDisease({required this.accountId, required this.diseaseId});

  Map<String, dynamic> toMap() => {'account_id': accountId, 'disease_id': diseaseId};
}