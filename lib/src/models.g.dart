// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConversationJSONBody _$ConversationJSONBodyFromJson(
        Map<String, dynamic> json) =>
    ConversationJSONBody(
      action: json['action'] as String?,
      conversationId: json['conversation_id'] as String?,
      messages: (json['messages'] as List<dynamic>?)
          ?.map((e) => Prompt.fromJson(e as Map<String, dynamic>))
          .toList(),
      model: json['model'] as String,
      parentMessageId: json['parent_message_id'] as String,
    );

Map<String, dynamic> _$ConversationJSONBodyToJson(
        ConversationJSONBody instance) =>
    <String, dynamic>{
      'action': instance.action,
      'conversation_id': instance.conversationId,
      'messages': instance.messages,
      'model': instance.model,
      'parent_message_id': instance.parentMessageId,
    };

Prompt _$PromptFromJson(Map<String, dynamic> json) => Prompt(
      content: PromptContent.fromJson(json['content'] as Map<String, dynamic>),
      id: json['id'] as String,
      role: json['role'] as String,
    );

Map<String, dynamic> _$PromptToJson(Prompt instance) => <String, dynamic>{
      'content': instance.content,
      'id': instance.id,
      'role': instance.role,
    };

PromptContent _$PromptContentFromJson(Map<String, dynamic> json) =>
    PromptContent(
      contentType: json['content_type'] as String,
      parts: (json['parts'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$PromptContentToJson(PromptContent instance) =>
    <String, dynamic>{
      'content_type': instance.contentType,
      'parts': instance.parts,
    };

ConversationResponseEvent _$ConversationResponseEventFromJson(
        Map<String, dynamic> json) =>
    ConversationResponseEvent(
      message: json['message'] == null
          ? null
          : Message.fromJson(json['message'] as Map<String, dynamic>),
      conversationId: json['conversation_id'] as String,
      error: json['error'] as String?,
    );

Map<String, dynamic> _$ConversationResponseEventToJson(
        ConversationResponseEvent instance) =>
    <String, dynamic>{
      'message': instance.message,
      'conversation_id': instance.conversationId,
      'error': instance.error,
    };

Message _$MessageFromJson(Map<String, dynamic> json) => Message(
      id: json['id'] as String,
      content: MessageContent.fromJson(json['content'] as Map<String, dynamic>),
      role: json['role'] as String,
      user: json['user'] as String?,
      weight: (json['weight'] as num).toDouble(),
      recipient: json['recipient'] as String,
    );

Map<String, dynamic> _$MessageToJson(Message instance) => <String, dynamic>{
      'id': instance.id,
      'content': instance.content,
      'role': instance.role,
      'user': instance.user,
      'weight': instance.weight,
      'recipient': instance.recipient,
    };

MessageContent _$MessageContentFromJson(Map<String, dynamic> json) =>
    MessageContent(
      contentType: json['content_type'] as String,
      parts: (json['parts'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$MessageContentToJson(MessageContent instance) =>
    <String, dynamic>{
      'content_type': instance.contentType,
      'parts': instance.parts,
    };
