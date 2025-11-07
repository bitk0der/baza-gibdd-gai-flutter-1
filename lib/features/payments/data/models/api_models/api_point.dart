
class ApiPoint {
  static const _ID = "_id";
  static const _ADDRESS = "address";
  static const _URL = "url";
  static const _PHONE_NUMBER = "phone";
  static const _REGION_PHONE_NUMBER = "regionPhone";
  static const _WORK_HOURS = "workHours";
  static const _GEO_POINT = "geoPoint";
  static const _RATE = "rate";


  final String id;
  final String address;
  final String? url;
  final String? phoneNumber;
  final String? regionPhoneNumber;
  final String workHours;
  final String geoPoint;
  final double rate;

  ApiPoint({
    required this.id,
    required this.address,
    required this.phoneNumber,
    required this.geoPoint,
    required this.url,
    required this.regionPhoneNumber,
    required this.workHours,
    required this.rate,
  });

  ApiPoint.fromMap(Map<String,dynamic> map) :
    id = map[_ID],
    address = map[_ADDRESS],
    phoneNumber = map[_PHONE_NUMBER],
    geoPoint = map[_GEO_POINT],
    url = map[_URL],
    regionPhoneNumber = map[_REGION_PHONE_NUMBER],
    workHours = map[_WORK_HOURS],
    rate = map[_RATE] + .0;

  Map<String,dynamic> toMap () {
    return {
      _ID : this.id,
      _ADDRESS : this.address,
      _PHONE_NUMBER : this.phoneNumber,
      _GEO_POINT : this.geoPoint,
      _URL : this.url,
      _REGION_PHONE_NUMBER : this.regionPhoneNumber,
      _WORK_HOURS : this.workHours,
      _RATE : this.rate,
    };
  }
}