import 'dart:async';
import 'package:baza_gibdd_gai/core/constants/constants.dart';
import 'package:baza_gibdd_gai/core/widgets/app_card_layout.dart';
import 'package:baza_gibdd_gai/core/widgets/app_circle_button.dart';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:baza_gibdd_gai/core/theme/app_colors.dart';
import 'package:baza_gibdd_gai/core/theme/app_fonts.dart';
import 'package:baza_gibdd_gai/features/app_banner/app_banner_initial_setup.dart';
import 'package:baza_gibdd_gai/features/app_banner/presentation/app_universal_banner_widget.dart';
import 'package:baza_gibdd_gai/features/chat_with_gpt/presentation/blocs/chat_cubit.dart';
import 'package:baza_gibdd_gai/features/chat_with_gpt/presentation/widgets/chat_appbar_widget.dart';
import 'package:baza_gibdd_gai/features/chat_with_gpt/presentation/widgets/custom_textfield.dart';
import 'package:baza_gibdd_gai/features/chat_with_gpt/presentation/widgets/error_body.dart';
import 'package:baza_gibdd_gai/features/chat_with_gpt/presentation/widgets/message_widget.dart';
import 'package:baza_gibdd_gai/features/chat_with_gpt/utils/chat_worker.dart';
import 'package:baza_gibdd_gai/features/local_notifications/data/models/response_message_model.dart';
import 'package:baza_gibdd_gai/gen/assets.gen.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:shared_preferences/shared_preferences.dart';

@RoutePage()
class HomeChatScreen extends StatefulWidget {
  const HomeChatScreen({super.key});

