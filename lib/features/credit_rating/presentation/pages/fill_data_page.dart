import 'package:auto_route/auto_route.dart';
import 'package:baza_gibdd_gai/core/constants/constants.dart';
import 'package:baza_gibdd_gai/core/routes/app_router.dart';
import 'package:baza_gibdd_gai/core/theme/app_colors.dart';
import 'package:baza_gibdd_gai/core/theme/app_fonts.dart';
import 'package:baza_gibdd_gai/core/widgets/app_button.dart';
import 'package:baza_gibdd_gai/core/widgets/app_card_layout.dart';
import 'package:baza_gibdd_gai/core/widgets/custom_app_bar.dart';
import 'package:baza_gibdd_gai/features/chat_with_gpt/presentation/widgets/custom_textfield.dart';
import 'package:baza_gibdd_gai/features/credit_rating/presentation/blocs/credit_rating_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:baza_gibdd_gai/gen/assets.gen.dart';
import 'package:shared_preferences/shared_preferences.dart';

@RoutePage()
class FillDataPage extends StatefulWidget {
  const FillDataPage({super.key});

  @override
  State<FillDataPage> createState() => _FillDataPageState();
}

class _FillDataPageState extends State<FillDataPage> {
  CreditRatingCubit creditRatingCubit = GetIt.I<CreditRatingCubit>();
  final ScrollController _scrollController = ScrollController();
  final infoGlobalKey = GlobalKey<FormState>();
  final emailGlobalKey = GlobalKey<FormState>();
  final documentsGlobalKey = GlobalKey<FormState>();
  late List<TextEditingController> infoControllers;
  late List<TextEditingController> documentsControllers;

  late List<FocusNode> documentsFocusNodes;
  late List<FocusNode> infoFocusNodes;

  final Map<int, GlobalKey> _infoFieldKeys = {};
  final Map<int, GlobalKey> _documentsFieldKeys = {};

