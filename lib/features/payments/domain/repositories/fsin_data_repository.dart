import 'package:injectable/injectable.dart';
import 'package:baza_gibdd_gai/features/payments/data/models/fsin_model.dart';
import 'package:baza_gibdd_gai/features/payments/data/repositories/api_util.dart';
import 'package:baza_gibdd_gai/features/payments/data/repositories/fsin_repository.dart';

@Injectable(as: FsinRepository)
class FsinDataRepository implements FsinRepository {
  final ApiUtil _apiUtil;

  FsinDataRepository(this._apiUtil);
  List<Fsin>? _result;
  @override
  Future<List<Fsin>> loadFsin() async {
    _result ??= await _apiUtil.loadFsin();
    return _result!;
  }

  @override
  List<Fsin>? loadCashed() {
    return _result;
  }
}
