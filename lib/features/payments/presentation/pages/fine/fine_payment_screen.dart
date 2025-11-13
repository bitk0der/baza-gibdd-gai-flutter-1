import 'package:auto_route/auto_route.dart';
import 'package:baza_gibdd_gai/core/routes/app_router.dart';
import 'package:baza_gibdd_gai/core/theme/app_colors.dart';
import 'package:baza_gibdd_gai/core/widgets/app_button.dart';
import 'package:baza_gibdd_gai/core/widgets/app_card_layout.dart';
import 'package:baza_gibdd_gai/core/widgets/app_custom_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:baza_gibdd_gai/core/utils/ui_util.dart';
import 'package:baza_gibdd_gai/core/widgets/custom_app_bar.dart';
import 'package:baza_gibdd_gai/features/payments/data/models/user_data.dart';
import 'package:baza_gibdd_gai/features/payments/presentation/blocs/user_data_bloc.dart';
import 'package:baza_gibdd_gai/features/payments/presentation/widgets/custom_snackbar.dart';
import 'package:baza_gibdd_gai/features/payments/presentation/widgets/custom_textfield.dart';
import 'package:baza_gibdd_gai/features/payments/presentation/widgets/how_to_fill_card.dart';
import 'package:baza_gibdd_gai/features/app_banner/app_banner_initial_setup.dart';
import 'package:baza_gibdd_gai/features/app_banner/presentation/app_universal_banner_widget.dart';
import 'package:baza_gibdd_gai/features/payments/presentation/widgets/tab_button.dart';
import 'package:baza_gibdd_gai/gen/assets.gen.dart';

@RoutePage()
class FinePaymentScreen extends StatefulWidget {
  const FinePaymentScreen({super.key});

  @override
  State<FinePaymentScreen> createState() => _FinePaymentScreenState();
}

class _FinePaymentScreenState extends State<FinePaymentScreen> {
  final _passportController = TextEditingController();
  final _vyController = TextEditingController();
  final _stsController = TextEditingController();

  late UserDataBloc _bloc = GetIt.I<UserDataBloc>();

  int _tabIndex = 0;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  var keyboardVisibilityController = KeyboardVisibilityController();
  bool keyboardVisible = false;

  @override
  void initState() {
    _bloc = GetIt.I<UserDataBloc>();
    keyboardVisibilityController.onChange.listen((visible) {
      setState(() => keyboardVisible = visible);
    });
    _passportController.text = _bloc.userData.passport ?? '';
    _vyController.text = _bloc.userData.vy ?? '';
    _stsController.text = _bloc.userData.sts ?? '';
    super.initState();
  }

