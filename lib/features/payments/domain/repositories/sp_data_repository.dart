import 'package:injectable/injectable.dart';
import 'package:baza_gibdd_gai/core/utils/sp_util.dart';
import 'package:baza_gibdd_gai/features/payments/data/models/user_data.dart';
import 'package:baza_gibdd_gai/features/payments/data/models/user_position.dart';
import 'package:baza_gibdd_gai/features/payments/data/repositories/sp_repository.dart';

@Singleton(as: SpRepository)
class SpDataRepository extends SpRepository {
  final SpUtil _spUtil;

  SpDataRepository(this._spUtil);

  @override
  Future<UserPosition?> loadLastGeoposition() {
    return _spUtil.loadLastGeoposition();
  }

  @override
  Future<void> saveLastGeoposition(UserPosition position) {
    return _spUtil.saveLastGeoposition(position);
  }

  @override
  Future<UserData> loadUserData() {
    return _spUtil.loadUserData();
  }

  @override
  Future<void> saveUserData(UserData userData) {
    return _spUtil.saveUserData(userData);
  }

  @override
  Future<bool> isOnboardingShowed() {
    return _spUtil.isOnboardingShowed();
  }

  @override
  Future<bool> setOnboardingShowed() {
    return _spUtil.setOnboardingShowed();
  }

  @override
  Future<int> getNavJumpCount() {
    return _spUtil.getNavJumpCount();
  }

  @override
  Future<bool> setNavJumpCount(int count) {
    return _spUtil.setNavJumpCount(count);
  }
}
