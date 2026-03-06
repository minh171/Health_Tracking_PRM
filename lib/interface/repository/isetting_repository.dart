abstract class ISettingRepository {
  Future<List<Map<String, dynamic>>> getAlertSettings(int accountId);

  Future<int> updateAlertSetting(int accountId, String keyName, double newValue);
}