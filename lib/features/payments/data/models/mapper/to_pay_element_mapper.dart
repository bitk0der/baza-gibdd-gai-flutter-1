import 'package:baza_gibdd_gai/features/payments/data/models/api_models/api_to_pay_element.dart';
import 'package:baza_gibdd_gai/features/payments/data/models/to_pay_element.dart';

class ToPayElementMapper {
  static ToPayElement fromApi(ApiToPayElement api) {
    return ToPayElement(
      purpose: api.purpose,
      amount: api.amount,
      commission: api.commission,
    );
  }
}
