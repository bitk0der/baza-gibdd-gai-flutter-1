import 'package:baza_gibdd_gai/core/constants/constants.dart';
import 'package:baza_gibdd_gai/features/credit_rating/data/models/orders_response.dart';
import 'package:baza_gibdd_gai/features/credit_rating/data/models/payment_response.dart';
import 'package:baza_gibdd_gai/features/credit_rating/data/models/product_model.dart'
    as product;
import 'package:baza_gibdd_gai/features/credit_rating/data/models/region_response.dart';
import 'package:baza_gibdd_gai/features/credit_rating/data/repositories/api_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@singleton
class CreditRatingCubit extends Cubit<CreditRatingState> {
  final ApiRepository repository;
  final SharedPreferences prefs;
  CreditRatingCubit(this.prefs, {required this.repository})
      : super(CreditRatingInitialState());
  product.ProductModel? productModel;
  List<Region> regions = [];
  bool _isCancelled = false; // Флаг для отмены
  Future<void> getReceivingOrders() async {
    emit(CreditRatingOrdersLoadingState());
    try {
      var response = await repository.getReceivingOrders(
        prefs.getString('userEmail') ?? '',
        prefs.getString('userIdMetrika') ?? '',
      );
      if (response.error != null) {
        emit(CreditRatingErrorState(response.error));
      } else {
        emit(CreditRatingOrdersReadyState(orders: response.items));
      }
    } catch (error) {
      String? message;
      if (error is DioException) {
        message = error.message;
      }
      emit(CreditRatingErrorState(message));
    }
  }

  Future<void> checkPayment(String orderId, String email) async {
    try {
      var userId = prefs.getString('userIdMetrika') ?? '';
      var response = await repository.checkPayment(orderId, userId);

      if (_isCancelled) return; // Проверяем, отменён ли запрос

      if (response.isPayed) {
        await prefs.setString('userEmail', email);
        changeStatus(true);
        emit(CreditRatingPaymentReadyState(email: email));
      } else {
        await Future.delayed(Duration(seconds: 3), () {
          if (!_isCancelled) checkPayment(orderId, email);
        });
      }
    } catch (error) {
      await Future.delayed(Duration(seconds: 3), () {
        if (!_isCancelled) checkPayment(orderId, email);
      });
    }
  }

  void changeStatus([bool? status]) {
    _isCancelled = status ?? !_isCancelled;
  }

  void getRegions() {
    var regionResponse = RegionResponse.fromJson(regionsMap);
    regions = regionResponse.regions;
  }

  Future<void> getCart() async {
    emit(CreditRatingLoadingState());

    try {
      getRegions();
      productModel = await repository.getCart();
      if (productModel!.error != null) {
        emit(CreditRatingErrorState(productModel!.error));
      } else {
        emit(CreditRatingetCardReadyState(productModel: productModel!));
      }
    } catch (error) {
      String? message;
      if (error is DioException) {
        message = error.message;
      }
      emit(CreditRatingErrorState(message));
    }
  }

  Future<void> getPayments(JsonMap body) async {
    emit(CreditRatingPaymentLoadingState());

    try {
      var paymentResponse = await repository.getPayments(body);
      if (paymentResponse.error != null) {
        emit(CreditRatingErrorState(paymentResponse.error));
      } else {
        emit(
          CreditRatingetgetPaymentsReadyState(paymentResponse: paymentResponse),
        );
      }
    } catch (error) {
      String? message;
      if (error is DioException) {
        message = error.message;
      }
      emit(CreditRatingErrorState(message));
    }
  }
}

sealed class CreditRatingState {}

final class CreditRatingInitialState extends CreditRatingState {}

final class CreditRatingLoadingState extends CreditRatingState {}

final class CreditRatingOrdersLoadingState extends CreditRatingState {}

final class CreditRatingPaymentLoadingState extends CreditRatingState {}

final class CreditRatingPaymentReadyState extends CreditRatingState {
  String email;
  CreditRatingPaymentReadyState({required this.email});
}

final class CreditRatingOrdersReadyState extends CreditRatingState {
  final List<OrderModel> orders;
  CreditRatingOrdersReadyState({required this.orders});
}

final class CreditRatingReadyState extends CreditRatingState {}

final class CreditRatinGetRegionsReadyState extends CreditRatingState {}

final class CreditRatingetCardReadyState extends CreditRatingState {
  final product.ProductModel productModel;

  CreditRatingetCardReadyState({required this.productModel});
}

final class CreditRatingetgetPaymentsReadyState extends CreditRatingState {
  final PaymentResponse paymentResponse;

  CreditRatingetgetPaymentsReadyState({required this.paymentResponse});
}

final class CreditRatingErrorState extends CreditRatingState {
  final String? text;

  CreditRatingErrorState([this.text]);
}
