// ignore: file_names
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class Badge extends Equatable {
  final int id;
  final String text;
  final String descHash;
  final String siblings;
  final String pathIndices;

  const Badge({
    required this.id,
    required this.text,
    required this.descHash,
    required this.siblings,
    required this.pathIndices,
  });

  @override
  List<Object> get props => [id, text, descHash, siblings, pathIndices];

  factory Badge.fromJson(Map<String, dynamic> json) {
    return Badge(
      id: json['id'] as int,
      text: json['name'] as String,
      descHash: json['descHash'] as String,
      siblings: json['siblings'] as String,
      pathIndices: json['pathIndices'] as String,
    );
  }

  static Badge copyWith({
    required int id,
    required String text,
    required String iaAnswer,
    required String descHash,
    required String siblings,
    required String pathIndices,
  }) {
    return Badge(
      id: id,
      text: text,
      descHash: descHash,
      siblings: siblings,
      pathIndices: pathIndices,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'text': text,
      'descHash': descHash,
      'siblings': siblings,
      'pathIndices': pathIndices,
    };
  }

  @override
  String toString() {
    return 'Badge('
        'id: $id, '
        'text: $text, '
        'descHash: $descHash, '
        'siblings: $siblings, '
        'pathIndices: $pathIndices'
        ')';
  }
}
