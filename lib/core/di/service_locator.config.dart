// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:baza_gibdd_gai/core/di/service_locator.dart' as _i244;
import 'package:baza_gibdd_gai/core/network/api_client.dart' as _i296;
import 'package:baza_gibdd_gai/core/utils/sp_util.dart' as _i93;
import 'package:baza_gibdd_gai/features/chat_with_gpt/data/repositories/api_repository.dart'
    as _i1015;
import 'package:baza_gibdd_gai/features/chat_with_gpt/presentation/blocs/chat_cubit.dart'
    as _i359;
import 'package:baza_gibdd_gai/features/local_notifications/presentation/bloc/notification_bloc.dart'
    as _i1038;
import 'package:baza_gibdd_gai/features/payments/data/repositories/api_util.dart'
    as _i559;
import 'package:baza_gibdd_gai/features/payments/data/repositories/fsin_repository.dart'
    as _i1;
import 'package:baza_gibdd_gai/features/payments/data/repositories/search_repository.dart'
    as _i126;
import 'package:baza_gibdd_gai/features/payments/data/repositories/sp_repository.dart'
    as _i885;
import 'package:baza_gibdd_gai/features/payments/data/repositories/storage_repository.dart'
    as _i1044;
import 'package:baza_gibdd_gai/features/payments/domain/repositories/fsin_data_repository.dart'
    as _i288;
import 'package:baza_gibdd_gai/features/payments/domain/repositories/search_data_repository.dart'
    as _i929;
import 'package:baza_gibdd_gai/features/payments/domain/repositories/sp_data_repository.dart'
    as _i401;
import 'package:baza_gibdd_gai/features/payments/domain/repositories/storage_data_repository.dart'
    as _i154;
import 'package:baza_gibdd_gai/features/payments/domain/repositories/storage_util.dart'
    as _i781;
import 'package:baza_gibdd_gai/features/payments/domain/service/rest_service.dart'
    as _i303;
import 'package:baza_gibdd_gai/features/payments/presentation/blocs/fssp_payments_search_bloc.dart'
    as _i762;
import 'package:baza_gibdd_gai/features/payments/presentation/blocs/invoice_search_bloc.dart'
    as _i176;
import 'package:baza_gibdd_gai/features/payments/presentation/blocs/payment_history_bloc.dart'
    as _i25;
import 'package:baza_gibdd_gai/features/payments/presentation/blocs/payments_search_bloc.dart'
    as _i276;
import 'package:baza_gibdd_gai/features/payments/presentation/blocs/region_bloc.dart'
    as _i109;
import 'package:baza_gibdd_gai/features/payments/presentation/blocs/region_search_bloc.dart'
    as _i924;
import 'package:baza_gibdd_gai/features/payments/presentation/blocs/subscription_bloc.dart'
    as _i878;
import 'package:baza_gibdd_gai/features/payments/presentation/blocs/user_data_bloc.dart'
    as _i748;
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:logger/logger.dart' as _i974;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final sharedPreferencesModule = _$SharedPreferencesModule();
    final loggerModule = _$LoggerModule();
    final dioModule = _$DioModule();
    gh.factory<_i93.SpUtil>(() => _i93.SpUtil());
    gh.factory<_i1015.ApiRepository>(() => _i1015.ApiRepository());
    gh.factory<_i781.StorageUtil>(() => _i781.StorageUtil());
    gh.factory<_i303.RestService>(() => _i303.RestService());
    await gh.singletonAsync<_i460.SharedPreferences>(
      () => sharedPreferencesModule.sp,
      preResolve: true,
    );
    gh.singleton<_i974.Logger>(() => loggerModule.logger());
    gh.singleton<_i924.RegionSearchBloc>(() => _i924.RegionSearchBloc());
    gh.lazySingleton<_i361.Dio>(() => dioModule.dio());
    gh.factory<_i1044.StorageRepository>(() => _i154.StorageDataRepository(
          gh<_i781.StorageUtil>(),
          gh<_i93.SpUtil>(),
        ));
    gh.factory<_i296.ApiClient>(() => _i296.ApiClient(gh<_i361.Dio>()));
    gh.singleton<_i885.SpRepository>(
        () => _i401.SpDataRepository(gh<_i93.SpUtil>()));
    gh.singleton<_i748.UserDataBloc>(
        () => _i748.UserDataBloc(spRepository: gh<_i885.SpRepository>()));
    gh.factory<_i359.ChatCubit>(() => _i359.ChatCubit(
          repository: gh<_i1015.ApiRepository>(),
          preferences: gh<_i460.SharedPreferences>(),
        ));
    gh.singleton<_i559.ApiUtil>(() => _i559.ApiUtil(gh<_i303.RestService>()));
    gh.singleton<_i1038.LocalNotificationBloc>(
        () => _i1038.LocalNotificationBloc(
              gh<_i296.ApiClient>(),
              gh<_i460.SharedPreferences>(),
            ));
    gh.factory<_i1.FsinRepository>(
        () => _i288.FsinDataRepository(gh<_i559.ApiUtil>()));
    gh.factory<_i109.RegionBloc>(
        () => _i109.RegionBloc(repository: gh<_i1.FsinRepository>()));
    gh.singleton<_i25.PaymentHistoryBloc>(
        () => _i25.PaymentHistoryBloc(gh<_i1044.StorageRepository>()));
    gh.factory<_i126.SearchRepository>(
        () => _i929.PaymentsSearchDataRepository(gh<_i559.ApiUtil>()));
    gh.singleton<_i176.InvoiceSearchBloc>(() => _i176.InvoiceSearchBloc(
          gh<_i126.SearchRepository>(),
          gh<_i25.PaymentHistoryBloc>(),
        ));
    gh.singleton<_i878.SubscriptionBloc>(() => _i878.SubscriptionBloc(
          searchRepository: gh<_i126.SearchRepository>(),
          storageRepository: gh<_i1044.StorageRepository>(),
        ));
    gh.singleton<_i762.FsspPaymentsSearchBloc>(
        () => _i762.FsspPaymentsSearchBloc(gh<_i126.SearchRepository>()));
    gh.singleton<_i276.PaymentsSearchBloc>(
        () => _i276.PaymentsSearchBloc(gh<_i126.SearchRepository>()));
    return this;
  }
}

class _$SharedPreferencesModule extends _i244.SharedPreferencesModule {}

class _$LoggerModule extends _i244.LoggerModule {}

class _$DioModule extends _i244.DioModule {}
