
import '../../data/database/database_helper.dart';
import '../../data/models/user_profile.dart';
import '../../interface/repository/iprofile_repository.dart';

class ProfileRepository implements IProfileRepository {
  final DatabaseHelper _dbHelper = DatabaseHelper.instance;

  @override
  Future<int> updateInitialProfile({
    required int accountId,
    required UserProfile profile,
    required List<int> diseaseIds,
  }) async {
    // 1. Chuyển Model sang Map
    final profileMap = profile.toMap();

    // 2. LOẠI BỎ các trường gây lỗi mismatch (id)
    // và các trường không cần cập nhật trong bước này (full_name, updated_at nếu đang null)
    profileMap.remove('id');

    // Đảm bảo updated_at có giá trị để SQLite không ghi đè NULL vào
    profileMap['updated_at'] = DateTime.now().toIso8601String();

    // Loại bỏ các trường null khác để tránh ghi đè dữ liệu cũ trong DB thành NULL
    profileMap.removeWhere((key, value) => value == null);

    // 3. Truyền Map đã được "lọc sạch" xuống Database
    return await _dbHelper.updateInitialProfile(accountId, profileMap, diseaseIds);
  }

  @override
  Future<Map<String, dynamic>?> getProfile(int accountId) async {
    final db = await _dbHelper.database;
    final res = await db.query('user_profile', where: 'account_id = ?', whereArgs: [accountId]);
    return res.isNotEmpty ? res.first : null;
  }

  @override
  Future<List<String>> getDiseasesByAccountId(int accountId) async {
    return await _dbHelper.getDiseasesByAccountId(accountId);
  }
}