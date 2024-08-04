// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'token_metadata.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$TokenPartialInfo {
  bool get isFrom => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  DateTime? get date => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $TokenPartialInfoCopyWith<TokenPartialInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TokenPartialInfoCopyWith<$Res> {
  factory $TokenPartialInfoCopyWith(
          TokenPartialInfo value, $Res Function(TokenPartialInfo) then) =
      _$TokenPartialInfoCopyWithImpl<$Res, TokenPartialInfo>;
  @useResult
  $Res call({bool isFrom, String? name, DateTime? date, String? message});
}

/// @nodoc
class _$TokenPartialInfoCopyWithImpl<$Res, $Val extends TokenPartialInfo>
    implements $TokenPartialInfoCopyWith<$Res> {
  _$TokenPartialInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isFrom = null,
    Object? name = freezed,
    Object? date = freezed,
    Object? message = freezed,
  }) {
    return _then(_value.copyWith(
      isFrom: null == isFrom
          ? _value.isFrom
          : isFrom // ignore: cast_nullable_to_non_nullable
              as bool,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      date: freezed == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TokenPartialInfoImplCopyWith<$Res>
    implements $TokenPartialInfoCopyWith<$Res> {
  factory _$$TokenPartialInfoImplCopyWith(_$TokenPartialInfoImpl value,
          $Res Function(_$TokenPartialInfoImpl) then) =
      __$$TokenPartialInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool isFrom, String? name, DateTime? date, String? message});
}

/// @nodoc
class __$$TokenPartialInfoImplCopyWithImpl<$Res>
    extends _$TokenPartialInfoCopyWithImpl<$Res, _$TokenPartialInfoImpl>
    implements _$$TokenPartialInfoImplCopyWith<$Res> {
  __$$TokenPartialInfoImplCopyWithImpl(_$TokenPartialInfoImpl _value,
      $Res Function(_$TokenPartialInfoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isFrom = null,
    Object? name = freezed,
    Object? date = freezed,
    Object? message = freezed,
  }) {
    return _then(_$TokenPartialInfoImpl(
      isFrom: null == isFrom
          ? _value.isFrom
          : isFrom // ignore: cast_nullable_to_non_nullable
              as bool,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      date: freezed == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$TokenPartialInfoImpl extends _TokenPartialInfo {
  const _$TokenPartialInfoImpl(
      {required this.isFrom, this.name, this.date, this.message})
      : super._();

  @override
  final bool isFrom;
  @override
  final String? name;
  @override
  final DateTime? date;
  @override
  final String? message;

  @override
  String toString() {
    return 'TokenPartialInfo(isFrom: $isFrom, name: $name, date: $date, message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TokenPartialInfoImpl &&
            (identical(other.isFrom, isFrom) || other.isFrom == isFrom) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isFrom, name, date, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TokenPartialInfoImplCopyWith<_$TokenPartialInfoImpl> get copyWith =>
      __$$TokenPartialInfoImplCopyWithImpl<_$TokenPartialInfoImpl>(
          this, _$identity);
}

abstract class _TokenPartialInfo extends TokenPartialInfo {
  const factory _TokenPartialInfo(
      {required final bool isFrom,
      final String? name,
      final DateTime? date,
      final String? message}) = _$TokenPartialInfoImpl;
  const _TokenPartialInfo._() : super._();

  @override
  bool get isFrom;
  @override
  String? get name;
  @override
  DateTime? get date;
  @override
  String? get message;
  @override
  @JsonKey(ignore: true)
  _$$TokenPartialInfoImplCopyWith<_$TokenPartialInfoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
