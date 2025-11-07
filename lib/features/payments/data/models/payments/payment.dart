abstract class Payment {
  final String? name;
  final String? number;
  final String? organization;
  final double? summ;
  final DateTime? date;

  Payment({
    this.name,
    this.number,
    this.organization,
    this.summ,
    this.date,
  });
}
