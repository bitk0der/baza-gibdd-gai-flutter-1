import 'package:baza_gibdd_gai/features/payments/data/models/user_data.dart';
import 'package:baza_gibdd_gai/features/payments/data/models/user_position.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

@injectable
class SpUtil {
  static const _LATITUDE = "latitude";
  static const _LONGITUDE = "longitude";
  static const _ADDRESS = "address";
  static const _STREET = "street";

  SharedPreferences? sp;

  SpUtil() {
    _initialize();
  }

  void _initialize() async {
    sp = await SharedPreferences.getInstance();
  }

  Future<bool> isOnboardingShowed() async {
    sp ??= await SharedPreferences.getInstance();

    try {
      final showed = sp!.getBool("onboadring_showed");
      if (showed == null) {
        return false;
      } else {
        return showed;
      }
    } catch (e) {
      return false;
    }
  }

  Future<bool> setOnboardingShowed() async {
    sp ??= await SharedPreferences.getInstance();
    return sp!.setBool("onboadring_showed", true);
  }

  Future<void> saveUserData(UserData userData) async {
    sp ??= await SharedPreferences.getInstance();

    // Сохранение старых данных
    if (userData.passport != null) {
      await sp!.setString("passport", userData.passport!);
    }
    if (userData.vy != null) await sp!.setString("vy", userData.vy!);
    if (userData.sts != null) await sp!.setString("sts", userData.sts!);
    if (userData.snils != null) await sp!.setString("snils", userData.snils!);
    if (userData.inn != null) await sp!.setString("inn", userData.inn!);
    if (userData.birthCertificate != null) {
      await sp!.setString("birthCertificate", userData.birthCertificate!);
    }
    if (userData.firstName != null) {
      await sp!.setString("firstName", userData.firstName!);
    }
    if (userData.secondName != null) {
      await sp!.setString("secondName", userData.secondName!);
    }
    if (userData.lastName != null) {
      await sp!.setString("lastName", userData.lastName!);
    }
    if (userData.birthday != null) {
      await sp!.setString("birthday", userData.birthday!);
    }
    if (userData.region != null) {
      await sp!.setString("region", userData.region!);
    }
    if (userData.uin != null) {
      await sp!.setString("uin", userData.uin!);
    }
    if (userData.internationalPassport != null) {
      await sp!
          .setString("internationalPassport", userData.internationalPassport!);
    }

    // Новые данные
    if (userData.internationalPassportDateBirth != null) {
      await sp!.setString("internationalPassportDateBirth",
          userData.internationalPassportDateBirth!);
    }
    if (userData.wpNumber != null) {
      await sp!.setString("wpNumber", userData.wpNumber!);
    }
    if (userData.wpblankNumber != null) {
      await sp!.setString("wpblankNumber", userData.wpblankNumber!);
    }
    if (userData.wpDateBirth != null) {
      await sp!.setString("wpDateBirth", userData.wpDateBirth!);
    }

    // Сохранение остальных данных аналогично старому коду
    if (userData.patentNumber != null) {
      await sp!.setString("patentNumber", userData.patentNumber!);
    }
    if (userData.blankNumber != null) {
      await sp!.setString("blankNumber", userData.blankNumber!);
    }
    if (userData.datePatentBirth != null) {
      await sp!.setString("datePatentBirth", userData.datePatentBirth!);
    }
    if (userData.registrationDate != null) {
      await sp!.setString("registrationDate", userData.registrationDate!);
    }
    if (userData.registrationExpiredDate != null) {
      await sp!.setString(
          "registrationExpiredDate", userData.registrationExpiredDate!);
    }
    if (userData.registrationAdress != null) {
      await sp!.setString("registrationAdress", userData.registrationAdress!);
    }
    if (userData.datePasportBirth != null) {
      await sp!.setString("datePasportBirth", userData.datePasportBirth!);
    }
    if (userData.sex != null) {
      await sp!.setString("sex", userData.sex!);
    }
    if (userData.citizen != null) {
      await sp!.setString("citizen", userData.citizen!);
    }
    if (userData.countryEmitent != null) {
      await sp!.setString("countryEmitent", userData.countryEmitent!);
    }
    if (userData.numberMedicialBook != null) {
      await sp!.setString("numberMedicialBook", userData.numberMedicialBook!);
    }
    if (userData.medicialBookExpiredDate != null) {
      await sp!.setString(
          "medicialBookExpiredDate", userData.medicialBookExpiredDate!);
    }
    if (userData.medicialBookDate != null) {
      await sp!.setString("medicialBookDate", userData.medicialBookDate!);
    }
    if (userData.gosNumber != null) {
      await sp!.setString("gosNumber", userData.gosNumber!);
    }
    if (userData.firstLatName != null) {
      await sp!.setString("firstLatName", userData.firstLatName!);
    }
    if (userData.lastLatName != null) {
      await sp!.setString("lastLatName", userData.lastLatName!);
    }
  }

