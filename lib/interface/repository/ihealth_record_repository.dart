abstract class IHealthRecordRepository {
  Future<List<Map<String, dynamic>>> getAllRecords(int accountId);

  Future<List<Map<String, dynamic>>> getRecordsByType(int accountId, String type, {bool descending = true});

  Future<Map<String, dynamic?>> getLatestRecords(int accountId);

  Future<int> insertRecord(Map<String, dynamic> row);

  Future<int> updateRecord(Map<String, dynamic> row);

  Future<int> deleteRecord(int id);
}