  @override
  State<HomeChatScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeChatScreen>
    with TickerProviderStateMixin {
  String name = '';
  late TextEditingController textEditingController;
  final ChatCubit _chatCubit = GetIt.I<ChatCubit>();
  final ScrollController _scrollController = ScrollController();
  List<ResponseMessageModel> messages = [];
  late StreamSubscription<bool> keyboardSubscription;
  final prefs = GetIt.I<SharedPreferences>();
  final _formKey = GlobalKey<FormState>();
  var keyboardVisibilityController = KeyboardVisibilityController();
  bool isShowedSearchField = false;

  @override
  void initState() {
    super.initState();
    textEditingController = TextEditingController();
    keyboardSubscription = keyboardVisibilityController.onChange.listen((
      visible,
    ) {
      if (visible) scrollDown();
    });
    messages = ChatWorker.getChatHistory();
    if (messages.isEmpty) _chatCubit.getLastMessage();
    scrollDown();
  }

  Future<void> scrollDown() async {
    await Future.delayed(const Duration(milliseconds: 150));
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        final position = _scrollController.position;
        if (position.maxScrollExtent > 0) {
          _scrollController.animateTo(
            position.maxScrollExtent + kToolbarHeight.h + 20.h,
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeOut,
          );
        }
      }
    });
  }

  String query = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Color(0xffDEF6FF)),
      child: BlocListener<ChatCubit, ChatState>(
        bloc: _chatCubit,
        listener: (context, state) async {
          if (state is ChatLoadingState) {
            scrollDown();
          } else if (state is ChatReadyState) {
            name = state.userDialog.operatorName;
            _chatCubit.getLastMessage();
          } else if (state is ChatGetLastMessageReadyState) {
            messages.addAll(state.messagesResponse.messages);
            if (messages.isEmpty) {
              _chatCubit.sendMessage('Здравствуйте');
            }
            await ChatWorker.saveChatHistory(messages);
            scrollDown();
          }
        },
        child: BlocBuilder<ChatCubit, ChatState>(
          bloc: _chatCubit,
          builder: (context, state) {
            return Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Scaffold(
                  resizeToAvoidBottomInset: true,
                  backgroundColor: Colors.white,
                  body: Column(
                    children: [
                      ChatAppbarWidget(
                        consultantName: prefs.getString('operatorName') ?? name,
                        onChange: (text) => setState(() {
                          query = text;
                        }),
                        onChangeSearchStatus: (isShowed) => setState(() {
                          isShowedSearchField = isShowed;
                        }),
                        isLoading: false,
                      ),
                      AppUniversalBannerWidget(
                        category: 'chat-page-1',
                        banners: bannerList,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 10,
                        ),
                      ),
                      /* if (bannerList.isNotEmpty) SizedBox(height: 10.h), */
                      Expanded(
                        child: state is ChatErrorState
                            ? Center(
                                child: ErrorBody(
                                  text: state.text ?? 'Ошибка!',
                                  iconColor: Colors.white,
                                ),
                              )
                            : _buildMessagesList(state),
                      ),
                    ],
                  ),
                ),
                _buildInputForm(state),
              ],
            );
          },
        ),
      ),
    );
  }

  List<ResponseMessageModel> filteredMessages = [];
  Widget _buildMessagesList(ChatState state) {
    filteredMessages = ChatWorker.filterAndSortMessages(messages, query);
    var groupedMessages = ChatWorker.groupMessagesByDay(filteredMessages);
    if (groupedMessages.isEmpty && query.isNotEmpty) {
      return _buildEmptySearchState();
    }
    if (groupedMessages.isEmpty) {
      return MessageWidget(
        message: ResponseMessageModel.getEmpty(),
        isLoading: true,
      );
    }
    return SafeArea(
      top: false,
      child: ListView.builder(
        controller: _scrollController,
        shrinkWrap: true,
        padding: EdgeInsets.only(
          top: bannerList.isEmpty ? 0 : 20.h,
          bottom: 90.h,
        ),
        itemCount: groupedMessages.length,
        itemBuilder: (context, index) {
          var date = groupedMessages.entries.toList()[index].key;
          var messagesList = groupedMessages.entries.toList()[index].value;
          return Column(
            children: [
              ChatWorker.dateTitle(date),
              SizedBox(height: 16.h),
              for (var i = 0; i < messagesList.length; i++)
                i + 1 == messagesList.length && state is ChatLoadingState
                    ? Column(
                        children: [
                          MessageWidget(message: messagesList[i]),
                          MessageWidget(
                            message: ResponseMessageModel.getEmpty(),
                            isLoading: true,
                          ),
                        ],
                      )
                    : MessageWidget(message: messagesList[i]),
            ],
          );
        },
      ),
    );
  }

  Widget _buildEmptySearchState() {
    return Center(
      child: Text(
        'Ничего не найдено',
        style: TextStyles.h2.copyWith(fontSize: 24.sp, color: Colors.white),
      ),
    );
  }

  Widget _buildInputForm(ChatState state) {
    return Form(
      key: _formKey,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: ColorStyles.primaryBlue,
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        child: SafeArea(
          top: false,
          child: AnimatedCrossFade(
            crossFadeState: isShowedSearchField
                ? CrossFadeState.showFirst
                : CrossFadeState.showSecond,
            duration: standartDuration,
            firstChild: Row(
              children: [
                Flexible(
                  child: AppCardLayout(
                    width: double.infinity,
                    child: Text(
                      'Найдено совпадений: ${query.isEmpty ? '0' : filteredMessages.length}',
                      style: TextStyles.h3,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                AppCircleButton(
                  icon: Assets.icons.navBarIcons.chatNavBarIcon,
                  quarterTurns: 1,
                  onTap: () => {},
                  padding: 13,
                  buttonSize: 46,
                  radius: 16,
                  backgroundColor: ColorStyles.primaryBlue,
                  iconColor: Colors.white,
                ),
                const SizedBox(width: 16),
                AppCircleButton(
                  icon: Assets.icons.navBarIcons.chatNavBarIcon,
                  quarterTurns: 3,
                  onTap: () => {},
                  padding: 13,
                  buttonSize: 46,
                  radius: 16,
                  backgroundColor: ColorStyles.primaryBlue,
                  iconColor: Colors.white,
                ),
              ],
            ),
            secondChild: Row(
              children: [
                Flexible(
                  child: CustomTextField(
                    padding: const EdgeInsets.all(16),
                    controller: textEditingController,
                    keyboardType: TextInputType.name,
                    onFieldSubmitteed: (message) =>
                        onFieldSubmitted(message, state),
                    validator: (value) => value?.isEmpty ?? true
                        ? '*поле не может быть пустым'
                        : null,
                    fillColor: Colors.white,
                    hintText: 'Сообщение...',
                  ),
                ),
                const SizedBox(width: 10),
                AppCircleButton(
                  onTap: () =>
                      onFieldSubmitted(textEditingController.text, state),
                  buttonSize: 46,
                  backgroundColor: ColorStyles.primaryBlue,
                  padding: 10,
                  icon: Assets.icons.navBarIcons.chatNavBarIcon,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> onFieldSubmitted(String message, Object? state) async {
    if (state is ChatLoadingState) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.black38,
          content: Text('Дождитесь ответа оператора.'),
        ),
      );
    } else if (_formKey.currentState!.validate()) {
      textEditingController.clear();
      messages.add(
        ResponseMessageModel(
          isUserMessage: true,
          message: message,
          buttons: [],
          messageId: '',
          time: DateTime.now().toUtc().millisecondsSinceEpoch,
        ),
      );
      _chatCubit.sendMessage(message);
      await ChatWorker.saveChatHistory(messages);
    }
  }
}
