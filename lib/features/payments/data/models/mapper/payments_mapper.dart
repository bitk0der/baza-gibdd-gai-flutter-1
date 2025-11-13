import 'package:baza_gibdd_gai/features/payments/data/models/payments/fine.dart';
import 'package:baza_gibdd_gai/features/payments/data/models/payments/tax.dart';
import 'package:baza_gibdd_gai/features/payments/data/models/payments/trial.dart';

class PaymentsMapper {
  static Map<String, dynamic> fromMap(List apiPayments) {
    List<Tax> taxes = [];
    List<Trial> trials = [];
    List<Fine> fines = [];
    for (var element in apiPayments) {
      final String name = element["billName"];
      final String number = element["billNumber"];
      final double summ = element["amount"] + .0;
      final DateTime date =
          DateTime.fromMillisecondsSinceEpoch(element["billDate"]);
      String organization = "";
      List addAttrs = element["addAttrs"]["attrs"];
      for (var element in addAttrs) {
        if (element["name"] == "SupplierFullName") {
          organization = element["value"];
        }
      }
      if (element["serviceCategory"]["code"] == "FINE") {
        fines.add(
          Fine(
            name: name,
            number: number,
            summ: summ,
            date: date,
            organization: organization,
          ),
        );
      } else if (element["serviceCategory"]["code"] == "FSSP" ||
          element["serviceCategory"]["code"] == "FNS" ||
          element["serviceCategory"]["code"] == "FINE") {
        trials.add(
          Trial(
            name: name,
            number: number,
            summ: summ,
            date: date,
            organization: organization,
          ),
        );
      } else {
        taxes.add(
          Tax(
            name: name,
            number: number,
            summ: summ,
            date: date,
            organization: organization,
          ),
        );
      }
    }
    return {
      "taxes": taxes,
      "trials": trials,
      "fines": fines,
    };
  }

  static Map<String, dynamic> fromMapNewApi(
    List apiPayments,
    Map<String, dynamic> body,
  ) {
    List<Tax> taxes = [];
    List<Fine> fines = [];
    List<Trial> trials = [];
    /*  var category = body["type"]; */

    for (var element in apiPayments) {
      /*    if (category == "Tax") {
        taxes.add(Tax.fromJson(element));
      } else if (category == "Trial") {
        trials.add(Trial.fromJson(element));
      } else { */
      fines.add(Fine.fromJson(element));
      /*  } */
    }

    return {"taxes": taxes, "fines": fines, "trials": trials};
  }
}
