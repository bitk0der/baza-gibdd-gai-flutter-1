import 'package:auto_route/auto_route.dart';
import 'package:baza_gibdd_gai/core/widgets/app_custom_scaffold.dart';
import 'package:baza_gibdd_gai/features/app_banner/presentation/app_web_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:baza_gibdd_gai/core/constants/constants.dart';
import 'package:baza_gibdd_gai/core/theme/app_colors.dart';
import 'package:baza_gibdd_gai/core/theme/app_fonts.dart';
import 'package:baza_gibdd_gai/core/widgets/app_button.dart';
import 'package:baza_gibdd_gai/core/widgets/app_card_layout.dart';
import 'package:baza_gibdd_gai/core/widgets/custom_app_bar.dart';
import 'package:baza_gibdd_gai/features/chat_with_gpt/presentation/widgets/custom_textfield.dart';
import 'package:baza_gibdd_gai/features/credit_rating/data/models/order_to_report_mapper.dart';
import 'package:baza_gibdd_gai/features/credit_rating/data/models/orders_response.dart';
import 'package:baza_gibdd_gai/features/credit_rating/presentation/blocs/credit_rating_cubit.dart';
import 'package:baza_gibdd_gai/features/credit_rating/presentation/widgets/report_widget.dart';
import 'package:baza_gibdd_gai/gen/assets.gen.dart';
import 'package:shared_preferences/shared_preferences.dart';

@RoutePage()
class CreditRatingMainOldPage extends StatefulWidget {
  const CreditRatingMainOldPage({super.key});

  @override
  State<CreditRatingMainOldPage> createState() => _CreditRatingMainPageState();
}

