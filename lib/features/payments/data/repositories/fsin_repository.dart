import 'package:baza_gibdd_gai/features/payments/data/models/fsin_model.dart';

abstract class FsinRepository {
  Future<List<Fsin>> loadFsin();
  List<Fsin>? loadCashed();
}
