import 'package:auto_route/annotations.dart';
import 'package:baza_gibdd_gai/core/widgets/custom_app_bar.dart';
import 'package:baza_gibdd_gai/features/chat_with_gpt/presentation/widgets/favourite_message_widget.dart';
import 'package:baza_gibdd_gai/features/chat_with_gpt/utils/chat_worker.dart';
import 'package:baza_gibdd_gai/features/local_notifications/data/models/response_message_model.dart';
import 'package:flutter/material.dart';

@RoutePage()
class FavouritesPage extends StatefulWidget {
  const FavouritesPage({super.key});

  @override
  State<FavouritesPage> createState() => _FavouritesPageState();
}

class _FavouritesPageState extends State<FavouritesPage> {
  List<ResponseMessageModel> messages = [];
  @override
  void initState() {
    messages = ChatWorker.getFavouritesMessages();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar.getDefaultAppBar('Сохраненные сообщения', context),
      body: ListView.builder(
        itemCount: messages.length,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 21),
        shrinkWrap: true,
        itemBuilder: (context, index) =>
            FavouriteMessageWidget(message: messages[index]),
      ),
    );
  }
}
