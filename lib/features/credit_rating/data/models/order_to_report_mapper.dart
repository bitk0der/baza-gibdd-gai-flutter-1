import 'package:baza_gibdd_gai/features/credit_rating/data/models/orders_response.dart';
import 'package:baza_gibdd_gai/features/credit_rating/data/models/report_model.dart';

class OrderToUserReportMapper {
  static UserReport map(OrderModel order) {
    return UserReport(
      fullName: order.name,
      region: order.region,
      status: order.ready ? "Сформирован" : "Формируется",
      reportDate: DateTime.fromMillisecondsSinceEpoch(order.dateTimestamp),
      birthDate: order.serviceParams.fields["birthDate"]?.value ?? "",
      inn: order.serviceParams.fields["inn"]?.value ?? "",
      passport: order.serviceParams.fields["passportSeriesNumber"]?.value ?? "",
      issueDate: order.serviceParams.fields["passportDateIssue"]?.value ?? "",
      departmentCode:
          order.serviceParams.fields["passportIssuerCode"]?.value ?? "",
      downloadLinks: order.downloadLinks.downloadLinks,
    );
  }
}
