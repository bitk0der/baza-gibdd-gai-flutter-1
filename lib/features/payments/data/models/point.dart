class Point {
  final String id;
  final String address;
  final String? url;
  final String? phone;
  final String? regionPhone;
  final String workHours;

  final double rate;

  Point({
    required this.id,
    required this.address,
    this.url,
    this.phone,
    this.regionPhone,
    required this.workHours,
    required this.rate,
  });

  @override
  bool operator ==(other) {
    return other is Point && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
