
import 'package:health_tracking/interface/repository/inotification_repository.dart';

import '../../data/database/database_helper.dart';

class NotificationRepository implements INotificationRepository {
  final DatabaseHelper _dbHelper = DatabaseHelper.instance;

  @override
  Future<List<Map<String, dynamic>>> getFilteredNotifications(
      int accountId, {String? level, String? type}
      ) async {
    return await _dbHelper.getFilteredNotifications(accountId, level: level, type: type);
  }

  @override
  Future<int> markAsRead(int notificationId) async {
    return await _dbHelper.markAsRead(notificationId);
  }
}