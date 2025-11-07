import 'package:baza_gibdd_gai/features/payments/data/models/api_models/api_subscription.dart';
import 'package:baza_gibdd_gai/features/payments/data/models/subscription.dart';
import 'package:baza_gibdd_gai/features/payments/data/models/user_data.dart';

class SubscriptionMapper {
  static const _typeKey = "docType";
  static const _numberKey = "docNumber";
  static const _firstNameKey = 'firstName';
  static const _secondNameKey = 'secondName';
  static const _lastNameKey = 'lastName';
  static const _regionKey = 'region';

  static const _passportKey = 'RF_PASSPORT';
  static const _drivingLicenseKey = 'RF_DRIVING_LICENSE';
  static const _carRegCertificateKey = 'CAR_REG_CERTIFICATE';
  static const _InnKey = 'INN_FL';
  static const _snilsKey = 'SNILS';
  static const _kidBirthCertificateKey = 'KID_BIRTH_CERTIFICATE';
  static const _fsspDataKey = "FSSP_DATA";

  static Subscription fromApi(ApiSubscription apiSubscription) {
    late SubscriptionType type;
    switch (apiSubscription.type) {
      case 'taxes':
        type = SubscriptionType.taxes;
        break;
      case 'trials':
        type = SubscriptionType.trials;
        break;
      case 'fsspTrials':
        type = SubscriptionType.fsspTrials;
        break;
      case 'fines':
        type = SubscriptionType.fines;
        break;
    }
    UserData userData = UserData();
    apiSubscription.request.forEach((element) {
      if (element is Map) {
        switch (element[_typeKey]) {
          case _passportKey:
            userData = userData.copyWith(passport: element[_numberKey]);
            break;
          case _drivingLicenseKey:
            userData = userData.copyWith(vy: element[_numberKey]);
            break;
          case _carRegCertificateKey:
            userData = userData.copyWith(sts: element[_numberKey]);
            break;
          case _InnKey:
            userData = userData.copyWith(inn: element[_numberKey]);
            break;
          case _snilsKey:
            userData = userData.copyWith(snils: element[_numberKey]);
            break;
          case _kidBirthCertificateKey:
            userData = userData.copyWith(birthCertificate: element[_numberKey]);
            break;
          case _fsspDataKey:
            userData = userData.copyWith(
              firstName: element[_firstNameKey],
              secondName: element.containsKey(_secondNameKey)
                  ? element[_secondNameKey]
                  : null,
              lastName: element[_lastNameKey],
              region:
                  element.containsKey(_regionKey) ? element[_regionKey] : null,
            );
            break;
        }
      }
    });
    return Subscription(
      userData: userData,
      hash: apiSubscription.hash,
      paymentsNumbers: List.from(apiSubscription.paymentsNumbers),
      type: type,
      haveNewPayments: apiSubscription.haveNewPayments,
    );
  }

  static ApiSubscription toApi(Subscription subscription) {
    List<Map<String, dynamic>> documents = [];
    if (subscription.userData.passport != null &&
        subscription.userData.passport!.isNotEmpty) {
      documents.add({
        _typeKey: _passportKey,
        _numberKey: subscription.userData.passport,
      });
    }
    if (subscription.userData.vy != null &&
        subscription.userData.vy!.isNotEmpty) {
      documents.add({
        _typeKey: _drivingLicenseKey,
        _numberKey: subscription.userData.vy,
      });
    }
    if (subscription.userData.sts != null &&
        subscription.userData.sts!.isNotEmpty) {
      documents.add({
        _typeKey: _carRegCertificateKey,
        _numberKey: subscription.userData.sts,
      });
    }
    if (subscription.userData.inn != null &&
        subscription.userData.inn!.isNotEmpty) {
      documents.add({
        _typeKey: _InnKey,
        _numberKey: subscription.userData.inn,
      });
    }
    if (subscription.userData.snils != null &&
        subscription.userData.snils!.isNotEmpty) {
      documents.add({
        _typeKey: _snilsKey,
        _numberKey: subscription.userData.snils,
      });
    }
    if (subscription.userData.birthCertificate != null &&
        subscription.userData.birthCertificate!.isNotEmpty) {
      documents.add({
        _typeKey: _kidBirthCertificateKey,
        _numberKey: subscription.userData.birthCertificate,
      });
    }
    if (subscription.userData.firstName != null &&
        subscription.userData.firstName!.isNotEmpty &&
        subscription.userData.lastName != null &&
        subscription.userData.lastName!.isNotEmpty) {
      Map<String, dynamic> fsspData = {
        _typeKey: _fsspDataKey,
        _firstNameKey: subscription.userData.firstName,
        _lastNameKey: subscription.userData.lastName
      };
      if (subscription.userData.secondName != null &&
          subscription.userData.secondName!.isNotEmpty) {
        fsspData.addAll({
          _secondNameKey: subscription.userData.secondName,
        });
      }
      if (subscription.userData.region != null &&
          subscription.userData.region!.isNotEmpty) {
        fsspData.addAll({
          _regionKey: subscription.userData.region,
        });
      }
      documents.add(fsspData);
    }
    String type;
    switch (subscription.type) {
      case SubscriptionType.taxes:
        type = 'taxes';
        break;
      case SubscriptionType.trials:
        type = 'trials';
        break;
      case SubscriptionType.fsspTrials:
        type = 'fsspTrials';
        break;
      case SubscriptionType.fines:
        type = 'fines';
        break;
    }
    return ApiSubscription(
      paymentsNumbers: subscription.paymentsNumbers,
      request: documents,
      type: type,
      haveNewPayments: subscription.haveNewPayments,
    );
  }
}
