import '../../interface/repository/ihome_repository.dart';
import '../../data/database/database_helper.dart';

class HomeRepository implements IHomeRepository {
  @override
  Future<List<Map<String, dynamic>>> getLatestStats(int accountId) async {
    // Hiện tại để trống
    return [];
  }
}