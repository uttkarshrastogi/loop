// To parse this JSON data, do
//
//     final openaiModel = openaiModelFromJson(jsonString);

import 'dart:convert';

OpenaiModel openaiModelFromJson(String str) => OpenaiModel.fromJson(json.decode(str));

String openaiModelToJson(OpenaiModel data) => json.encode(data.toJson());

class OpenaiModel {
  String? id;
  int? created;
  String? model;
  String? object;
  String? systemFingerprint;
  List<Choice>? choices;
  Usage? usage;
  String? serviceTier;

  OpenaiModel({
    this.id,
    this.created,
    this.model,
    this.object,
    this.systemFingerprint,
    this.choices,
    this.usage,
    this.serviceTier,
  });

  OpenaiModel copyWith({
    String? id,
    int? created,
    String? model,
    String? object,
    String? systemFingerprint,
    List<Choice>? choices,
    Usage? usage,
    String? serviceTier,
  }) =>
      OpenaiModel(
        id: id ?? this.id,
        created: created ?? this.created,
        model: model ?? this.model,
        object: object ?? this.object,
        systemFingerprint: systemFingerprint ?? this.systemFingerprint,
        choices: choices ?? this.choices,
        usage: usage ?? this.usage,
        serviceTier: serviceTier ?? this.serviceTier,
      );

  factory OpenaiModel.fromJson(Map<String, dynamic> json) => OpenaiModel(
    id: json["id"],
    created: json["created"],
    model: json["model"],
    object: json["object"],
    systemFingerprint: json["system_fingerprint"],
    choices: json["choices"] == null ? [] : List<Choice>.from(json["choices"]!.map((x) => Choice.fromJson(x))),
    usage: json["usage"] == null ? null : Usage.fromJson(json["usage"]),
    serviceTier: json["service_tier"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "created": created,
    "model": model,
    "object": object,
    "system_fingerprint": systemFingerprint,
    "choices": choices == null ? [] : List<dynamic>.from(choices!.map((x) => x.toJson())),
    "usage": usage?.toJson(),
    "service_tier": serviceTier,
  };
}

class Choice {
  String? finishReason;
  int? index;
  Message? message;

  Choice({
    this.finishReason,
    this.index,
    this.message,
  });

  Choice copyWith({
    String? finishReason,
    int? index,
    Message? message,
  }) =>
      Choice(
        finishReason: finishReason ?? this.finishReason,
        index: index ?? this.index,
        message: message ?? this.message,
      );

  factory Choice.fromJson(Map<String, dynamic> json) => Choice(
    finishReason: json["finish_reason"],
    index: json["index"],
    message: json["message"] == null ? null : Message.fromJson(json["message"]),
  );

  Map<String, dynamic> toJson() => {
    "finish_reason": finishReason,
    "index": index,
    "message": message?.toJson(),
  };
}

class Message {
  String? content;
  String? role;
  dynamic toolCalls;
  dynamic functionCall;

  Message({
    this.content,
    this.role,
    this.toolCalls,
    this.functionCall,
  });

  Message copyWith({
    String? content,
    String? role,
    dynamic toolCalls,
    dynamic functionCall,
  }) =>
      Message(
        content: content ?? this.content,
        role: role ?? this.role,
        toolCalls: toolCalls ?? this.toolCalls,
        functionCall: functionCall ?? this.functionCall,
      );

  factory Message.fromJson(Map<String, dynamic> json) => Message(
    content: json["content"],
    role: json["role"],
    toolCalls: json["tool_calls"],
    functionCall: json["function_call"],
  );

  Map<String, dynamic> toJson() => {
    "content": content,
    "role": role,
    "tool_calls": toolCalls,
    "function_call": functionCall,
  };
}

class Usage {
  int? completionTokens;
  int? promptTokens;
  int? totalTokens;
  CompletionTokensDetails? completionTokensDetails;
  PromptTokensDetails? promptTokensDetails;

