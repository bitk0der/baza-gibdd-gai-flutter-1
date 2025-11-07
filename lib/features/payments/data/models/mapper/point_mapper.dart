import 'package:baza_gibdd_gai/features/payments/data/models/api_models/api_point.dart';
import 'package:baza_gibdd_gai/features/payments/data/models/point.dart';

class PointMapper {
  static Point fromApi(ApiPoint apiPoint) {
    String? phone;
    if (apiPoint.phoneNumber != null && apiPoint.phoneNumber!.contains(",")) {
      final phones = apiPoint.phoneNumber!.split(",");
      phone = phones[0];
    } else if (apiPoint.phoneNumber != null &&
        apiPoint.phoneNumber!.contains(";")) {
      final phones = apiPoint.phoneNumber!.split(";");
      phone = phones[0];
    } else {
      phone = apiPoint.phoneNumber;
    }
    if (phone != null) {
      phone = phone.replaceAll(" ", "");
    }

    String? regionPhone;
    if (apiPoint.regionPhoneNumber != null &&
        apiPoint.regionPhoneNumber!.contains(",")) {
      final phones = apiPoint.regionPhoneNumber!.split(",");
      regionPhone = phones[0];
    } else if (apiPoint.regionPhoneNumber != null &&
        apiPoint.regionPhoneNumber!.contains(";")) {
      final phones = apiPoint.regionPhoneNumber!.split(";");
      regionPhone = phones[0];
    } else {
      regionPhone = apiPoint.regionPhoneNumber;
    }
    if (regionPhone != null) {
      regionPhone = regionPhone.replaceAll(" ", "");
    }

    return Point(
      id: apiPoint.id,
      address: apiPoint.address,
      phone: phone,
      regionPhone: regionPhone,
      url: apiPoint.url,
      workHours: apiPoint.workHours.replaceAll(";", "\n"),
      rate: apiPoint.rate,
    );
  }

  static ApiPoint toApi(Point point) {
    final geoPoint = "0,0";

    return ApiPoint(
      id: point.id,
      address: point.address,
      geoPoint: geoPoint,
      phoneNumber: point.phone,
      regionPhoneNumber: point.regionPhone,
      url: point.url,
      workHours: point.workHours,
      rate: point.rate,
    );
  }
}
