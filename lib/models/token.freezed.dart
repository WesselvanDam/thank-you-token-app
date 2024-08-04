// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'token.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$Token {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get thumbnailLink => throw _privateConstructorUsedError;
  String? get accessToken => throw _privateConstructorUsedError;
  DateTime get createdTime => throw _privateConstructorUsedError;
  TokenPartialInfo get fromInfo => throw _privateConstructorUsedError;
  TokenPartialInfo get toInfo => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $TokenCopyWith<Token> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TokenCopyWith<$Res> {
  factory $TokenCopyWith(Token value, $Res Function(Token) then) =
      _$TokenCopyWithImpl<$Res, Token>;
  @useResult
  $Res call(
      {String id,
      String name,
      String thumbnailLink,
      String? accessToken,
      DateTime createdTime,
      TokenPartialInfo fromInfo,
      TokenPartialInfo toInfo});

  $TokenPartialInfoCopyWith<$Res> get fromInfo;
  $TokenPartialInfoCopyWith<$Res> get toInfo;
}

/// @nodoc
class _$TokenCopyWithImpl<$Res, $Val extends Token>
    implements $TokenCopyWith<$Res> {
  _$TokenCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? thumbnailLink = null,
    Object? accessToken = freezed,
    Object? createdTime = null,
    Object? fromInfo = null,
    Object? toInfo = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      thumbnailLink: null == thumbnailLink
          ? _value.thumbnailLink
          : thumbnailLink // ignore: cast_nullable_to_non_nullable
              as String,
      accessToken: freezed == accessToken
          ? _value.accessToken
          : accessToken // ignore: cast_nullable_to_non_nullable
              as String?,
      createdTime: null == createdTime
          ? _value.createdTime
          : createdTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      fromInfo: null == fromInfo
          ? _value.fromInfo
          : fromInfo // ignore: cast_nullable_to_non_nullable
              as TokenPartialInfo,
      toInfo: null == toInfo
          ? _value.toInfo
          : toInfo // ignore: cast_nullable_to_non_nullable
              as TokenPartialInfo,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $TokenPartialInfoCopyWith<$Res> get fromInfo {
    return $TokenPartialInfoCopyWith<$Res>(_value.fromInfo, (value) {
      return _then(_value.copyWith(fromInfo: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $TokenPartialInfoCopyWith<$Res> get toInfo {
    return $TokenPartialInfoCopyWith<$Res>(_value.toInfo, (value) {
      return _then(_value.copyWith(toInfo: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$TokenImplCopyWith<$Res> implements $TokenCopyWith<$Res> {
  factory _$$TokenImplCopyWith(
          _$TokenImpl value, $Res Function(_$TokenImpl) then) =
      __$$TokenImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String thumbnailLink,
      String? accessToken,
      DateTime createdTime,
      TokenPartialInfo fromInfo,
      TokenPartialInfo toInfo});

  @override
  $TokenPartialInfoCopyWith<$Res> get fromInfo;
  @override
  $TokenPartialInfoCopyWith<$Res> get toInfo;
}

/// @nodoc
class __$$TokenImplCopyWithImpl<$Res>
    extends _$TokenCopyWithImpl<$Res, _$TokenImpl>
    implements _$$TokenImplCopyWith<$Res> {
  __$$TokenImplCopyWithImpl(
      _$TokenImpl _value, $Res Function(_$TokenImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? thumbnailLink = null,
    Object? accessToken = freezed,
    Object? createdTime = null,
    Object? fromInfo = null,
    Object? toInfo = null,
  }) {
    return _then(_$TokenImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      thumbnailLink: null == thumbnailLink
          ? _value.thumbnailLink
          : thumbnailLink // ignore: cast_nullable_to_non_nullable
              as String,
      accessToken: freezed == accessToken
          ? _value.accessToken
          : accessToken // ignore: cast_nullable_to_non_nullable
              as String?,
      createdTime: null == createdTime
          ? _value.createdTime
          : createdTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      fromInfo: null == fromInfo
          ? _value.fromInfo
          : fromInfo // ignore: cast_nullable_to_non_nullable
              as TokenPartialInfo,
      toInfo: null == toInfo
          ? _value.toInfo
          : toInfo // ignore: cast_nullable_to_non_nullable
              as TokenPartialInfo,
    ));
  }
}

/// @nodoc

class _$TokenImpl extends _Token with DiagnosticableTreeMixin {
  const _$TokenImpl(
      {required this.id,
      required this.name,
      required this.thumbnailLink,
      required this.accessToken,
      required this.createdTime,
      required this.fromInfo,
      required this.toInfo})
      : super._();

  @override
  final String id;
  @override
  final String name;
  @override
  final String thumbnailLink;
  @override
  final String? accessToken;
  @override
  final DateTime createdTime;
  @override
  final TokenPartialInfo fromInfo;
  @override
  final TokenPartialInfo toInfo;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Token(id: $id, name: $name, thumbnailLink: $thumbnailLink, accessToken: $accessToken, createdTime: $createdTime, fromInfo: $fromInfo, toInfo: $toInfo)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Token'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('thumbnailLink', thumbnailLink))
      ..add(DiagnosticsProperty('accessToken', accessToken))
      ..add(DiagnosticsProperty('createdTime', createdTime))
      ..add(DiagnosticsProperty('fromInfo', fromInfo))
      ..add(DiagnosticsProperty('toInfo', toInfo));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TokenImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.thumbnailLink, thumbnailLink) ||
                other.thumbnailLink == thumbnailLink) &&
            (identical(other.accessToken, accessToken) ||
                other.accessToken == accessToken) &&
            (identical(other.createdTime, createdTime) ||
                other.createdTime == createdTime) &&
            (identical(other.fromInfo, fromInfo) ||
                other.fromInfo == fromInfo) &&
            (identical(other.toInfo, toInfo) || other.toInfo == toInfo));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, name, thumbnailLink,
      accessToken, createdTime, fromInfo, toInfo);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TokenImplCopyWith<_$TokenImpl> get copyWith =>
      __$$TokenImplCopyWithImpl<_$TokenImpl>(this, _$identity);
}

abstract class _Token extends Token {
  const factory _Token(
      {required final String id,
      required final String name,
      required final String thumbnailLink,
      required final String? accessToken,
      required final DateTime createdTime,
      required final TokenPartialInfo fromInfo,
      required final TokenPartialInfo toInfo}) = _$TokenImpl;
  const _Token._() : super._();

  @override
  String get id;
  @override
  String get name;
  @override
  String get thumbnailLink;
  @override
  String? get accessToken;
  @override
  DateTime get createdTime;
  @override
  TokenPartialInfo get fromInfo;
  @override
  TokenPartialInfo get toInfo;
  @override
  @JsonKey(ignore: true)
  _$$TokenImplCopyWith<_$TokenImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
