import 'package:baza_gibdd_gai/features/app_banner/app_banner_initial_setup.dart';
import 'package:baza_gibdd_gai/features/payments/data/models/subscription.dart';
import 'package:baza_gibdd_gai/features/payments/data/models/user_data.dart';

class SearchDebtBody {
  static Map<String, dynamic> getBody(UserData userData) {
    List<Map<String, dynamic>> documents = [];
    if (userData.passport != null && userData.passport!.isNotEmpty) {
      documents.add({
        "docType": "RF_PASSPORT",
        "docNumber": userData.passport,
      });
    }
    if (userData.vy != null && userData.vy!.isNotEmpty) {
      documents.add({
        "docType": "RF_DRIVING_LICENSE",
        "docNumber": userData.vy,
      });
    }
    if (userData.sts != null && userData.sts!.isNotEmpty) {
      documents.add({
        "docType": "CAR_REG_CERTIFICATE",
        "docNumber": userData.sts,
      });
    }
    if (userData.inn != null && userData.inn!.isNotEmpty) {
      documents.add({
        "docType": "INN_FL",
        "docNumber": userData.inn,
      });
    }
    if (userData.snils != null && userData.snils!.isNotEmpty) {
      documents.add({
        "docType": "SNILS",
        "docNumber": userData.snils,
      });
    }
    if (userData.birthCertificate != null &&
        userData.birthCertificate!.isNotEmpty) {
      documents.add({
        "docType": "KID_BIRTH_CERTIFICATE",
        "docNumber": userData.birthCertificate,
      });
    }
    if (userData.internationalPassport != null &&
        userData.internationalPassport!.isNotEmpty) {
      documents.add({
        "docType": "FOREIGN_PASSPORT",
        "docNumber": userData.internationalPassport,
      });
    }
    return {
      "documents": documents,
    };
  }

  static Map<String, dynamic> getBodyNew(
      UserData userData, SubscriptionType subscriptionType) {
    List<Map<String, dynamic>> documents = [];

    if (subscriptionType == SubscriptionType.taxes) {
      if (userData.passport != null && userData.passport!.isNotEmpty) {
        return {
          "CUSTOMFIELD:107": userData.passport!.replaceAll(' ', ''),
          "type": 'Tax',
          'bundle': packageInfo.packageName,
        };
      }
      if (userData.inn != null && userData.inn!.isNotEmpty) {
        return {
          "CUSTOMFIELD:106": userData.inn!.replaceAll(' ', ''),
          "type": 'Tax',
          'bundle': packageInfo.packageName,
        };
      }
    }
    if (subscriptionType == SubscriptionType.trials) {
      if (userData.sts != null && userData.sts!.isNotEmpty) {
        return {
          "CUSTOMFIELD:102": int.parse(userData.sts!.replaceAll(' ', '')),
          "type": 'Trial',
          'bundle': packageInfo.packageName,
        };
      }
      if (userData.snils != null && userData.snils!.isNotEmpty) {
        return {
          "CUSTOMFIELD:104": userData.snils!.replaceAll(' ', ''),
          "type": 'Trial',
          'bundle': packageInfo.packageName,
        };
      }
      if (userData.passport != null && userData.passport!.isNotEmpty) {
        return {
          "CUSTOMFIELD:107": userData.passport!.replaceAll(' ', ''),
          "type": 'Trial',
          'bundle': packageInfo.packageName,
        };
      }
      if (userData.inn != null && userData.inn!.isNotEmpty) {
        return {
          "CUSTOMFIELD:106": userData.inn!.replaceAll(' ', ''),
          "type": 'Trial',
          'bundle': packageInfo.packageName,
        };
      }
    }
    /*    if (userData.internationalPassport != null &&
        userData.internationalPassport!.isNotEmpty) {
      return {
        "CUSTOMFIELD:IPFSSP": userData.internationalPassport!,
        "type": 'Trial',
      };
    } */
    if (subscriptionType == SubscriptionType.fines) {
      if (userData.sts != null && userData.sts!.isNotEmpty) {
        return {
          "CUSTOMFIELD:102": int.parse(userData.sts!.replaceAll(' ', '')),
          "type": 'Trial',
          'bundle': packageInfo.packageName,
        };
      }
      if (userData.passport != null && userData.passport!.isNotEmpty) {
        return {
          "CUSTOMFIELD:107": userData.passport!.replaceAll(' ', ''),
          "type": 'Tax',
          'bundle': packageInfo.packageName,
        };
      }
      if (userData.vy != null && userData.vy!.isNotEmpty) {
        return {
          "CUSTOMFIELD:103": userData.vy!.replaceAll(' ', ''),
          "type": 'Fine',
          'bundle': packageInfo.packageName,
        };
      }
    }
    return {"documents": documents};
  }
}