class _CreditRatingMainPageState extends State<CreditRatingMainOldPage>
    with TickerProviderStateMixin {
  late TabController tabController;

  CreditRatingCubit creditRatingCubit = GetIt.I<CreditRatingCubit>();
  TextEditingController emailController = TextEditingController();
  TextEditingController searchController = TextEditingController();
  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    creditRatingCubit.getCart();
    emailController.text =
        GetIt.I<SharedPreferences>().getString('userEmail') ?? '';

    super.initState();
  }

  bool firstTabFirstPage = true;
  bool secondTabFirstPage = true;

  final emailGibddGlobalKey = GlobalKey<FormState>();
  final emailGlobalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return AppCustomScaffold(
      appBar: CustomAppBar.getAppBar(
        title: 'Мои отчеты',
        isBackButton: false,
        isTitleCenter: true,
        onTapBackButton: () => context.maybePop(),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
            child: Container(
              padding: EdgeInsets.all(4),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
                borderRadius: BorderRadius.circular(10),
                color: ColorStyles.backgroundViolet,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: BlocConsumer(
                bloc: creditRatingCubit,
                listener: (c, state) {
                  if (state is CreditRatingPaymentReadyState) {
                    emailController.text = state.email;
                    creditRatingCubit.getReceivingOrders();
                    tabController.animateTo(1);
                  }
                  if (state is CreditRatingErrorState) {
                    if (context.router.currentPath == '/credit_rating') {
                      var snackBar = SnackBar(
                        content: Text(state.text ?? 'Произошла ошибка'),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                  }
                },
                builder: (c, state) => TabBar(
                  dividerColor: Colors.transparent,
                  controller: tabController,
                  indicatorSize: TabBarIndicatorSize.tab,
                  labelStyle: TextStyles.h4.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                  unselectedLabelStyle: TextStyles.h4
                      .copyWith(color: Colors.white.withValues(alpha: 0.5)),
                  indicator: BoxDecoration(
                    gradient:
                        LinearGradient(colors: ColorStyles.blueTabBarGradient),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  tabs: [
                    Tab(text: 'Проверка авто'),
                    Tab(text: 'Проверка физлица'),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: tabController,
              children: [
                AppWebView(
                    isNeedAppBar: false,
                    url:
                        'https://xn----7sbbdcsj3bpai5b1a8n.xn--p1ai/appwidget/orders.html'),
                secondTabFirstPage
                    ? secondTab(false)
                    : secondTabSecondPage(false),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static final List<String> _kOptions = <String>[
    'aardvark',
    'bobcat',
    'chameleon',
  ];

  BlocConsumer<CreditRatingCubit, CreditRatingState> secondTabSecondPage(
      bool isGibdd) {
    return BlocConsumer(
      bloc: creditRatingCubit,
      listener: (c, state) {
        if (state is CreditRatingPaymentReadyState) {
          emailController.text = state.email;
          creditRatingCubit.getReceivingOrders();
          tabController.animateTo(1);
        }
      },
      builder: (c, state) {
        if (state is CreditRatingOrdersReadyState ||
            state is CreditRatingErrorState) {
          List<OrderModel> orders =
              state is CreditRatingOrdersReadyState ? state.orders : [];
          List<OrderModel> filteredOrders = orders.where((order) {
            return order.name.toLowerCase().contains(
                  searchController.text.toLowerCase(),
                );
          }).toList();
          return SafeArea(
              child: Stack(
            children: [
              Scaffold(
                backgroundColor: Colors.transparent,
                body: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: SafeArea(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppCardLayout(
                          isNeedShadow: true,
                          color: ColorStyles.darkGreenGradient.first,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (orders.isEmpty) ...[
                                Text(
                                  'Укажите электронный адрес для получения отчета',
                                  style: TextStyles.h1.copyWith(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 20.sp,
                                    height: 1.1,
                                  ),
                                ),
                                SizedBox(height: 13.h),
                              ],
                              Form(
                                key: isGibdd
                                    ? emailGibddGlobalKey
                                    : emailGlobalKey,
                                child: textFieldWithTitle(
                                  title: 'E-mail:',
                                  focusNode: FocusNode(),
                                  validator: validateEmail(),
                                  hintText: 'example@mail.ru',
                                  fillColor: ColorStyles.fillColor,
                                  controller: emailController,
                                ),
                              ),
                              if (orders.isNotEmpty) ...[
                                SizedBox(height: 8.h),
                                checkButton(isGibdd),
                              ],
                            ],
                          ),
                        ),
                        SizedBox(height: 12.h),
                        CustomTextField(
                          hintText: 'Поиск...',
                          fillColor: ColorStyles.fillColor,
                          controller: searchController,
                          keyboardType: TextInputType.text,
                          onChanged: (p0) {
                            setState(() {});
                          },
                          prefixIcon: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 11,
                            ).copyWith(right: 12),
                            child: Assets.icons.search.svg(
                              colorFilter: ColorFilter.mode(
                                Colors.black26,
                                BlendMode.srcIn,
                              ),
                            ),
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 11,
                          ),
                        ),
                        filteredOrders.isEmpty
                            ? Container(
                                padding: EdgeInsets.all(20),
                                child: Text(
                                  'По вашим параметрам отчетов не найдено',
                                  style: TextStyles.h1,
                                  textAlign: TextAlign.center,
                                ),
                              )
                            : ListView.separated(
                                shrinkWrap: true,
                                padding: EdgeInsets.symmetric(vertical: 20),
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (c, index) {
                                  var report = OrderToUserReportMapper.map(
                                    filteredOrders[index],
                                  );
                                  return ReportWidget(report: report);
                                },
                                separatorBuilder: (c, index) =>
                                    SizedBox(height: 12.h),
                                itemCount: filteredOrders.length,
                              ),
                        SizedBox(height: 70.h),
                      ],
                    ),
                  ),
                ),
              ),
              if (orders.isEmpty)
                Positioned(
                  bottom: 10,
                  left: 20,
                  right: 20,
                  child: checkButton(isGibdd),
                ),
            ],
          ));
        }

        return Center(
          child: SizedBox(
            height: 44,
            width: 44,
            child: CircularProgressIndicator(color: ColorStyles.blue),
          ),
        );
      },
    );
  }

  AppButton checkButton(bool isGibdd) {
    return AppButton(
      onTap: () async {
        bool isValid = isGibdd
            ? emailGibddGlobalKey.currentState!.validate()
            : emailGlobalKey.currentState!.validate();

        if (isValid) {
          await GetIt.I<SharedPreferences>().setString(
            'userEmail',
            emailController.text,
          );
          if (!isGibdd) {
            creditRatingCubit.getReceivingOrders();
            secondTabFirstPage = false;
          } else {
            creditRatingCubit.getReceivingOrders();
            firstTabFirstPage = false;
          }
          setState(() {});
        }
      },
      backgroundColor: ColorStyles.blue,
      title: 'Проверить',
    );
  }

  Container secondTab(bool isGibdd) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppCardLayout(
                isNeedShadow: true,
                color: ColorStyles.darkGreenGradient.first,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Укажите электронный адрес на который заказывали отчет',
                      style: TextStyles.h1.copyWith(
                        fontWeight: FontWeight.w500,
                        fontSize: 20.sp,
                        height: 1.1,
                      ),
                    ),
                    SizedBox(height: 14.h),
                    Form(
                      key: isGibdd ? emailGibddGlobalKey : emailGlobalKey,
                      child: textFieldWithTitle(
                        title: 'E-mail:',
                        fillColor: ColorStyles.fillColor,
                        focusNode: FocusNode(),
                        hintText: 'example@mail.ru',
                        validator: validateEmail(),
                        controller: emailController,
                      ),
                    ),
                    SizedBox(height: 14.h),
                    AppButton(
                      onTap: () async {
                        bool isValid = isGibdd
                            ? emailGibddGlobalKey.currentState!.validate()
                            : emailGlobalKey.currentState!.validate();

                        if (isValid) {
                          await GetIt.I<SharedPreferences>().setString(
                            'userEmail',
                            emailController.text,
                          );
                          if (!isGibdd) {
                            creditRatingCubit.getReceivingOrders();
                            secondTabFirstPage = false;
                          } else {
                            creditRatingCubit.getReceivingOrders();
                            firstTabFirstPage = false;
                          }
                          setState(() {});
                        }
                      },
                      backgroundColor: ColorStyles.blue,
                      title: 'Проверить',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );

  Column textFieldWithTitle({
    required String title,
    required String hintText,
    required TextEditingController controller,
    required FocusNode focusNode,
    Key? key,
    TextInputType keyboardType = TextInputType.name,
    List<TextInputFormatter>? inputFormatters,
    String? Function(String?)? validator,
    bool isNeedAutoComplete = false,
    Color fillColor = ColorStyles.white,
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
        isNeedAutoComplete
            ? Autocomplete<String>(
                key: key,
                optionsBuilder: (TextEditingValue textEditingValue) {
                  if (textEditingValue.text.isEmpty) {
                    return const Iterable<String>.empty();
                  }
                  return _kOptions.where((String option) {
                    return option.toLowerCase().contains(
                          textEditingValue.text.toLowerCase(),
                        );
                  });
                },
                onSelected: (String selection) {
                  controller.text = selection; // Очищаем основной контроллер
                  debugPrint('You just selected $selection');
                },
                fieldViewBuilder: (
                  context,
                  textEditingController,
                  focusNode1,
                  onFieldSubmitted,
                ) {
                  focusNode.addListener(() {
                    if (focusNode.hasFocus) {
                      focusNode1.requestFocus();
                    }
                  });
                  return CustomTextField(
                    key: ValueKey(key.hashCode),
                    hintText: hintText,
                    focusNode: focusNode1,
                    textStyle: TextStyles.h3,
                    fillColor: fillColor,
                    keyboardType: keyboardType,
                    controller: textEditingController,
                    onChanged: (p0) => controller.text = '',
                    inputFormatters: inputFormatters,
                    validator: (value) {
                      return controller.text.isEmpty
                          ? 'Выберите регион из списка'
                          : null;
                    },
                  );
                },
              )
            : Container(
                key: key, // ✅ GlobalKey для контейнера (не для TextFormField)
                child: CustomTextField(
                  key: ValueKey(key.hashCode),
                  focusNode: focusNode,
                  hintText: hintText,
                  fillColor: fillColor,
                  keyboardType: keyboardType,
                  textStyle: TextStyles.h3,
                  controller: controller,
                  inputFormatters: inputFormatters,
                  validator: validator,
                ),
              ),
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
