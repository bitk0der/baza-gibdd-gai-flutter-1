import 'package:auto_route/auto_route.dart';
import 'package:baza_gibdd_gai/core/constants/constants.dart';
import 'package:baza_gibdd_gai/core/routes/app_router.dart';
import 'package:baza_gibdd_gai/core/theme/app_colors.dart';
import 'package:baza_gibdd_gai/core/theme/app_fonts.dart';
import 'package:baza_gibdd_gai/core/widgets/app_button.dart';
import 'package:baza_gibdd_gai/core/widgets/app_card_layout.dart';
import 'package:baza_gibdd_gai/core/widgets/app_custom_scaffold.dart';
import 'package:baza_gibdd_gai/core/widgets/custom_app_bar.dart';
import 'package:baza_gibdd_gai/features/chat_with_gpt/presentation/widgets/custom_textfield.dart';
import 'package:baza_gibdd_gai/features/credit_rating/data/models/product_model.dart';
import 'package:baza_gibdd_gai/features/credit_rating/data/models/request_payment_body.dart';
import 'package:baza_gibdd_gai/features/credit_rating/presentation/blocs/credit_rating_cubit.dart';
import 'package:baza_gibdd_gai/gen/assets.gen.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

@RoutePage()
class CheckoutPage extends StatefulWidget {
  final List<String> serviceParams;
  final AvailableProduct availableProduct;
  const CheckoutPage({
    super.key,
    required this.serviceParams,
    required this.availableProduct,
  });

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

CreditRatingCubit creditRatingCubit = GetIt.I<CreditRatingCubit>();
final infoGlobalKey = GlobalKey<FormState>();
TextEditingController emailController = TextEditingController();

class _CheckoutPageState extends State<CheckoutPage> {
  @override
  void initState() {
    emailController.text =
        GetIt.I<SharedPreferences>().getString('userEmail') ?? '';
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppCustomScaffold(
      appBar: CustomAppBar.getAppBar(
        title: 'Оформление заказа',
        isNeedImage: false,
        isTitleCenter: true,
        onTapBackButton: () => context.maybePop(),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            AppCardLayout(
              isNeedShadow: true,
              color: ColorStyles.darkGreenGradient.first,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Укажите электронный адрес для получения отчета',
                    style: TextStyles.h1.copyWith(
                      fontWeight: FontWeight.w500,
                      fontSize: 20.sp,
                      height: 1.1,
                    ),
                  ),
                  SizedBox(height: 13.h),
                  Form(
                    key: infoGlobalKey,
                    child: textFieldWithTitle(
                      title: 'E-mail:',
                      validator: validateEmail(),
                      hintText: 'example@mail.ru',
                      controller: emailController,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 12.h),
            DottedBorder(
                options: RoundedRectDottedBorderOptions(
                  dashPattern: [4, 4],
                  strokeWidth: 2,
                  color: ColorStyles.blue,
                  radius: Radius.circular(10),
                ),
                child: AppCardLayout(
                  isNeedShadow: true,
                  radius: 10,
                  color: ColorStyles.darkGreenGradient.first,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Детали заказа',
                        style: TextStyles.h1.copyWith(
                          fontWeight: FontWeight.w500,
                          fontSize: 20.sp,
                          height: 1.1,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      AppCardLayout(
                        color: ColorStyles.fillColor,
                        padding: EdgeInsets.symmetric(
                          horizontal: 14.w,
                          vertical: 13.h,
                        ),
                        child: Row(
                          children: [
                            Flexible(
                              child: Row(
                                children: [
                                  Assets.icons.blueCheck.svg(),
                                  SizedBox(width: 10),
                                  Flexible(
                                    child: Text(
                                      'Кредитный отчет о физическом лице',
                                      style: TextStyles.h4.copyWith(
                                        fontSize: 16.sp,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              '${widget.availableProduct.price ~/ 100} ₽',
                              style: TextStyles.h2.copyWith(
                                fontSize: 17.sp,
                                color: ColorStyles.green,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 8.h),
                      for (int i = 0; i < checkoutTitles.length; i++)
                        infoRow(
                          checkoutTitles[i],
                          i == 0
                              ? '${widget.serviceParams[0]} ${widget.serviceParams[1]} ${widget.serviceParams[2]}'
                              : widget.serviceParams[i + 2],
                        ),
                    ],
                  ),
                )),
            BlocConsumer(
              bloc: creditRatingCubit,
              listener: (context, state) {
                if (state is CreditRatingetgetPaymentsReadyState) {
                  context.router.push(
                    PaymentWebviewRoute(cart: state.paymentResponse.cart!),
                  );
                }
                if (state is CreditRatingErrorState) {
                  if (context.router.currentPath == '/search/checkout_route') {
                    var snackBar = SnackBar(
                      content: Text(state.text ?? 'Произошла ошибка'),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                }
              },
              builder: (context, state) => Padding(
                padding: const EdgeInsets.only(top: 30),
                child: AppButton(
                  isLoading: state is CreditRatingPaymentLoadingState,
                  onTap: () {
                    if (infoGlobalKey.currentState!.validate()) {
                      creditRatingCubit.getPayments(
                        RequestBody.requestPaymentBody(
                          emailController.text,
                          creditRatingCubit.productModel!.availableProduct!.id,
                          widget.serviceParams,
                        ),
                      );
                    }
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Assets.icons.verifyMark.svg(),
                      SizedBox(width: 10.w),
                      Text(
                        'Заказать отчет — ${widget.availableProduct.price ~/ 100} ₽',
                        style: TextStyles.h2.copyWith(
                          fontSize: 17.sp,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container infoRow(String title, String value) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      margin: EdgeInsets.only(bottom: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyles.h4.copyWith(
              fontSize: 14.sp,
              color: Colors.white.withValues(alpha: 0.5),
            ),
          ),
          Text(value, style: TextStyles.h4),
        ],
      ),
    );
  }

  Column textFieldWithTitle({
    required String title,
    required String hintText,
    required TextEditingController controller,
    TextInputType keyboardType = TextInputType.text,
    List<TextInputFormatter>? inputFormatters,
    String? Function(String?)? validator,
    bool isRequired = true,
  }) {
    return Column(
      children: [
        Row(
          children: [
            Text(title, style: TextStyles.h4),
            if (isRequired)
              Text('*', style: TextStyles.h4.copyWith(color: Colors.red)),
          ],
        ),
        SizedBox(height: 6.h),
        CustomTextField(
          hintText: hintText,
          controller: controller,
          inputFormatters: inputFormatters,
          keyboardType: keyboardType,
          validator: validator,
        ),
      ],
    );
  }
}
