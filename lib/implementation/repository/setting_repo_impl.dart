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

  @override
  Future<int> resetThresholdsToDefault(
      int accountId,
      Map<String, dynamic> profileData,
      List<int> diseaseIds
      ) async {
    // Tận dụng chính hàm logic y khoa mà bạn đã viết trong DatabaseHelper
    return await _dbHelper.updateInitialProfile(accountId, profileData, diseaseIds);
  }
}