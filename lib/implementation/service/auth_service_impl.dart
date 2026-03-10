import 'dart:convert'; // Dùng để chuyển đổi chuỗi sang byte
import 'package:crypto/crypto.dart'; // Thư viện mã hóa
import 'package:flutter/cupertino.dart';
import '../../data/models/account.dart';
import '../../interface/repository/iauth_repository.dart';
import '../../interface/service/iauth_service.dart';

class AuthService implements IAuthService {
  final IAuthRepository _authRepository;

  AuthService(this._authRepository);

  // Hàm thực hiện Hash mật khẩu bằng SHA-256
  String _hashPassword(String password) {
    var bytes = utf8.encode(password); // Chuyển mật khẩu sang mảng byte
    var digest = sha256.convert(bytes); // Thực hiện hash SHA-256
    return digest.toString(); // Trả về chuỗi mã hóa
  }

  @override
  Future<bool> isEmailAvailable(String email) async {
    return !(await _authRepository.checkEmailExists(email.trim().toLowerCase()));
  }

  @override
  Future<String?> registerUser({
    required String fullName,
    required String email,
    required String password,
  }) async {
    try {
      final available = await isEmailAvailable(email);
      if (!available) {
        return "Email này đã được sử dụng. Vui lòng chọn email khác !!";
      }

      final cleanFullName = fullName.trim();
      final cleanEmail = email.trim().toLowerCase();

      // 3. Hash mật khẩu trước khi lưu
      final hashedEmoji = _hashPassword(password);

      // 4. Gọi Repository để lưu vào Database
      final accountId = await _authRepository.register(
        cleanFullName,
        cleanEmail,
        hashedEmoji, // Gửi mật khẩu đã mã hóa
      );

      if (accountId > 0) {
        return null;
      } else {
        return "Không thể tạo tài khoản. Vui lòng thử lại.";
      }
    } catch (e) {
      return "Lỗi hệ thống: $e";
    }
  }

  @override
  Future<Map<String, dynamic>?> loginUser(String email, String password) async {
    try {
      final cleanEmail = email.trim().toLowerCase();

      // Bước 1: Kiểm tra xem tài khoản có tồn tại không bằng Email
      final userData = await _authRepository.getAccountByEmail(cleanEmail);

      if (userData == null) {
        throw Exception("Email này chưa được đăng ký");
      }

      // Bước 2: Băm mật khẩu nhập vào để so sánh với mật khẩu trong DB
      final hashedInput = _hashPassword(password);

      if (userData['password'] != hashedInput) {
        throw Exception("Mật khẩu không chính xác");
      }

      // Bước 3: Khi Email và Pass đều đúng, gọi hàm login có chứa JOIN
      // để lấy đầy đủ Map (bao gồm full_name từ bảng user_profile)
      final fullUserData = await _authRepository.login(cleanEmail, hashedInput);

      return fullUserData;

    } catch (e) {
      // Rethrow để ViewModel bắt được lỗi và hiển thị lên UI
      rethrow;
    }
  }
}