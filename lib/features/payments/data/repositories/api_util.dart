import 'package:injectable/injectable.dart';
import 'package:baza_gibdd_gai/features/payments/data/models/body/get_invocie_info_body.dart';
import 'package:baza_gibdd_gai/features/payments/data/models/body/search_debt_body.dart';
import 'package:baza_gibdd_gai/features/payments/data/models/body/search_fssp_debt_body.dart';
import 'package:baza_gibdd_gai/features/payments/data/models/fsin_model.dart';
import 'package:baza_gibdd_gai/features/payments/data/models/invoice.dart';
import 'package:baza_gibdd_gai/features/payments/data/models/mapper/fspp_payments_mapper.dart';
import 'package:baza_gibdd_gai/features/payments/data/models/mapper/invoice_mapper.dart';
import 'package:baza_gibdd_gai/features/payments/data/models/mapper/payments_mapper.dart';
import 'package:baza_gibdd_gai/features/payments/data/models/payments/fssp_trial.dart';
import 'package:baza_gibdd_gai/features/payments/data/models/subscription.dart';
import 'package:baza_gibdd_gai/features/payments/data/models/user_data.dart';
import 'package:baza_gibdd_gai/features/payments/domain/service/rest_service.dart';

@singleton
class ApiUtil {
  final RestService _restService;

  ApiUtil(this._restService);

  Future<Map<String, dynamic>> searchDebt(
      UserData userData, SubscriptionType subscriptionType) async {
    var body = SearchDebtBody.getBodyNew(userData, subscriptionType);
    final List result = await _restService.searchDebt(body);
    return PaymentsMapper.fromMapNewApi(result, body);
  }

  Future<List<Fsin>> loadFsin() async {
    final List<Fsin> result = await _restService.loadFsin();
    return result;
  }

  Future<List<FsspTrial>> searchFsspDebt(UserData userData) async {
    final body = SearchFsspDebtBody.getBody(userData);
    final result = await _restService.searchFsspDebt(body);
    List<FsspTrial> resultList = [];
    for (var element in result) {
      resultList.add(FsppPaymentsMapper.fromApi(element));
    }
    return resultList;
  }

  Future<List<Invoice>> getInvoiceInfo(List<String> invoiceId) async {
    final body = GetInvoiceInfoBody.getBody(invoiceId);
    final result = await _restService.getInvoiceInfo(body);
    List<Invoice> resultList = [];
    for (var element in result) {
      resultList.add(InvoiceMapper.fromApi(element));
    }
    return resultList;
  }
}