  TextEditingController emailController = TextEditingController();
  TextEditingController searchController = TextEditingController();
  static final List<String> _kOptions = <String>[];
  @override
  void initState() {
    creditRatingCubit.getCart();

    infoControllers = List.generate(5, (index) => TextEditingController());
    documentsControllers = List.generate(4, (index) => TextEditingController());

    infoFocusNodes = List.generate(5, (index) => FocusNode());
    documentsFocusNodes = List.generate(4, (index) => FocusNode());

    emailController.text =
        GetIt.I<SharedPreferences>().getString('userEmail') ?? '';
    for (int i = 0; i < infoControllers.length; i++) {
      _infoFieldKeys[i] = GlobalKey();
    }
    for (int i = 0; i < documentsControllers.length; i++) {
      _documentsFieldKeys[i] = GlobalKey();
    }

    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    emailController.dispose();
    for (var node in infoFocusNodes) {
      node.dispose();
    }
    for (var controller in infoControllers) {
      controller.dispose();
    }

    for (var node in documentsFocusNodes) {
      node.dispose();
    }
    for (var controller in documentsControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorStyles.fillColor,
      appBar: CustomAppBar.getAppBar(
        title: 'Заполните данные',
        isTitleCenter: true,
        isNeedImage: true,
        onTapBackButton: () => context.maybePop(),
      ),
      body: BlocConsumer(
        bloc: creditRatingCubit,
        listener: (context, state) {},
        builder: (context, state) => creditRatingCubit.productModel == null
            ? Center(
                child: SizedBox(
                  width: 48,
                  height: 48,
                  child: CircularProgressIndicator(),
                ),
              )
            : ListView(
                controller: _scrollController,
                padding: EdgeInsets.all(16),
                children: [
                  Form(
                    key: infoGlobalKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppCardLayout(
                          color: ColorStyles.invoiceStatusRed,
                          width: double.infinity,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '* ',
                                style: TextStyles.h4.copyWith(
                                  fontSize: 14.sp,
                                  color: Colors.red,
                                ),
                              ),
                              Text(
                                '— обязательные поля для заполнения',
                                style: TextStyles.h4.copyWith(
                                  fontSize: 14.sp,
                                  color: Colors.black,
                                  height: 1.1,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 16.h),
                        ListView.separated(
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (c, index) {
                            var field = creditRatingCubit.productModel!
                                .availableProduct!.serviceParams.fields.entries
                                .toList()[index]
                                .value;
                            _kOptions.clear();
                            for (var region in creditRatingCubit.regions) {
                              _kOptions.add(region.name);
                            }

                            return textFieldWithTitle(
                              title: field.title,
                              key: _infoFieldKeys[index],
                              focusNode: infoFocusNodes[index],
                              isNeedAutoComplete: index == 4,
                              hintText: infoHintsFirstTabSecondPage[index],
                              inputFormatters: index == 3
                                  ? [
                                      MaskTextInputFormatter(
                                        mask: "##.##.####",
                                      ),
                                      FilteringTextInputFormatter.deny(
                                        RegExp(r'\s+$'),
                                      ),
                                    ]
                                  : [
                                      FilteringTextInputFormatter.deny(
                                        RegExp(r'\s+$'),
                                      ),
                                    ],
                              validator: index == 0 || index == 1
                                  ? getSimpleValidator(field.regexp)
                                  : index == 3
                                      ? getValidator(field.regexp, 2)
                                      : null,
                              isRequired: field.required,
                              keyboardType: index == 3
                                  ? TextInputType.number
                                  : TextInputType.name,
                              controller: infoControllers[index],
                            );
                          },
                          separatorBuilder: (c, index) =>
                              SizedBox(height: 13.h),
                          itemCount: 5,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 14.h),
                  AppCardLayout(
                    color: ColorStyles.lightOrange,
                    width: double.infinity,
                    padding: EdgeInsets.all(12),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Assets.icons.warning.svg(),
                        SizedBox(width: 10),
                        Flexible(
                          child: Column(
                            children: [
                              Text(
                                'Для получения кредитного рейтинга в БКИ необходимы паспортные данные',
                                style: TextStyles.h4.copyWith(
                                  fontSize: 14.sp,
                                  color: Colors.black,
                                  height: 1.1,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                'Персональные данные не разглашаются и не передаются третьим лицам',
                                style: TextStyles.h4.copyWith(
                                  fontSize: 13.sp,
                                  color: Colors.black.withValues(alpha: 0.7),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 14.h),
                  SafeArea(
                    child: Form(
                      key: documentsGlobalKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListView.separated(
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (c, index) {
                              var field = creditRatingCubit
                                  .productModel!
                                  .availableProduct!
                                  .serviceParams
                                  .fields
                                  .entries
                                  .skip(5)
                                  .toList()[index]
                                  .value;
                              return textFieldWithTitle(
                                title: field.title,
                                key: _documentsFieldKeys[index],
                                focusNode: documentsFocusNodes[index],
                                hintText:
                                    documentsHintsFirstTabSecondPage[index],
                                inputFormatters: [
                                  formatters[index],
                                  FilteringTextInputFormatter.deny(
                                    RegExp(r'\s+$'),
                                  ),
                                ],
                                isRequired: field.required,
                                keyboardType: TextInputType.number,
                                validator: getValidator(field.regexp, index),
                                controller: documentsControllers[index],
                              );
                            },
                            separatorBuilder: (c, index) =>
                                SizedBox(height: 13.h),
                            itemCount: creditRatingCubit.productModel!
                                .availableProduct!.serviceParams.fields.entries
                                .toList()
                                .skip(5)
                                .length,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            child: AppButton(
                              backgroundColor: ColorStyles.blue,
                              isLoading:
                                  state is CreditRatingPaymentLoadingState,
                              onTap: () => setState(() {
                                _validateAndFocus();
                              }),
                              title: 'Продолжить',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  AppButton checkButton() {
    return AppButton(
      onTap: () async {
        if (emailGlobalKey.currentState!.validate()) {
          await GetIt.I<SharedPreferences>().setString(
            'userEmail',
            emailController.text,
          );
          creditRatingCubit.getReceivingOrders();
          setState(() {});
        }
      },
      backgroundColor: ColorStyles.blue,
      title: 'Проверить',
    );
  }

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
                    fillColor: Colors.white,
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
                  fillColor: Colors.white,
                  keyboardType: keyboardType,
                  controller: controller,
                  inputFormatters: inputFormatters,
                  validator: validator,
                ),
              ),
      ],
    );
  }

  Future<void> _scrollToField(GlobalKey key, FocusNode focusNode) async {
    final context = key.currentContext;
    if (context != null) {
      await Scrollable.ensureVisible(
        context,
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut,
        alignmentPolicy: ScrollPositionAlignmentPolicy.keepVisibleAtStart,
      );
      FocusScope.of(this.context).requestFocus(focusNode);
    }
  }

  void _validateAndFocus() {
    bool isForm1Valid = infoGlobalKey.currentState?.validate() ?? false;
    bool isForm2Valid = documentsGlobalKey.currentState?.validate() ?? false;

    if (isForm1Valid && isForm2Valid) {
      List<String> serviceParams = [];
      for (var controller in infoControllers) {
        serviceParams.add(controller.text);
      }
      for (var controller in documentsControllers) {
        serviceParams.add(controller.text);
      }
      context.router.navigate(
        CheckoutRoute(
          serviceParams: serviceParams,
          availableProduct: creditRatingCubit.productModel!.availableProduct!,
        ),
      );
    } else {
      for (int i = 0; i < infoControllers.length; i++) {
        var field = creditRatingCubit
            .productModel!.availableProduct!.serviceParams.fields.entries
            .toList()[i]
            .value;

        var validator = i == 0 || i == 1
            ? getSimpleValidator(field.regexp)
            : i == 3
                ? getValidator(field.regexp, 2)
                : i == 4
                    ? (value) {
                        return value.isEmpty
                            ? 'Выберите регион из списка'
                            : null;
                      }
                    : null;
        if (validator != null && validator(infoControllers[i].text) != null) {
          _scrollToField(_infoFieldKeys[i]!, infoFocusNodes[i]);
          return;
        }
      }
      for (int i = 0; i < documentsControllers.length; i++) {
        var field = creditRatingCubit
            .productModel!.availableProduct!.serviceParams.fields.entries
            .skip(5)
            .toList()[i]
            .value;
        var validator = getValidator(field.regexp, i);
        if (validator(documentsControllers[i].text) != null) {
          _scrollToField(_documentsFieldKeys[i]!, documentsFocusNodes[i]);
          return;
        }
      }
    }
  }
}
