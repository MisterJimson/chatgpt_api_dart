import 'package:json_annotation/json_annotation.dart';

part 'models.g.dart';

enum ContentType {
  text,
}

enum Role {
  user,
  assistant,
}

class SessionResult {
  final User user;
  final String expires;
  final String accessToken;

  SessionResult({
    required this.user,
    required this.expires,
    required this.accessToken,
  });
}

class User {
  final String id;
  final String name;
  final String email;
  final String image;
  final String picture;
  final List<String> groups;
  final List<String> features;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.image,
    required this.picture,
    required this.groups,
    required this.features,
  });
}

class ModelsResult {
  final List<Model> models;

  ModelsResult({
    required this.models,
  });
}

class Model {
  final String slug;
  final int maxTokens;
  final bool isSpecial;

  Model({
    required this.slug,
    required this.maxTokens,
    required this.isSpecial,
  });
}

class ModerationsJSONBody {
  final String input;
  final AvailableModerationModels model;

  ModerationsJSONBody({
    required this.input,
    required this.model,
  });
}

enum AvailableModerationModels {
  textModerationPlayground,
}

class ModerationsJSONResult {
  final bool flagged;
  final bool blocked;
  final String moderationId;

  ModerationsJSONResult({
    required this.flagged,
    required this.blocked,
    required this.moderationId,
  });
}

@JsonSerializable()
class ConversationJSONBody {
  final String? action;
  @JsonKey(name: 'conversation_id')
  final String? conversationId;
  final List<Prompt>? messages;
  final String model;
  @JsonKey(name: 'parent_message_id')
  final String parentMessageId;

  ConversationJSONBody({
    required this.action,
    required this.conversationId,
    required this.messages,
    required this.model,
    required this.parentMessageId,
  });

  factory ConversationJSONBody.fromJson(Map<String, dynamic> json) =>
      _$ConversationJSONBodyFromJson(json);

  Map<String, dynamic> toJson() => _$ConversationJSONBodyToJson(this);
}

@JsonSerializable()
class Prompt {
  final PromptContent content;
  final String id;
  final String role;

  Prompt({
    required this.content,
    required this.id,
    required this.role,
  });

  factory Prompt.fromJson(Map<String, dynamic> json) => _$PromptFromJson(json);

  Map<String, dynamic> toJson() => _$PromptToJson(this);
}

@JsonSerializable()
class PromptContent {
  @JsonKey(name: 'content_type')
  final String contentType;
  final List<String> parts;

  PromptContent({
    required this.contentType,
    required this.parts,
  });

  factory PromptContent.fromJson(Map<String, dynamic> json) =>
      _$PromptContentFromJson(json);

  Map<String, dynamic> toJson() => _$PromptContentToJson(this);
}

class MessageFeedbackJSONBody {
  final String conversationId;
  final String messageId;
  final MessageFeedbackRating rating;
  final List<MessageFeedbackTags>? tags;
  final String? text;

  MessageFeedbackJSONBody({
    required this.conversationId,
    required this.messageId,
    required this.rating,
    required this.tags,
    required this.text,
  });
}

enum MessageFeedbackTags {
  harmful,
  falseValue, // false is a reserved word
  notHelpful,
}

class MessageFeedbackResult {
  final String messageId;
  final String conversationId;
  final String userId;
  final MessageFeedbackRating rating;
  final String? text;

  MessageFeedbackResult({
    required this.messageId,
    required this.conversationId,
    required this.userId,
    required this.rating,
    required this.text,
  });
}

enum MessageFeedbackRating {
  thumbsUp,
  thumbsDown,
}

@JsonSerializable()
class ConversationResponseEvent {
  final Message? message;
  @JsonKey(name: 'conversation_id')
  final String? conversationId;
  final String? error;

  ConversationResponseEvent({
    required this.message,
    required this.conversationId,
    required this.error,
  });

  factory ConversationResponseEvent.fromJson(Map<String, dynamic> json) =>
      _$ConversationResponseEventFromJson(json);

  Map<String, dynamic> toJson() => _$ConversationResponseEventToJson(this);
}

@JsonSerializable()
class Message {
  final String id;
  final MessageContent content;
  final String role;
  final String? user;
  //final dynamic endTurn;
  final double weight;
  final String recipient;
  //final dynamic metadata;

  Message({
    required this.id,
    required this.content,
    required this.role,
    required this.user,
    required this.weight,
    required this.recipient,
  });

  factory Message.fromJson(Map<String, dynamic> json) =>
      _$MessageFromJson(json);

  Map<String, dynamic> toJson() => _$MessageToJson(this);
}

@JsonSerializable()
class MessageContent {
  @JsonKey(name: 'content_type')
  final String contentType;
  final List<String> parts;

  MessageContent({required this.contentType, required this.parts});

  factory MessageContent.fromJson(Map<String, dynamic> json) =>
      _$MessageContentFromJson(json);

  Map<String, dynamic> toJson() => _$MessageContentToJson(this);
}
