import 'package:chatgpt_api_dart/chatgpt_api_dart.dart';
import 'package:example/models.dart';
import 'package:example/session_token.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'ChatGPT API Dart Example',
      home: ChatPage(),
    );
  }
}

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final _textController = TextEditingController();
  final _scrollController = ScrollController();
  final List<ChatMessage> _messages = [];
  late GptChatApi _api;

  String? _parentMessageId;
  String? _conversationId;

  @override
  void initState() {
    super.initState();
    _api = GptChatApi(sessionToken: SESSION_TOKEN);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ChatGPT API Dart Example')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Expanded(
                child: _buildList(),
              ),
              Row(
                children: [
                  _buildInput(),
                  _buildSubmit(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  IconButton _buildSubmit() {
    return IconButton(
      icon: const Icon(Icons.send),
      onPressed: () async {
        setState(
          () {
            _messages.add(
              ChatMessage(
                text: _textController.text,
                chatMessageType: ChatMessageType.user,
              ),
            );
          },
        );
        // Save the input and clearing the text field.
        var input = _textController.text;
        _textController.clear();

        // Needs a delay or the scroll won't always work.
        Future.delayed(const Duration(milliseconds: 50))
            .then((_) => _scrollDown());

        // Send the message to the API, use conversationId and parentMessageId
        // to keep the thread context.
        var newMessage = await _api.sendMessage(
          input,
          conversationId: _conversationId,
          parentMessageId: _parentMessageId,
        );
        setState(() {
          _conversationId = newMessage.conversationId;
          _parentMessageId = newMessage.messageId;
          _messages.add(
            ChatMessage(
              text: newMessage.message,
              chatMessageType: ChatMessageType.bot,
            ),
          );
        });
        _textController.clear();
      },
    );
  }

  Expanded _buildInput() {
    return Expanded(
      child: TextField(
        textCapitalization: TextCapitalization.sentences,
        controller: _textController,
        decoration: const InputDecoration(
          hintText: 'Enter a message',
        ),
      ),
    );
  }

  ListView _buildList() {
    return ListView.builder(
      controller: _scrollController,
      itemCount: _messages.length,
      itemBuilder: (context, index) {
        var message = _messages[index];
        return ChatMessageWidget(
          text: message.text,
          chatMessageType: message.chatMessageType,
        );
      },
    );
  }

  void _scrollDown() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }
}

class ChatMessageWidget extends StatelessWidget {
  const ChatMessageWidget(
      {super.key, required this.text, required this.chatMessageType});

  final String text;
  final ChatMessageType chatMessageType;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          if (chatMessageType == ChatMessageType.bot)
            Container(
              margin: const EdgeInsets.only(right: 16.0),
              child: const CircleAvatar(
                child: Icon(
                  Icons.computer,
                ),
              ),
            ),
          Expanded(
            child: Column(
              crossAxisAlignment: chatMessageType == ChatMessageType.bot
                  ? CrossAxisAlignment.start
                  : CrossAxisAlignment.end,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: const BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  ),
                  child: Text(
                    text,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        ?.copyWith(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          if (chatMessageType == ChatMessageType.user)
            Container(
              margin: const EdgeInsets.only(left: 16.0),
              child: const CircleAvatar(
                child: Icon(
                  Icons.person,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
