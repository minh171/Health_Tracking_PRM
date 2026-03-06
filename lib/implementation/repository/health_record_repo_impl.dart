import '../../data/database/database_helper.dart';
import '../../interface/repository/ihealth_record_repository.dart';

class HealthRecordRepository implements IHealthRecordRepository {
  final DatabaseHelper _dbHelper = DatabaseHelper.instance;

  @override
  Future<List<Map<String, dynamic>>> getAllRecords(int accountId) async {
    return await _dbHelper.getAllHealthRecords(accountId);
  }

  @override
  Future<List<Map<String, dynamic>>> getRecordsByType(int accountId, String type, {bool descending = true}) async {
    return await _dbHelper.getRecordsByType(accountId, type, descending: descending);
  }

  @override
  Future<Map<String, dynamic?>> getLatestRecords(int accountId) async {
    return await _dbHelper.getLatestRecords(accountId);
  }

  @override
  Future<int> insertRecord(Map<String, dynamic> row) async {
    return await _dbHelper.insertHealthRecord(row);
  }

  @override
  Future<int> updateRecord(Map<String, dynamic> row) async {
    return await _dbHelper.updateHealthRecord(row);
  }

  @override
  Future<int> deleteRecord(int id) async {
    return await _dbHelper.deleteHealthRecord(id);
  }
}