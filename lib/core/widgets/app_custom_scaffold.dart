import 'package:baza_gibdd_gai/gen/assets.gen.dart';
import 'package:flutter/material.dart';

class AppCustomScaffold extends StatefulWidget {
  final PreferredSizeWidget appBar;
  final Widget body;
  final Widget? floatingActionButton;
  const AppCustomScaffold(
      {super.key,
      required this.appBar,
      required this.body,
      this.floatingActionButton});

  @override
  State<AppCustomScaffold> createState() => _AppCustomScaffoldState();
}

class _AppCustomScaffoldState extends State<AppCustomScaffold> {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(Assets.images.backgroundImage.path),
                fit: BoxFit.cover)),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: widget.appBar,
          body: widget.body,
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: widget.floatingActionButton,
        ));
  }
}