  Usage({
    this.completionTokens,
    this.promptTokens,
    this.totalTokens,
    this.completionTokensDetails,
    this.promptTokensDetails,
  });

  Usage copyWith({
    int? completionTokens,
    int? promptTokens,
    int? totalTokens,
    CompletionTokensDetails? completionTokensDetails,
    PromptTokensDetails? promptTokensDetails,
  }) =>
      Usage(
        completionTokens: completionTokens ?? this.completionTokens,
        promptTokens: promptTokens ?? this.promptTokens,
        totalTokens: totalTokens ?? this.totalTokens,
        completionTokensDetails: completionTokensDetails ?? this.completionTokensDetails,
        promptTokensDetails: promptTokensDetails ?? this.promptTokensDetails,
      );

  factory Usage.fromJson(Map<String, dynamic> json) => Usage(
    completionTokens: json["completion_tokens"],
    promptTokens: json["prompt_tokens"],
    totalTokens: json["total_tokens"],
    completionTokensDetails: json["completion_tokens_details"] == null ? null : CompletionTokensDetails.fromJson(json["completion_tokens_details"]),
    promptTokensDetails: json["prompt_tokens_details"] == null ? null : PromptTokensDetails.fromJson(json["prompt_tokens_details"]),
  );

  Map<String, dynamic> toJson() => {
    "completion_tokens": completionTokens,
    "prompt_tokens": promptTokens,
    "total_tokens": totalTokens,
    "completion_tokens_details": completionTokensDetails?.toJson(),
    "prompt_tokens_details": promptTokensDetails?.toJson(),
  };
}

class CompletionTokensDetails {
  int? acceptedPredictionTokens;
  int? audioTokens;
  int? reasoningTokens;
  int? rejectedPredictionTokens;

  CompletionTokensDetails({
    this.acceptedPredictionTokens,
    this.audioTokens,
    this.reasoningTokens,
    this.rejectedPredictionTokens,
  });

  CompletionTokensDetails copyWith({
    int? acceptedPredictionTokens,
    int? audioTokens,
    int? reasoningTokens,
    int? rejectedPredictionTokens,
  }) =>
      CompletionTokensDetails(
        acceptedPredictionTokens: acceptedPredictionTokens ?? this.acceptedPredictionTokens,
        audioTokens: audioTokens ?? this.audioTokens,
        reasoningTokens: reasoningTokens ?? this.reasoningTokens,
        rejectedPredictionTokens: rejectedPredictionTokens ?? this.rejectedPredictionTokens,
      );

  factory CompletionTokensDetails.fromJson(Map<String, dynamic> json) => CompletionTokensDetails(
    acceptedPredictionTokens: json["accepted_prediction_tokens"],
    audioTokens: json["audio_tokens"],
    reasoningTokens: json["reasoning_tokens"],
    rejectedPredictionTokens: json["rejected_prediction_tokens"],
  );

  Map<String, dynamic> toJson() => {
    "accepted_prediction_tokens": acceptedPredictionTokens,
    "audio_tokens": audioTokens,
    "reasoning_tokens": reasoningTokens,
    "rejected_prediction_tokens": rejectedPredictionTokens,
  };
}

class PromptTokensDetails {
  int? audioTokens;
  int? cachedTokens;

  PromptTokensDetails({
    this.audioTokens,
    this.cachedTokens,
  });

  PromptTokensDetails copyWith({
    int? audioTokens,
    int? cachedTokens,
  }) =>
      PromptTokensDetails(
        audioTokens: audioTokens ?? this.audioTokens,
        cachedTokens: cachedTokens ?? this.cachedTokens,
      );

  factory PromptTokensDetails.fromJson(Map<String, dynamic> json) => PromptTokensDetails(
    audioTokens: json["audio_tokens"],
    cachedTokens: json["cached_tokens"],
  );

  Map<String, dynamic> toJson() => {
    "audio_tokens": audioTokens,
    "cached_tokens": cachedTokens,
  };
}
