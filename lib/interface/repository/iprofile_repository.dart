abstract class IProfileRepository {
  // Cập nhật profile, bệnh nền và khởi tạo ngưỡng mặc định
  Future<int> updateInitialProfile({
    required int accountId,
    required Map<String, dynamic> profileData,
    required List<int> diseaseIds
  });

  Future<Map<String, dynamic>?> getProfile(int accountId);

  Future<List<Map<String, dynamic>>> getDiseases();
}