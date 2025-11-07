import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:baza_gibdd_gai/core/theme/app_colors.dart';
import 'package:baza_gibdd_gai/core/theme/app_fonts.dart';
import 'package:baza_gibdd_gai/core/utils/ui_util.dart';
import 'package:baza_gibdd_gai/core/widgets/app_card_layout.dart';
import 'package:baza_gibdd_gai/features/app_banner/presentation/app_web_view.dart';
import 'package:baza_gibdd_gai/features/payments/data/models/invoice.dart';
import 'package:baza_gibdd_gai/features/payments/data/models/to_pay_element.dart';
import 'package:baza_gibdd_gai/features/payments/presentation/widgets/custom_button.dart';
import 'package:baza_gibdd_gai/gen/assets.gen.dart';
import 'package:url_launcher/url_launcher.dart';

class InvoiceCard extends StatelessWidget {
  final Invoice invoice;
  final VoidCallback onDelete;

  const InvoiceCard({
    super.key,
    required this.invoice,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 16.w,
      ),
      child: Container(
        width: double.maxFinite,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: invoice.isDone ? null : Border.all(color: ColorStyles.orange),
          boxShadow: [
            BoxShadow(
              blurRadius: 10,
              spreadRadius: 1,
              offset: const Offset(0, 4),
              color: Colors.black.withOpacity(0.15),
            ),
          ],
          color: Colors.white,
        ),
        padding: EdgeInsets.symmetric(vertical: 23.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 20.w, right: 20.w),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Сумма задолженности:',
                          style: TextStyles.h5.copyWith(
                              color: Colors.black.withValues(alpha: 0.5)),
                        ),
                        Text(
                          UiUtil.prepareSum(invoice.totalToPay),
                          style: TextStyle(
                            fontFamily: 'Circie',
                            fontSize: 24.sp,
                            fontWeight: FontWeight.w700,
                            color: ColorStyles.orange,
                          ),
                        ),
                      ]),
                  Spacer(),
                  SizedBox(width: 10.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 8.w, vertical: 9.h),
                        decoration: BoxDecoration(
                          color: invoice.isDone
                              ? ColorStyles.green
                              : ColorStyles.invoiceStatusRed,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            invoice.statusText,
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: invoice.isDone
                                  ? ColorStyles.black
                                  : ColorStyles.white,
                              fontSize: 12.sp,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  /* const Spacer(),
                  InkWell(onTap: onDelete, child: Assets.icons.bellIcon.svg()) */
                ],
              ),
            ),
            SizedBox(height: 10.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child:
                  _getToPayElementsInfoWidget(invoice.toPayElements, context),
            ),
            SizedBox(height: 15.h),
            if (invoice.paymentReceiptUrl != null &&
                invoice.paymentReceiptUrl!.isNotEmpty)
              _getPaymentReceiptButton(context),
            if (invoice.paymentUrl != null && invoice.paymentUrl!.isNotEmpty)
              _getPaymentUrlButton(context),
          ],
        ),
      ),
    );
  }

  Widget _getToPayElementsInfoWidget(
      List<ToPayElement> toPayElements, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(
        toPayElements.length,
        (index) => AppCardLayout(
          color: ColorStyles.fillColor,
          width: double.infinity,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Assets.icons.navBarIcons.chatNavBarIcon.svg(),
              SizedBox(width: 12.w),
              Flexible(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    toPayElements[index].purpose,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                      color: ColorStyles.primaryBlue,
                    ),
                  ),
                  Text(
                    DateFormat('dd.MM.yyyy, HH:mm').format(invoice.dateTime),
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 14.sp,
                      color: ColorStyles.green,
                    ),
                  ),
                  /*  Text(
                    UiUtil.prepareSum(toPayElements[index].amount),
                    style: TextStyle(
                      fontFamily: 'Circie',
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w700,
                      color: ColorStyles.invoiceStatusRed,
                    ),
                  ), */
                  if (index != (toPayElements.length - 1))
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.h),
                      child: Container(
                        height: 1.h,
                        width: double.maxFinite,
                        color: ColorStyles.black,
                      ),
                    ),
                ],
              )),
            ],
          ),
        ),
      ),
    );
  }

  Widget _getPaymentReceiptButton(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: CustomButton(
        height: 45.h,
        title: 'Посмотреть квитанцию',
        color: ColorStyles.blue.withValues(alpha: 0.1),
        titleColor: ColorStyles.blue,
        onTap: () async {
          if (invoice.isPaymentReceiptIframe) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    AppWebView(url: invoice.paymentReceiptUrl!),
              ),
            );
          } else {
            launchUrl(
              Uri.parse(invoice.paymentReceiptUrl!),
              mode: LaunchMode.externalApplication,
            );
          }
        },
      ),
    );
  }

  Widget _getPaymentUrlButton(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: CustomButton(
        color: ColorStyles.blue,
        title: 'Оплатить',
        onTap: () {
          launchUrl(
            Uri.parse(invoice.paymentUrl!),
            mode: LaunchMode.externalApplication,
          );
        },
      ),
    );
  }
}
