import 'package:baza_gibdd_gai/features/app_banner/app_banner_initial_setup.dart';
import 'package:baza_gibdd_gai/features/payments/data/models/body/timestamp.dart';
import 'package:baza_gibdd_gai/features/payments/data/models/user_data.dart';

class SearchFsspDebtBody {
  static const _personfirstnameKey = "personfirstname";
  static const _personlastnameKey = "personlastname";
  static const _personsecondnameKey = "personsecondname";
  static const _personbirthdateKey = "personbirthdate";
  static const _fsspregionKey = "fsspregion";
  static const _timestampKey = "timestamp";
  static const _bundleKey = "bundle";

  static Map<String, dynamic> getBody(UserData userData) {
    Map<String, dynamic> body;
    body = {
      _personfirstnameKey: userData.firstName,
      _personlastnameKey: userData.lastName,
    };
    if (userData.birthday != null && userData.birthday!.isNotEmpty) {
      body.addAll({
        _personbirthdateKey: userData.birthday,
      });
    }
    if (userData.secondName != null && userData.secondName!.isNotEmpty) {
      body.addAll({_personsecondnameKey: userData.secondName});
    }
    if (userData.region != null &&
        userData.region!.isNotEmpty &&
        userData.region != 'Все регионы') {
      body.addAll({_fsspregionKey: userData.region});
    }
    final timestamp = Timestamp.generate(body, "Jkdus7");
    body.addAll({_timestampKey: timestamp});
    body.addAll({_bundleKey: packageInfo.packageName});

    return body;
  }
}
