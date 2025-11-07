import 'package:baza_gibdd_gai/core/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:baza_gibdd_gai/core/theme/app_colors.dart';
import 'package:baza_gibdd_gai/core/theme/app_fonts.dart';
import 'package:baza_gibdd_gai/gen/assets.gen.dart';

class ChatAppbarWidget extends StatefulWidget implements PreferredSizeWidget {
  final String consultantName;
  final double height;
  final bool isLoading;
  final Function(String text) onChange;
  final Function(bool isShowedSearchField) onChangeSearchStatus;
  const ChatAppbarWidget({
    super.key,
    required this.consultantName,
    required this.isLoading,
    this.height = kToolbarHeight,
    required this.onChange,
    required this.onChangeSearchStatus,
  });

  @override
  Size get preferredSize => Size.fromHeight(height.h);
  @override
  State<ChatAppbarWidget> createState() => _ChatAppbarWidgetState();
}

class _ChatAppbarWidgetState extends State<ChatAppbarWidget>
    with TickerProviderStateMixin {
  bool isShowedSearchField = false;
  late AnimationController _controller;
  late AnimationController _controller2;
  late Animation<Offset> _animation2;
  @override
  void initState() {
    super.initState();
    // Инициализация контроллера анимации
    _controller = AnimationController(
      vsync: this,
      duration: standartDuration, // длительность анимации
    );

    _controller2 = AnimationController(
      vsync: this,
      duration: standartDuration, // длительность анимации
    );

    // Задаем смещение для анимации
    _animation2 = Tween<Offset>(
      begin: Offset.zero, // Начало: с правой стороны
      end: const Offset(-1.0, 0.0), // Конец: на месте
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut, // Используем плавную кривую для анимации
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _controller2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ColorStyles.white,
        image: DecorationImage(
          image: AssetImage(Assets.images.backgroundImage.path),
          fit: BoxFit.cover,
        ),
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(20)),
        border: const Border(bottom: BorderSide(color: Colors.white10)),
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
          child: /*  isShowedSearchField ? searchChild() : */ mainChild(),
        ),
      ),
    );
  }

  SlideTransition mainChild() => SlideTransition(
        position: _animation2,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Assets.images.mockConsultantAvatar
                    .image(width: 44.w, height: 44.w),
                SizedBox(width: 16.w),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Анастасия',
                      style: TextStyles.h2.copyWith(color: Colors.white),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      'Персональный ассистент',
                      style: TextStyles.h2.copyWith(
                        fontSize: 15.sp,
                        color: Colors.white.withValues(alpha: 0.7),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            /*  Row(
              children: [
                AppCircleButton(
                  icon: Assets.icons.search,
                  buttonSize: 40,
                  backgroundColor: Colors.white24,
                  iconColor: Colors.white,
                  onTap: () => setState(() {
                    isShowedSearchField = true;
                    _controller.forward();
                    _controller2.reverse();
                    widget.onChangeSearchStatus(isShowedSearchField);
                  }),
                  radius: 16,
                ),
                const SizedBox(width: 14),
                AppCircleButton(
                  icon: Assets.icons.starFilled,
                  onTap: () => context.router.navigate(const FavouritesRoute()),
                  buttonSize: 40,
                  radius: 16,
                  backgroundColor: Colors.white24,
                  iconColor: Colors.white,
                ),
              ],
            ), */
          ],
        ),
      );

/*   SlideTransition searchChild() => SlideTransition(
        position: _animation,
        child: Row(
          children: [
            Flexible(
              child: CustomTextField(
                hintText: 'Поиск по чату...',
                onChanged: widget.onChange,
                keyboardType: TextInputType.text,
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
                suffixIcon: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  child: Assets.icons.search.svg(
                    colorFilter: const ColorFilter.mode(
                      Colors.black26,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            AppCircleButton(
              icon: Assets.icons.close,
              onTap: () => setState(() {
                isShowedSearchField = false;
                _controller.reverse(); // Запускаем анимацию для скрытия поля
                _controller2.forward();
                widget.onChange('');
                widget.onChangeSearchStatus(isShowedSearchField);
              }),
              buttonSize: 40,
              radius: 16,
              padding: 11,
              backgroundColor: Colors.white24,
              iconColor: Colors.white,
            ),
          ],
        ),
      ); */
}
