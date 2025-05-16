// ignore: file_names
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class ReplyAI extends Equatable {
  final String reply;
  final String emotion;
  final bool risk;
  final String? zkModerationProof;

  const ReplyAI({
    required this.reply,
    required this.emotion,
    required this.risk,
    this.zkModerationProof,
  });

  @override
  List<Object> get props => [reply, emotion, risk];

  factory ReplyAI.fromJson(Map<String, dynamic> json) {
    return ReplyAI(
      reply: json['reply'] as String,
      emotion: json['emotion'] as String,
      risk: json['risk'] as bool,
      zkModerationProof: json['zk_moderation_proof'],
    );
  }

  static ReplyAI copyWith({
    required String reply,
    required String emotion,
    required bool risk,
    String? zkModerationProof,
  }) {
    return ReplyAI(
      reply: reply,
      emotion: emotion,
      risk: risk,
      zkModerationProof: zkModerationProof,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'reply': reply,
      'emotion': emotion,
      'risk': risk,
      'zkModerationProof': zkModerationProof,
    };
  }

  @override
  String toString() {
    return 'ReplyAI('
        'reply: $reply, '
        'emotion: $emotion, '
        'risk: $risk, '
        'zkModerationProof: $zkModerationProof'
        ')';
  }
}
