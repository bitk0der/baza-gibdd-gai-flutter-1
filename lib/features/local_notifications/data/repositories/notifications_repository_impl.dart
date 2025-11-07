import 'package:baza_gibdd_gai/features/chat_with_gpt/data/repositories/api_repository.dart';
import 'package:baza_gibdd_gai/features/chat_with_gpt/presentation/blocs/chat_cubit.dart';
import 'package:baza_gibdd_gai/features/local_notifications/domain/usecases/fetch_notifications_usecase.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FetchNotificationsUseCaseImpl implements FetchNotificationsUseCase {
  final ApiRepository apiRepository;
  final SharedPreferences preferences;
  FetchNotificationsUseCaseImpl(this.apiRepository, this.preferences);
  @override
  Future<void> call() async {
    final bloc = ChatCubit(repository: apiRepository, preferences: preferences);
    bloc.getLastMessage(isNotification: true);
  }
}
