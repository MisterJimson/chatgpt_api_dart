import 'package:chatgpt_api_dart/src/chat_api.dart';
import 'package:test/test.dart';

/// Provide your own session token to run tests
import 'session_token.dart';

// ignore: invalid_annotation_target
@Timeout(Duration(seconds: 45))
void main() {
  test('do basic prompt', () async {
    final api = GptChatApi(sessionToken: SESSION_TOKEN);
    const prompt =
        'Write a python version of bubble sort. Do not include example usage.';

    var result = await api.sendMessage(prompt);

    print(result);
  });
}
