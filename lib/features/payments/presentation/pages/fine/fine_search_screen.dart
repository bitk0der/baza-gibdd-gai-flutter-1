import 'package:auto_route/auto_route.dart';
import 'package:baza_gibdd_gai/core/utils/sp_util.dart';
import 'package:baza_gibdd_gai/core/widgets/app_custom_scaffold.dart';
import 'package:baza_gibdd_gai/features/payments/data/repositories/api_util.dart';
import 'package:baza_gibdd_gai/features/payments/domain/repositories/search_data_repository.dart';
import 'package:baza_gibdd_gai/features/payments/domain/repositories/storage_data_repository.dart';
import 'package:baza_gibdd_gai/features/payments/domain/repositories/storage_util.dart';
import 'package:baza_gibdd_gai/features/payments/domain/service/rest_service.dart';
import 'package:baza_gibdd_gai/features/payments/presentation/widgets/empty_search_placeholder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:baza_gibdd_gai/core/theme/app_colors.dart';
import 'package:baza_gibdd_gai/core/utils/strings.dart';
import 'package:baza_gibdd_gai/core/utils/ui_util.dart';
import 'package:baza_gibdd_gai/core/widgets/custom_app_bar.dart';
import 'package:baza_gibdd_gai/features/payments/data/models/payments/fine.dart';
import 'package:baza_gibdd_gai/features/payments/data/models/subscription.dart';
import 'package:baza_gibdd_gai/features/payments/data/models/user_data.dart';
import 'package:baza_gibdd_gai/features/payments/presentation/blocs/payments_search_bloc.dart';
import 'package:baza_gibdd_gai/features/payments/presentation/blocs/subscription_bloc.dart';
import 'package:baza_gibdd_gai/features/payments/presentation/pages/payment_webview.dart';
import 'package:baza_gibdd_gai/features/payments/presentation/widgets/custom_button.dart';
import 'package:baza_gibdd_gai/features/payments/presentation/widgets/error_body.dart';
import 'package:baza_gibdd_gai/features/payments/presentation/widgets/loading_screen.dart';

@RoutePage()
class FineSearchScreen extends StatefulWidget {
  final UserData userData;
  final bool isFromPush;

  const FineSearchScreen({
    super.key,
    required this.userData,
    this.isFromPush = false,
  });

  @override
  _FineSearchScreenState createState() => _FineSearchScreenState();
}

