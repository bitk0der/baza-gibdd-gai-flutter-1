import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:baza_gibdd_gai/core/theme/app_colors.dart';
import 'package:baza_gibdd_gai/main.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentWebview extends StatefulWidget {
  final String url;

  const PaymentWebview({
    Key? key,
    required this.url,
  }) : super(key: key);

  @override
  _PaymentWebviewState createState() => _PaymentWebviewState();
}

class _PaymentWebviewState extends State<PaymentWebview> {
  bool _isLoading = true;
  final _key = UniqueKey();

  late WebViewController _controller;
  @override
  initState() {
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
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
            final host = Uri.parse(widget.url).host;
            if (request.url.contains(host)) {
              return NavigationDecision.navigate;
            } else {
              await launchUrl(
                Uri.parse(request.url.replaceAll('USER_ID', globalUserId)),
                mode: LaunchMode.externalApplication,
              );
              return NavigationDecision.prevent;
            }
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        shadowColor: Colors.black.withOpacity(0.05),
        leading: Builder(
          builder: (context) => InkWell(
            onTap: () => Navigator.pop(context),
            child: Icon(
              CupertinoIcons.left_chevron,
              color: ColorStyles.black,
              size: 24,
            ),
          ),
        ),
        title: Text(
          'Перевод',
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.w700,
            color: ColorStyles.black,
          ),
        ),
        centerTitle: true,
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height - 85.h,
        child: Stack(
          children: [
            WebViewWidget(
              key: _key,
              controller: _controller,
            ),
            _isLoading
                ? const Center(
                    child: CircularProgressIndicator(
                      color: ColorStyles.green,
                    ),
                  )
                : Stack()
          ],
        ),
      ),
    );
  }
}