  Future<UserData> loadUserData() async {
    sp ??= await SharedPreferences.getInstance();

    String? passport;
    String? vy;
    String? sts;
    String? snils;
    String? inn;
    String? birthCertificate;
    String? firstName;
    String? secondName;
    String? lastName;
    String? birthday;
    String? region;
    String? uin;
    String? internationalPassport;
    String? internationalPassportDateBirth;
    String? wpNumber;
    String? wpblankNumber;
    String? wpDateBirth;

    // Загрузка старых данных
    passport = sp!.getString("passport");
    vy = sp!.getString("vy");
    sts = sp!.getString("sts");
    snils = sp!.getString("snils");
    inn = sp!.getString("inn");
    birthCertificate = sp!.getString("birthCertificate");
    firstName = sp!.getString("firstName");
    secondName = sp!.getString("secondName");
    lastName = sp!.getString("lastName");
    birthday = sp!.getString("birthday");
    region = sp!.getString("region");
    uin = sp!.getString("uin");
    internationalPassport = sp!.getString("internationalPassport");

    // Загрузка новых данных
    internationalPassportDateBirth =
        sp!.getString("internationalPassportDateBirth");
    wpNumber = sp!.getString("wpNumber");
    wpblankNumber = sp!.getString("wpblankNumber");
    wpDateBirth = sp!.getString("wpDateBirth");

    return UserData(
      passport: passport,
      vy: vy,
      sts: sts,
      snils: snils,
      inn: inn,
      birthCertificate: birthCertificate,
      firstName: firstName,
      secondName: secondName,
      lastName: lastName,
      birthday: birthday,
      region: region,
      uin: uin,
      internationalPassport: internationalPassport,
      internationalPassportDateBirth: internationalPassportDateBirth,
      wpNumber: wpNumber,
      wpblankNumber: wpblankNumber,
      wpDateBirth: wpDateBirth,
      // Заполнение остальных данных аналогично старому коду
      patentNumber: sp!.getString("patentNumber"),
      blankNumber: sp!.getString("blankNumber"),
      datePatentBirth: sp!.getString("datePatentBirth"),
      registrationDate: sp!.getString("registrationDate"),
      registrationExpiredDate: sp!.getString("registrationExpiredDate"),
      registrationAdress: sp!.getString("registrationAdress"),
      datePasportBirth: sp!.getString("datePasportBirth"),
      sex: sp!.getString("sex"),
      citizen: sp!.getString("citizen"),
      countryEmitent: sp!.getString("countryEmitent"),
      numberMedicialBook: sp!.getString("numberMedicialBook"),
      medicialBookExpiredDate: sp!.getString("medicialBookExpiredDate"),
      medicialBookDate: sp!.getString("medicialBookDate"),
      gosNumber: sp!.getString("gosNumber"),
      firstLatName: sp!.getString("firstLatName"),
      lastLatName: sp!.getString("lastLatName"),
    );
  }

  Future<void> saveLastGeoposition(UserPosition userPosition) async {
    sp ??= await SharedPreferences.getInstance();

    await sp!.setString(_ADDRESS, userPosition.address);
    await sp!.setString(_STREET, userPosition.street ?? '');
  }

  Future<UserPosition?> loadLastGeoposition() async {
    sp ??= await SharedPreferences.getInstance();
    double? latitude;
    double? longitude;
    String? address;
    String? street;
    try {
      latitude = sp!.getDouble(_LATITUDE);
      longitude = sp!.getDouble(_LONGITUDE);
      address = sp!.getString(_ADDRESS);
      street = sp!.getString(_STREET);
    } catch (e) {
      return null;
    }
    if (longitude == null || latitude == null || address == null) {
      return null;
    }
    return UserPosition(
      address: address,
      street: street,
    );
  }

  Future<bool> isShowSubscriptionDialog() async {
    sp ??= await SharedPreferences.getInstance();

    try {
      final showed = sp!.getBool("show_subscription_dialog");
      if (showed == null) {
        return true;
      } else {
        return showed;
      }
    } catch (e) {
      return true;
    }
  }

  Future<bool> setShowSubscriptionDialog(bool value) async {
    sp ??= await SharedPreferences.getInstance();

    return sp!.setBool("show_subscription_dialog", value);
  }

  Future<int> getNavJumpCount() async {
    sp ??= await SharedPreferences.getInstance();
    try {
      final showed = sp!.getInt("nav_jump_count");
      if (showed == null) {
        return 0;
      } else {
        return showed;
      }
    } catch (e) {
      Logger().e(e.toString());
      return 0;
    }
  }

  Future<bool> setNavJumpCount(int count) async {
    sp ??= await SharedPreferences.getInstance();
    return sp!.setInt("nav_jump_count", count);
  }
}
