# ChatGPT API Dart
Dart client for the unofficial ChatGPT API

Ported from https://github.com/transitive-bullshit/chatgpt-api

## Intro

This package is a Dart wrapper around [ChatGPT](https://openai.com/blog/chatgpt) by [OpenAI](https://openai.com).

You can use it to start building projects powered by ChatGPT like chatbots, websites, etc...

## Demo

https://user-images.githubusercontent.com/7351329/205991375-d0125d59-6fa4-456d-b4fa-a23c94dc1841.mp4

## How it works

This package requires a valid session token from ChatGPT to access it's unofficial REST API.

To get a session token:

1. Go to https://chat.openai.com/chat and log in or sign up.
2. Open dev tools.
3. Open `Application` > `Cookies`
4. Copy the value for `__Secure-next-auth.session-token` and save it to your environment.

When you create the `GptChatApi` client, pass it this token.

## Status
This project was a very quick port of the node version, it requires testing and changes to make it more robust and useable.

## Development

Create these files and add your session token to run the tests and example respectively:
- `test/session_token.dart`
- `example/lib/session_token.dart`

Should look something like this:
```dart
const SESSION_TOKEN = 'my session token from https://chat.openai.com/chat';
```
