import '../../data/database/database_helper.dart';
import '../../interface/repository/isetting_repository.dart';

class SettingRepository implements ISettingRepository {
  final DatabaseHelper _dbHelper = DatabaseHelper.instance;

  @override
  Future<List<Map<String, dynamic>>> getAlertSettings(int accountId) async {
    return await _dbHelper.getAlertSettings(accountId);
  }

  @override
  Future<int> updateAlertSetting(int accountId, String keyName, double newValue) async {
    return await _dbHelper.updateAlertSetting(accountId, keyName, newValue);
  }
}