import 'package:baza_gibdd_gai/features/credit_rating/data/repositories/api_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RequestBody {
  static JsonMap requestPaymentBody(
    String email,
    String productsId,
    List<String> serviceParams,
  ) {
    return {
      "userId": GetIt.I<SharedPreferences>().getString('userIdMetrika'),
      "email": email,
      "products": [
        {
          "id": productsId,
          "serviceParams": {
            "surname": serviceParams[0],
            "name": serviceParams[1],
            "patronymic": serviceParams[2],
            "birthDate": serviceParams[3],
            "region": serviceParams[4],
            "inn": serviceParams[5],
            "passportSeriesNumber": serviceParams[6],
            "passportDateIssue": serviceParams[7],
            "passportIssuerCode": serviceParams[8],
          },
        },
      ],
    };
  }
}
