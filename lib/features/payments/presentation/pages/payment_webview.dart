import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:baza_gibdd_gai/core/network/api_path.dart';
import 'package:baza_gibdd_gai/core/widgets/custom_app_bar.dart';
import 'package:baza_gibdd_gai/features/payments/presentation/blocs/payment_history_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentWebview extends StatefulWidget {
  final String? yin;
  final String? url;

  const PaymentWebview({
    super.key,
    this.yin,
    this.url,
  });

  @override
  State<PaymentWebview> createState() => _PaymentWebviewState();
}

class _PaymentWebviewState extends State<PaymentWebview> {
  bool _isLoading = true;
  final _key = UniqueKey();

  late PaymentHistoryBloc _paymentHistoryBloc;
  late WebViewController controller;
  @override
  initState() {
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..addJavaScriptChannel('AppMessage', onMessageReceived: (message) async {
        final invoiceId = message.message;
        _paymentHistoryBloc.add(PaymentHistoryBlocSaveEvent(invoiceId));
      })
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) => setState(() {
            _isLoading = false;
          }),
          onHttpError: (HttpResponseError error) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) async {
            final host = widget.url != null
                ? Uri.parse(widget.url!).host
                : Uri.parse(ApiPath.paymentScreenUrl(widget.yin!)).host;
            if (request.url.contains(host)) {
              return NavigationDecision.navigate;
            } else {
              await launchUrl(Uri.parse(request.url.toString()));
              return NavigationDecision.prevent;
            }
          },
        ),
      )
      ..loadRequest(widget.url != null
          ? Uri.parse(widget.url!)
          : Uri.parse(ApiPath.paymentScreenUrl(widget.yin!)));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Scaffold(
        appBar: CustomAppBar.getAppBar(
          title: 'Оплата',
          onTapBackButton: () => context.maybePop(),
        ),
        body: SafeArea(
          child: Stack(
            children: [
              WebViewWidget(
                key: _key,
                controller: controller,
              ),
              _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : const Stack()
            ],
          ),
        ),
      ),
    );
  }
}