class _FineSearchScreenState extends State<FineSearchScreen> {
  late PaymentsSearchBloc _bloc;
  late SubscriptionBloc _subscriptionBloc;

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    _bloc = GetIt.I<PaymentsSearchBloc>();
    _bloc.add(
        PaymentsSearchBlocSearchEvent(widget.userData, SubscriptionType.fines));
    if (!widget.isFromPush) {
      _subscriptionBloc = GetIt.I<SubscriptionBloc>();
    } else {
      _subscriptionBloc = SubscriptionBloc(
          searchRepository:
              PaymentsSearchDataRepository(ApiUtil(RestService())),
          storageRepository: StorageDataRepository(StorageUtil(), SpUtil()));
    }
    _subscriptionBloc.add(
      SubscriptionBlocSearchEvent(
        request: widget.userData.copyWith(birthCertificate: null),
        type: SubscriptionType.fines,
      ),
    );
    super.initState();
  }

  /*  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  } */

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: AppCustomScaffold(
        key: _scaffoldKey,
        appBar: CustomAppBar.getAppBar(
            title: Strings.fineScreenTitle,
            onTapBackButton: () => context.maybePop()),
        body: _getBodyBuilder(),
      ),
    );
  }

  Widget _getBodyBuilder() {
    return BlocListener(
      bloc: _subscriptionBloc,
      listener: (context, state) {
        if (state is SubscriptionBlocShowButtonState) {
          if (state.showDialog) {
            /*        CustomDialog.show(
              context: context,
              title: Strings.subscriptionDialogTitle,
              subtitle: Strings.subscriptionDialogSubtitle,
              widget: CustomCheckbox(
                title: 'Больше не спрашивать',
                initialValue: false,
                controller: _checkboxController,
              ),
              buttonOneOnTap: () {
                _subscriptionBloc.add(
                  SubscriptionBlocSubscribeEvent(
                    request: widget.userData.copyWith(birthCertificate: null),
                    type: SubscriptionType.fines,
                  ),
                );
                _showSuccessSubscriptionDialog();
                if (_checkboxController.value) {
                  _subscriptionBloc.add(SubscriptionBlocNotShowDialogEvent());
                }
              },
              buttonTwoOnTap: () {
                if (_checkboxController.value) {
                  _subscriptionBloc.add(SubscriptionBlocNotShowDialogEvent());
                }
              },
            ); */
          }
        }
      },
      child: BlocBuilder(
        bloc: _bloc,
        builder: (context, state) {
          if (state is PaymentsSearchBlocReadyState) {
            return BlocBuilder(
              bloc: _subscriptionBloc,
              builder: (_, subscriptionState) => Stack(
                children: [
                  /*  if (state.fines.isNotEmpty) */ _getBody(state.fines),
                  if (state.fines.isEmpty) const EmptySearchPlaceholder(),
                  /* if (subscriptionState is SubscriptionBlocShowButtonState)
                    _getSubscribeButton(), */
                ],
              ),
            );
          } else if (state is PaymentsSearchBlocLoadingState) {
            return const LoadingSearchIndicator();
          } else if (state is PaymentsSearchBlocErrorState) {
            return const ErrorPlaceholder();
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }

  Widget _getBody(List<Fine> fines) {
    return ListView.separated(
      padding:
          EdgeInsets.only(left: 16.w, right: 16.w, top: 20.h, bottom: 80.h),
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        if (index == 0) {
          return Text(
            "Найдено ${fines.length} ${UiUtil.invoicesCountPlural(fines.length)}",
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 14.sp,
              color: ColorStyles.white,
            ),
          );
        } else {
          return _getFineCard(fines[index - 1]);
        }
      },
      separatorBuilder: (context, index) {
        return SizedBox(height: 20.h);
      },
      itemCount: fines.length + 1,
    );
  }

  Widget _getFineCard(Fine fine) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: ColorStyles.white,
          gradient: LinearGradient(
              colors: ColorStyles.cardGradient,
              end: Alignment.bottomLeft,
              begin: AlignmentGeometry.topRight)),
      padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (fine.date != null) ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                /*  Text(
                  'Сумма задолженности',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 14.sp,
                    color: ColorStyles.primaryBlue,
                  ),
                ), */
                /*  Text(
                  DateFormat('dd.MM.yyyy, HH:mm').format(fine.date!),
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 14.sp,
                    color: ColorStyles.white,
                  ),
                ), */
              ],
            ),
          ],
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                fine.number.toString().replaceRange(
                    13, fine.number!.length, '*' * (fine.number!.length - 13)),
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: ColorStyles.white,
                ),
              ),
              if (fine.name != null)
                Text(
                  fine.name!.toUpperCase(),
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Oswald',
                    color: ColorStyles.white,
                  ),
                ),
            ],
          ),
          SizedBox(height: 10.h),
          if (fine.summ != null)
            Text(
              "${fine.summ!.toInt()} ₽",
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 24.sp,
                fontFamily: 'Oswald',
                color: ColorStyles.lightblue,
              ),
            ),
          if (fine.summ != null) SizedBox(height: 12.h),
          Container(
            padding: EdgeInsets.all(14.w),
            width: double.infinity,
            decoration: BoxDecoration(
                color: ColorStyles.fillColor,
                borderRadius: BorderRadius.circular(14)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Инициатор",
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                    color: ColorStyles.white.withValues(alpha: 0.6),
                  ),
                ),
                if (fine.organization != null) ...[
                  Text(
                    fine.organization!,
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                      color: ColorStyles.white,
                    ),
                  ),
                ],
              ],
            ),
          ),
          SizedBox(height: 20.h),
          Row(
            children: [
              /* Flexible(
                child: CustomButton(
                  title: "${fine.summ!.toInt()} ₽",
                  height: 46.h,
                  color: const Color(0xffFFDCD9),
                  titleColor: const Color(0xffFF0000),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => PaymentWebview(yin: fine.number),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(width: 10), */
              Flexible(
                  child: CustomButton(
                title: "Оплатить",
                height: 46.h,
                color: ColorStyles.blue,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => PaymentWebview(yin: fine.number),
                    ),
                  );
                },
              )),
            ],
          )
        ],
      ),
    );
  }

/*   Widget _getSubscribeButton() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
        child: Container(
          height: 56.h,
          width: double.maxFinite,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: ColorStyles.invoiceStatusRed,
          ),
          child: TextButton(
            onPressed: () {
              _subscriptionBloc.add(
                SubscriptionBlocSubscribeEvent(
                  request: UserData(
                    passport: widget.userData.passport,
                    vy: widget.userData.vy,
                    sts: widget.userData.sts,
                  ),
                  type: SubscriptionType.fines,
                ),
              );
              _showSuccessSubscriptionDialog();
            },
            style: TextButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 20.w),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
            ),
            child: Row(
              children: [
                Assets.icons.navBarIcons.chatNavBarIcon.svg(),
                SizedBox(width: 23.w),
                Text(
                  'Подписаться на уведомления',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w500,
                    fontSize: 18.sp,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  } 

  void _showSuccessSubscriptionDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          contentPadding: EdgeInsets.zero,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(6))),
          backgroundColor: Colors.red,
          content: SafeArea(
            child: Padding(
              padding: EdgeInsets.only(top: 16.h),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            'Уведомление оформлено',
                            style: TextStyle(
                              fontSize: 18.sp,
                              color: ColorStyles.black,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        InkWell(
                          child: Icon(
                            Icons.close,
                            size: 24.w,
                            color: ColorStyles.black,
                          ),
                          onTap: () => Navigator.pop(context),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Text(
                      'Вы будете получать уведомления о новых задолженностях по этому поиску.\nПолучение уведомлений можно отменить в разделе “Профиль”.',
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: ColorStyles.black,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  SizedBox(
                    height: 60.h,
                    child: Column(
                      children: [
                        Container(
                          height: 1.h,
                          width: double.maxFinite,
                          color: ColorStyles.black,
                        ),
                        const Spacer(),
                        SizedBox(
                          height: 50.h,
                          width: double.maxFinite,
                          child: TextButton(
                            onPressed: () => Navigator.pop(context),
                            style: TextButton.styleFrom(
                              shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.zero),
                            ),
                            child: Center(
                              child: Text(
                                'Закрыть',
                                style: TextStyle(
                                  color: ColorStyles.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18.sp,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const Spacer(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }*/
}
