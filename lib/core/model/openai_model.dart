// To parse this JSON data, do
//
//     final openaiModel = openaiModelFromJson(jsonString);

import 'dart:convert';

OpenaiModel openaiModelFromJson(String str) => OpenaiModel.fromJson(json.decode(str));

String openaiModelToJson(OpenaiModel data) => json.encode(data.toJson());

class OpenaiModel {
  String? model;
  String? createdAt;
  String? response;
  bool? done;
  String? doneReason;
  List<int>? context;
  int? totalDuration;
  int? loadDuration;
  int? promptEvalCount;
  int? promptEvalDuration;
  int? evalCount;
  int? evalDuration;

  OpenaiModel({
    this.model,
    this.createdAt,
    this.response,
    this.done,
    this.doneReason,
    this.context,
    this.totalDuration,
    this.loadDuration,
    this.promptEvalCount,
    this.promptEvalDuration,
    this.evalCount,
    this.evalDuration,
  });

  OpenaiModel copyWith({
    String? model,
    String? createdAt,
    String? response,
    bool? done,
    String? doneReason,
    List<int>? context,
    int? totalDuration,
    int? loadDuration,
    int? promptEvalCount,
    int? promptEvalDuration,
    int? evalCount,
    int? evalDuration,
  }) =>
      OpenaiModel(
        model: model ?? this.model,
        createdAt: createdAt ?? this.createdAt,
        response: response ?? this.response,
        done: done ?? this.done,
        doneReason: doneReason ?? this.doneReason,
        context: context ?? this.context,
        totalDuration: totalDuration ?? this.totalDuration,
        loadDuration: loadDuration ?? this.loadDuration,
        promptEvalCount: promptEvalCount ?? this.promptEvalCount,
        promptEvalDuration: promptEvalDuration ?? this.promptEvalDuration,
        evalCount: evalCount ?? this.evalCount,
        evalDuration: evalDuration ?? this.evalDuration,
      );

  factory OpenaiModel.fromJson(Map<String, dynamic> json) => OpenaiModel(
    model: json["model"],
    createdAt: json["created_at"],
    response: json["response"],
    done: json["done"],
    doneReason: json["done_reason"],
    context: json["context"] == null ? [] : List<int>.from(json["context"]!.map((x) => x)),
    totalDuration: json["total_duration"],
    loadDuration: json["load_duration"],
    promptEvalCount: json["prompt_eval_count"],
    promptEvalDuration: json["prompt_eval_duration"],
    evalCount: json["eval_count"],
    evalDuration: json["eval_duration"],
  );

  Map<String, dynamic> toJson() => {
    "model": model,
    "created_at": createdAt,
    "response": response,
    "done": done,
    "done_reason": doneReason,
    "context": context == null ? [] : List<dynamic>.from(context!.map((x) => x)),
    "total_duration": totalDuration,
    "load_duration": loadDuration,
    "prompt_eval_count": promptEvalCount,
    "prompt_eval_duration": promptEvalDuration,
    "eval_count": evalCount,
    "eval_duration": evalDuration,
  };
}


OpenrouterModel openrouterModelFromJson(String str) => OpenrouterModel.fromJson(json.decode(str));

String openrouterModelToJson(OpenrouterModel data) => json.encode(data.toJson());

class OpenrouterModel {
  String? id;
  String? provider;
  String? model;
  String? object;
  int? created;
  List<Choice>? choices;
  dynamic systemFingerprint;
  Usage? usage;

  OpenrouterModel({
    this.id,
    this.provider,
    this.model,
    this.object,
    this.created,
    this.choices,
    this.systemFingerprint,
    this.usage,
  });

  OpenrouterModel copyWith({
    String? id,
    String? provider,
    String? model,
    String? object,
    int? created,
    List<Choice>? choices,
    dynamic systemFingerprint,
    Usage? usage,
  }) =>
      OpenrouterModel(
        id: id ?? this.id,
        provider: provider ?? this.provider,
        model: model ?? this.model,
        object: object ?? this.object,
        created: created ?? this.created,
        choices: choices ?? this.choices,
        systemFingerprint: systemFingerprint ?? this.systemFingerprint,
        usage: usage ?? this.usage,
      );

