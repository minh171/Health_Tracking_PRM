
import '../../data/database/database_helper.dart';
import '../../interface/repository/iprofile_repository.dart';

class ProfileRepository implements IProfileRepository {
  final DatabaseHelper _dbHelper = DatabaseHelper.instance;

  @override
  Future<int> updateInitialProfile({
    required int accountId,
    required Map<String, dynamic> profileData,
    required List<int> diseaseIds,
  }) async {
    return await _dbHelper.updateInitialProfile(accountId, profileData, diseaseIds);
  }

  @override
  Future<Map<String, dynamic>?> getProfile(int accountId) async {
    final db = await _dbHelper.database;
    final res = await db.query('user_profile', where: 'account_id = ?', whereArgs: [accountId]);
    return res.isNotEmpty ? res.first : null;
  }

  @override
  Future<List<Map<String, dynamic>>> getDiseases() async {
    final db = await _dbHelper.database;
    return await db.query('diseases');
  }
}