import 'package:health_tracking/data/models/user_profile.dart';

import '../../interface/repository/iprofile_repository.dart';
import '../../interface/service/iprofile_service.dart';

class ProfileService implements IProfileService {
  final IProfileRepository _profileRepo;

  ProfileService(this._profileRepo);

  @override
  Future<Map<String, dynamic>?> getProfile(int accountId) async {
    return await _profileRepo.getProfile(accountId);
  }

  @override
  Future<bool> saveInitialProfile({
    required int accountId,
    required UserProfile data,
    required List<int> selectedDiseaseIds,
  }) async {
    try {
      final result = await _profileRepo.updateInitialProfile(
        accountId: accountId,
        profile: data,
        diseaseIds: selectedDiseaseIds,
      );
      return result > 0;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<List<String>> getDiseasesByAccountId(int accountId) async {
    return await _profileRepo.getDiseasesByAccountId(accountId);
  }
}