  factory OpenrouterModel.fromJson(Map<String, dynamic> json) => OpenrouterModel(
    id: json["id"],
    provider: json["provider"],
    model: json["model"],
    object: json["object"],
    created: json["created"],
    choices: json["choices"] == null ? [] : List<Choice>.from(json["choices"]!.map((x) => Choice.fromJson(x))),
    systemFingerprint: json["system_fingerprint"],
    usage: json["usage"] == null ? null : Usage.fromJson(json["usage"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "provider": provider,
    "model": model,
    "object": object,
    "created": created,
    "choices": choices == null ? [] : List<dynamic>.from(choices!.map((x) => x.toJson())),
    "system_fingerprint": systemFingerprint,
    "usage": usage?.toJson(),
  };
}

class Choice {
  dynamic logprobs;
  String? finishReason;
  String? nativeFinishReason;
  String? text;
  dynamic reasoning;

  Choice({
    this.logprobs,
    this.finishReason,
    this.nativeFinishReason,
    this.text,
    this.reasoning,
  });

  Choice copyWith({
    dynamic logprobs,
    String? finishReason,
    String? nativeFinishReason,
    String? text,
    dynamic reasoning,
  }) =>
      Choice(
        logprobs: logprobs ?? this.logprobs,
        finishReason: finishReason ?? this.finishReason,
        nativeFinishReason: nativeFinishReason ?? this.nativeFinishReason,
        text: text ?? this.text,
        reasoning: reasoning ?? this.reasoning,
      );

  factory Choice.fromJson(Map<String, dynamic> json) => Choice(
    logprobs: json["logprobs"],
    finishReason: json["finish_reason"],
    nativeFinishReason: json["native_finish_reason"],
    text: json["text"],
    reasoning: json["reasoning"],
  );

  Map<String, dynamic> toJson() => {
    "logprobs": logprobs,
    "finish_reason": finishReason,
    "native_finish_reason": nativeFinishReason,
    "text": text,
    "reasoning": reasoning,
  };
}

class Usage {
  int? promptTokens;
  int? completionTokens;
  int? totalTokens;
  PromptTokensDetails? promptTokensDetails;
  CompletionTokensDetails? completionTokensDetails;

  Usage({
    this.promptTokens,
    this.completionTokens,
    this.totalTokens,
    this.promptTokensDetails,
    this.completionTokensDetails,
  });

  Usage copyWith({
    int? promptTokens,
    int? completionTokens,
    int? totalTokens,
    PromptTokensDetails? promptTokensDetails,
    CompletionTokensDetails? completionTokensDetails,
  }) =>
      Usage(
        promptTokens: promptTokens ?? this.promptTokens,
        completionTokens: completionTokens ?? this.completionTokens,
        totalTokens: totalTokens ?? this.totalTokens,
        promptTokensDetails: promptTokensDetails ?? this.promptTokensDetails,
        completionTokensDetails: completionTokensDetails ?? this.completionTokensDetails,
      );

  factory Usage.fromJson(Map<String, dynamic> json) => Usage(
    promptTokens: json["prompt_tokens"],
    completionTokens: json["completion_tokens"],
    totalTokens: json["total_tokens"],
    promptTokensDetails: json["prompt_tokens_details"] == null ? null : PromptTokensDetails.fromJson(json["prompt_tokens_details"]),
    completionTokensDetails: json["completion_tokens_details"] == null ? null : CompletionTokensDetails.fromJson(json["completion_tokens_details"]),
  );

  Map<String, dynamic> toJson() => {
    "prompt_tokens": promptTokens,
    "completion_tokens": completionTokens,
    "total_tokens": totalTokens,
    "prompt_tokens_details": promptTokensDetails?.toJson(),
    "completion_tokens_details": completionTokensDetails?.toJson(),
  };
}

class CompletionTokensDetails {
  int? reasoningTokens;

  CompletionTokensDetails({
    this.reasoningTokens,
  });

  CompletionTokensDetails copyWith({
    int? reasoningTokens,
  }) =>
      CompletionTokensDetails(
        reasoningTokens: reasoningTokens ?? this.reasoningTokens,
      );

  factory CompletionTokensDetails.fromJson(Map<String, dynamic> json) => CompletionTokensDetails(
    reasoningTokens: json["reasoning_tokens"],
  );

  Map<String, dynamic> toJson() => {
    "reasoning_tokens": reasoningTokens,
  };
}

class PromptTokensDetails {
  int? cachedTokens;

  PromptTokensDetails({
    this.cachedTokens,
  });

  PromptTokensDetails copyWith({
    int? cachedTokens,
  }) =>
      PromptTokensDetails(
        cachedTokens: cachedTokens ?? this.cachedTokens,
      );

  factory PromptTokensDetails.fromJson(Map<String, dynamic> json) => PromptTokensDetails(
    cachedTokens: json["cached_tokens"],
  );

  Map<String, dynamic> toJson() => {
    "cached_tokens": cachedTokens,
  };
}

