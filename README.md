# ChatGPT API Dart
Dart client for the unofficial ChatGPT API

Ported from https://github.com/transitive-bullshit/chatgpt-api

## Intro

This package is a Dart wrapper around [ChatGPT](https://openai.com/blog/chatgpt) by [OpenAI](https://openai.com).

You can use it to start building projects powered by ChatGPT like chatbots, websites, etc...

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