  @override
  void dispose() {
    _passportController.dispose();
    _vyController.dispose();
    _stsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: AppCustomScaffold(
        key: _scaffoldKey,
        appBar: CustomAppBar.getAppBar(
          title: 'Поиск и оплата штрафов ГИБДД',
          isBackButton: false,
          onTapBackButton: () => context.maybePop(),
          /*   actions: [
            AppCircleButton(
                buttonSize: 40,
                padding: 9,
                icon: Assets.icons.bell,
                backgroundColor: Colors.white.withValues(alpha: 0.1),
                onTap: () =>
                    context.router.navigate(BackgroundNotificationsRoute())),
          ], */
        ),
        body: _getBody(),
        floatingActionButton: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: AppButton(
                  height: 51,
                  title: "Проверить наличие штрафов",
                  onTap: _onButtonPressed,
                ),
              ),
              if (!keyboardVisible) SizedBox(height: kToolbarHeight * 2),
            ],
          ),
        ),
      ),
    );
  }

  Widget _getBody() {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      child: Column(
        children: [
          AppUniversalBannerWidget(category: 'pays-page', banners: bannerList),
          SizedBox(height: 16.h),
          AppCardLayout(
            padding: EdgeInsets.all(4),
            color: ColorStyles.backgroundViolet,
            border: Border.all(color: Colors.white.withValues(alpha: 0.5)),
            child: Row(
              children: [
                Flexible(
                  child: TabButton(
                      isActive: _tabIndex == 0,
                      text: 'Паспорт',
                      onTap: () => onTap(0)),
                ),
                SizedBox(width: 7.w),
                Flexible(
                    child: TabButton(
                        isActive: _tabIndex == 1,
                        text: 'ВУ',
                        onTap: () => onTap(1))),
                SizedBox(width: 7.w),
                Flexible(
                    child: TabButton(
                        isActive: _tabIndex == 2,
                        text: 'СТС',
                        onTap: () => onTap(2))),
              ],
            ),
          ),
          SizedBox(height: 30.h),
          _getTabs(),
          SizedBox(height: 30.h),
        ],
      ),
    );
  }

  Widget _getTabs() {
    return IndexedStack(
      index: _tabIndex,
      children: [
        Column(
          children: [
            CustomTextField(
              title: "Серия и номер паспорта РФ:",
              hintText: "Введите серию и номер паспорта",
              keyboardType: TextInputType.number,
              isNeedSuffixIcon: false,
              controller: _passportController,
              maxLength: 12,
              inputFormatters: [
                MaskTextInputFormatter(
                    mask: '## ## ######', filter: {"#": RegExp(r'\d')}),
              ],
            ),
            SizedBox(height: 16.h),
            HowToFillCard(
                type: '',
                title: 'Паспортные данные',
                backgroundColor: const Color(0xff4065E4),
                iconColor: Colors.white,
                image: Assets.images.passportHelp),
          ],
        ),
        Column(
          children: [
            CustomTextField(
              title: "Водительское удостоверение",
              hintText: "Введите серию и номер ВУ",
              controller: _vyController,
              isNeedSuffixIcon: false,
              inputFormatters: [
                UpperCaseTextFormatter(),
                MaskTextInputFormatter(
                  mask: '##** ######',
                  filter: {
                    "#": RegExp(r'\d'),
                    "*": RegExp(r'[\dА-Яа-я]'),
                  },
                ),
              ],
              keyboardType: TextInputType.name,
              maxLength: 11,
            ),
            SizedBox(height: 16.h),
            HowToFillCard(
                type: '',
                title: 'Серия и номер ВУ',
                backgroundColor: const Color(0xff4065E4),
                iconColor: Colors.white,
                image: Assets.images.vuHelp),
          ],
        ),
        Column(
          children: [
            CustomTextField(
              title: "СТС",
              hintText: "Введите серию и номер СТС",
              controller: _stsController,
              isNeedSuffixIcon: false,
              inputFormatters: [
                UpperCaseTextFormatter(),
                MaskTextInputFormatter(
                    mask: '## ## ######', filter: {"#": RegExp(r'\d')}),
              ],
              keyboardType: TextInputType.name,
              maxLength: 12,
            ),
            SizedBox(height: 16.h),
            HowToFillCard(
                type: '',
                title: 'СТС автомобиля',
                backgroundColor: const Color(0xff4065E4),
                iconColor: Colors.white,
                image: Assets.images.stsHelp),
          ],
        ),
      ],
    );
  }

  onTap(int index) {
    if (_tabIndex != index) {
      /* _vyController.text = '';
      _passportController.text = '';
      _stsController.text = ''; */
      setState(() => _tabIndex = index);
    }
  }

  void _onButtonPressed([bool onlySave = false]) async {
    FocusScope.of(context).unfocus();
    String passport = '';
    String sts = '';
    String vy = '';
    if (_passportController.text.isNotEmpty) {
      passport = UiUtil.formatPasport(_passportController.text);
    }
    if (_stsController.text.isNotEmpty) {
      sts = UiUtil.formatSts(_stsController.text);
    }
    if (_vyController.text.isNotEmpty) {
      vy = UiUtil.formatVy(_vyController.text);
    }
    if (passport.isNotEmpty && !UiUtil.checkPasport(passport)) {
      CustomSnackbar.show(context, _scaffoldKey,
          text: "Некорректный номер паспорта");
    } else {
      if (sts.isNotEmpty && !UiUtil.checkSts(UiUtil.translit(sts))) {
        CustomSnackbar.show(context, _scaffoldKey,
            text: "Некорректный номер СТС");
      } else {
        if (vy.isNotEmpty && !UiUtil.checkVy(vy)) {
          CustomSnackbar.show(context, _scaffoldKey,
              text: "Некорректный номер ВУ");
        } else {
          if (passport.isEmpty && sts.isEmpty && vy.isEmpty) {
            CustomSnackbar.show(context, _scaffoldKey,
                text: "Заполните хотя бы одно из полей");
          } else {
            /*  var isNeedSaveUserData = await showModal(context); */

            final userData = _bloc.userData.copyWith(
              passport: _tabIndex == 0 ? _passportController.text : null,
              vy: _tabIndex == 1 ? vy : null,
              sts: _tabIndex == 2 ? sts : null,
              forceNull: false,
            );

            _bloc.add(UserDataBlocSaveEvent(userData));

            if (!onlySave) {
              context.router.navigate(FineSearchRoute(
                userData: UserData(
                  passport: _tabIndex == 0 ? _passportController.text : null,
                  vy: _tabIndex == 1 ? vy : null,
                  sts: _tabIndex == 2 ? sts : null,
                ),
              ));
            }
          }
        }
      }
    }
  }
}
