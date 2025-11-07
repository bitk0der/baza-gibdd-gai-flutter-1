import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:baza_gibdd_gai/core/constants/constants.dart';
import 'package:baza_gibdd_gai/core/theme/app_colors.dart';
import 'package:baza_gibdd_gai/core/theme/app_fonts.dart';
import 'package:baza_gibdd_gai/core/widgets/app_card_layout.dart';
import 'package:baza_gibdd_gai/core/widgets/app_circle_button.dart';
import 'package:baza_gibdd_gai/features/payments/data/models/alphabet_separated_list.dart';
import 'package:baza_gibdd_gai/features/payments/presentation/blocs/region_search_bloc.dart';
import 'package:baza_gibdd_gai/gen/assets.gen.dart';

class RegionsTextField extends StatefulWidget {
  final TextEditingController controller;
  final String? Function(String?)? validator;
  const RegionsTextField({
    super.key,
    required this.controller,
    this.validator,
  });

  @override
  _RegionsTextFieldState createState() => _RegionsTextFieldState();
}

class _RegionsTextFieldState extends State<RegionsTextField> {
  final _bloc = RegionSearchBloc();
  List<AlphabetSeparatedRegions> _regions = regionsList;

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppCardLayout(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Регион для поиска:',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: ColorStyles.black,
              fontSize: 16.sp,
            ),
          ),
          SizedBox(height: 5.h),
          GestureDetector(
            onTap: _showDialog,
            child: Theme(
              data: ThemeData(primaryColor: ColorStyles.white),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.transparent),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: TextFormField(
                  enabled: false,
                  validator: widget.validator,
                  controller: widget.controller,
                  onEditingComplete: () {
                    FocusScope.of(context).unfocus();
                  },
                  style: TextStyle(
                    fontFamily: "PTSans",
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w400,
                    color: ColorStyles.primaryBlue,
                  ),
                  decoration: InputDecoration(
                    disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: const BorderSide(
                        color: Colors.transparent,
                      ), //textFieldBorderColor
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: const BorderSide(
                        color: Colors.red,
                      ), //textFieldBorderColor
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: const BorderSide(
                        color: Colors.red,
                      ), //textFieldBorderColor
                    ),
                    errorStyle: TextStyle(
                      fontSize: 14.sp,
                      height: 0.9,
                      color: Colors.red,
                    ),
                    contentPadding: EdgeInsets.all(13.w),
                    fillColor: ColorStyles.primaryBlue,
                    filled: true,
                    suffixIcon: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: RotatedBox(
                          quarterTurns: 1,
                          child: Assets.icons.navBarIcons.chatNavBarIcon.svg(
                              width: 20,
                              height: 20,
                              colorFilter: const ColorFilter.mode(
                                  Colors.black45, BlendMode.srcIn))),
                    ),
                    hintText: 'Выберите регион',
                    border: InputBorder.none,
                    hintStyle: TextStyle(
                      fontFamily: "PTSans",
                      fontSize: 17.sp,
                      fontWeight: FontWeight.w400,
                      color: Colors.black.withValues(alpha: 0.5),
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  void _showDialog() {
    bool searchWasMade = false;
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => SizedBox(
        height: 750.h,
        child: BlocBuilder(
          bloc: _bloc,
          builder: (context, state) {
            _regions = regionsList;
            if (state is RegionSearchBlocReadyState && searchWasMade) {
              _regions = state.searchResult;
            }
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Регион',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 22,
                            color: ColorStyles.black,
                          ),
                        ),
                        AppCircleButton(
                          onTap: () => context.maybePop(),
                          icon: Assets.icons.closeIcon,
                          backgroundColor: Colors.black12,
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Container(
                    height: 50.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Theme(
                      data: Theme.of(context).copyWith(
                        primaryColor: ColorStyles.primaryBlue,
                      ),
                      child: TextFormField(
                        onChanged: (request) {
                          searchWasMade = true;
                          _bloc.add(RegionSearchBlocEvent(
                            request: request,
                            separatedRegions: regionsList,
                          ));
                        },
                        cursorColor: ColorStyles.primaryBlue,
                        decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(14.r),
                                borderSide: const BorderSide(
                                    color: Colors.transparent)),
                            fillColor: const Color(0xffE2F7FF),
                            filled: true,
                            prefixIcon: Padding(
                              padding: const EdgeInsets.all(12),
                              child:
                                  Assets.icons.navBarIcons.chatNavBarIcon.svg(),
                            ),
                            contentPadding: EdgeInsets.all(12.w),
                            prefixStyle: const TextStyle(
                              fontWeight: FontWeight.w600,
                              color: ColorStyles.primaryBlue,
                              fontSize: 16,
                            ),
                            border: InputBorder.none,
                            hintText: "Поиск...",
                            hintStyle: TextStyles.h2.copyWith(
                                color: Colors.black.withOpacity(0.5),
                                fontSize: 16.sp)),
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: ColorStyles.primaryBlue,
                          fontSize: 16.sp,
                        ),
                      ),
                    ),
                  ),
                ),
                _getRegionsList(),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _getRegionsList() {
    return Expanded(
      child: ListView.separated(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, separatedIndex) {
          return ListView.separated(
              shrinkWrap: true,
              padding: EdgeInsets.all(20.w),
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return TextButton(
                  onPressed: () {
                    widget.controller.text =
                        _regions[separatedIndex].regions[index];
                    Navigator.pop(context);
                  },
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    backgroundColor: ColorStyles.fillColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          height: 44,
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              _regions[separatedIndex].regions[index],
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ),
                        widget.controller.text ==
                                _regions[separatedIndex].regions[index]
                            ? Assets.icons.activeCircle.svg()
                            : Assets.icons.unactiveCircle.svg()
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return SizedBox(height: 10.h);
              },
              itemCount: _regions[separatedIndex].regions.length);
        },
        separatorBuilder: (context, separatedIndex) {
          return Container(
            height: 28,
            color: ColorStyles.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  _regions[separatedIndex + 1].letter,
                  style: TextStyles.h2.copyWith(color: Colors.black),
                ),
              ),
            ),
          );
        },
        itemCount: _regions.length,
      ),
    );
  }
}
