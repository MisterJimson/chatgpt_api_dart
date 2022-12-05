import 'dart:convert';

import 'package:chatgpt_api_dart/src/models.dart';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';

const defaultUserAgent =
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/107.0.0.0 Safari/537.36';

class GptChatApi {
  /// Auth session token. Get from `__Secure-next-auth.session-token` cookie in browser.
  String sessionToken;

  /// Base URL for chat site api
  String? apiBaseUrl;

  /// Base URL for chat backend
  String backendApiBaseUrl;

  /// User agent to use for requests
  String userAgent;

  // Stores access tokens for up to 10 seconds before needing to refresh
  final _ExpiryMap<String, String> _accessTokenCache =
      _ExpiryMap<String, String>();

  GptChatApi({
    required this.sessionToken,
    this.apiBaseUrl = 'https://chat.openai.com/api',
    this.backendApiBaseUrl = 'https://chat.openai.com/backend-api',
    this.userAgent = defaultUserAgent,
  });

  Future<String> sendMessage(String message) async {
    final accessToken = await _refreshAccessToken();
    final conversationId = const Uuid().v4();

    final body = ConversationJSONBody(
      action: 'next',
      conversationId: null,
      messages: [
        Prompt(
          content: PromptContent(contentType: 'text', parts: [message]),
          id: Uuid().v4(),
          role: 'user',
        )
      ],
      model: 'text-davinci-002-render',
      parentMessageId: conversationId,
    ).toJson();

    final url = '$backendApiBaseUrl/conversation';

    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer ${accessToken}',
        'Content-Type': 'application/json',
        'user-agent': userAgent,
      },
      body: jsonEncode(body),
    );

    String longestLine =
        response.body.split('\n').reduce((a, b) => a.length > b.length ? a : b);

    var result = longestLine.replaceFirst('data: ', '');

    var resultJson = jsonDecode(result);

    var messageResult = ConversationResponseEvent.fromJson(resultJson);

    var lastResult = messageResult.message?.content.parts.first;

    if (lastResult == null) {
      throw Exception('No response from OpenAI');
    } else {
      return lastResult;
    }
  }

  Future<String> _refreshAccessToken() async {
    final cachedAccessToken = this._accessTokenCache['KEY_ACCESS_TOKEN'];
    if (cachedAccessToken != null) {
      return cachedAccessToken;
    }

    try {
      final res =
          await http.get(Uri.parse('$apiBaseUrl/auth/session'), headers: {
        'cookie': '__Secure-next-auth.session-token=$sessionToken',
        'user-agent': userAgent,
      });

      if (res.statusCode != 200) {
        throw Exception('Failed to refresh access token');
      }

      final accessToken = jsonDecode(res.body)['accessToken'];

      if (accessToken == null) {
        throw Exception(
            'Failed to refresh access token, token in response is null');
      }

      _accessTokenCache['KEY_ACCESS_TOKEN'] = accessToken;
      return accessToken;
    } catch (err) {
      throw Exception('ChatGPT failed to refresh auth token: $err');
    }
  }
}

class _ExpiryMap<K, V> {
  final Map<K, V> _map = {};

  V? operator [](K key) => _map[key];

  void operator []=(K key, V value) {
    _map[key] = value;
    Future.delayed(const Duration(seconds: 10), () => _map.remove(key));
  }
}
