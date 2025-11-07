import 'package:baza_gibdd_gai/core/widgets/custom_app_bar.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:baza_gibdd_gai/core/theme/app_colors.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../main.dart';

@RoutePage(name: 'AppWebViewPage')
class AppWebView extends StatefulWidget {
  const AppWebView({
    super.key,
    this.url = '',
    this.title = '',
    this.isNeedBackButton = true,
    this.appBar,
  });
  final bool isNeedBackButton;
  final String url;
  final String title;
  final PreferredSizeWidget? appBar;
  @override
  State<AppWebView> createState() => _AppWebViewState();
}

class _AppWebViewState extends State<AppWebView> {
  bool _isLoading = true;
  final _key = UniqueKey();
  late WebViewController controller;
  @override
  initState() {
    controller = WebViewController()
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
      resizeToAvoidBottomInset: true,
      appBar: widget.appBar ??
          CustomAppBar.getAppBar(
            title: widget.title,
            isNeedImage: true,
            onTapBackButton: () => context.maybePop(),
          ),
      backgroundColor: ColorStyles.white,
      body: Stack(
        children: [
          WebViewWidget(key: _key, controller: controller),
          _isLoading
              ? const Center(
                  child: CircularProgressIndicator(color: ColorStyles.black),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
