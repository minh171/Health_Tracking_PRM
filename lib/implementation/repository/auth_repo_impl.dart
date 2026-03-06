import '../../data/database/database_helper.dart';
import '../../interface/repository/iauth_repository.dart';

class AuthRepository implements IAuthRepository {
  final DatabaseHelper _dbHelper = DatabaseHelper.instance;

  @override
  Future<int> register(String fullName, String email, String password) async {
    // Gọi trực tiếp hàm transaction đã viết trong DatabaseHelper
    return await _dbHelper.register(fullName, email, password);
  }

  @override
  Future<Map<String, dynamic>?> login(String email, String password) async {
    return await _dbHelper.login(email, password);
  }
}