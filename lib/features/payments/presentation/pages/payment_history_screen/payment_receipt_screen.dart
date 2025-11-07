/* import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:baza_gibdd_gai/core/theme/app_colors.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PaymentReceiptScreen extends StatefulWidget {
  final String url;

  const PaymentReceiptScreen({
    Key? key,
    required this.url,
  }) : super(key: key);

  @override
  State<PaymentReceiptScreen> createState() => _PaymentReceiptScreenState();
}

class _PaymentReceiptScreenState extends State<PaymentReceiptScreen> {
  bool _isLoading = true;
  final _key = UniqueKey();
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  @override
  void initState() {
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            shadowColor: Colors.black.withOpacity(0.03),
            leading: Builder(
              builder: (context) => InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(
                  CupertinoIcons.left_chevron,
                  color: ColorStyles.primaryBlue,
                  size: 24,
                ),
              ),
            ),
            title: Text(
              'Квитанция',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w700,
                  color: ColorStyles.primaryBlue,
                  height: 1),
            ),
            centerTitle: true,
          ),
          body: Stack(
            children: [
              WebView(
                key: _key,
                initialUrl: widget.url,
                javascriptMode: JavascriptMode.unrestricted,
                onWebViewCreated: (WebViewController webViewController) {
                  _controller.complete(webViewController);
                },
                onPageFinished: (_) {
                  setState(() {
                    _isLoading = false;
                  });
                },
                onPageStarted: (_) {},
                navigationDelegate: (request) async {
                  final host = Uri.parse(widget.url).host;
                  if (request.url.contains(host)) {
                    return NavigationDecision.navigate;
                  } else {
                    await launch(request.url.toString());
                    return NavigationDecision.prevent;
                  }
                },
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
 */
