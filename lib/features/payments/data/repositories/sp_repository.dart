import 'package:baza_gibdd_gai/features/payments/data/models/user_data.dart';
import 'package:baza_gibdd_gai/features/payments/data/models/user_position.dart';

abstract class SpRepository {
  Future<UserPosition?> loadLastGeoposition();
  Future<void> saveLastGeoposition(UserPosition position);
  Future<UserData> loadUserData();
  Future<void> saveUserData(UserData userData);
  Future<bool> isOnboardingShowed();
  Future<bool> setOnboardingShowed();
  Future<int> getNavJumpCount();
  Future<bool> setNavJumpCount(int count);
}
