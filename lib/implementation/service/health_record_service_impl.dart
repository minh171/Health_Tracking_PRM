import 'package:flutter/foundation.dart'; // Dùng foundation cho debugPrint nhẹ hơn

import '../../data/models/user_profile.dart';
import '../../interface/repository/ihealth_record_repository.dart';
import '../../interface/repository/iprofile_repository.dart';
import '../../interface/service/ihealth_record_service.dart';

class HealthRecordService implements IHealthRecordService {
  final IHealthRecordRepository _recordRepo;
  final IProfileRepository _profileRepo;

  HealthRecordService(this._recordRepo, this._profileRepo);

  @override
  Future<bool> isBasicInfoCompleted(int accountId) async {
    final Map<String, dynamic>? profileMap = await _profileRepo.getProfile(accountId);
    if (profileMap == null) return false;

    final profile = UserProfile.fromMap(profileMap);

    // Logic: Đã có chiều cao và cân nặng hợp lệ
    return (profile.height != null && profile.height! > 0) &&
        (profile.weight != null && profile.weight! > 0);
  }

  @override
  Future<bool> saveBasicHealthInfo({
    required int accountId,
    required UserProfile profile,
    required List<int> diseaseIds,
  }) async {
    try {
      await _profileRepo.updateInitialProfile(
        accountId: accountId,
        profile: profile,
        diseaseIds: diseaseIds,
      );
      return true;
    } catch (e) {
      debugPrint("Lỗi tại Service saveBasicHealthInfo: $e");
      return false;
    }
  }

  @override
  Future<List<Map<String, dynamic>>> getRecordsByType(
      int accountId,
      String type,
      {bool descending = true}
      ) async {
    try {
      return await _recordRepo.getRecordsByType(accountId, type, descending: descending);
    } catch (e) {
      debugPrint("Lỗi tại Service getRecordsByType ($type): $e");
      return []; // Trả về danh sách rỗng nếu lỗi để tránh crash UI
    }
  }
}