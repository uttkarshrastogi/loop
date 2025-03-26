// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'connectivity_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$ConnectivityEvent {
  bool get isConnected => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(bool isConnected) connectivityChanged,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(bool isConnected)? connectivityChanged,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(bool isConnected)? connectivityChanged,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ConnectivityChanged value) connectivityChanged,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ConnectivityChanged value)? connectivityChanged,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ConnectivityChanged value)? connectivityChanged,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;

  /// Create a copy of ConnectivityEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ConnectivityEventCopyWith<ConnectivityEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ConnectivityEventCopyWith<$Res> {
  factory $ConnectivityEventCopyWith(
    ConnectivityEvent value,
    $Res Function(ConnectivityEvent) then,
  ) = _$ConnectivityEventCopyWithImpl<$Res, ConnectivityEvent>;
  @useResult
  $Res call({bool isConnected});
}

/// @nodoc
class _$ConnectivityEventCopyWithImpl<$Res, $Val extends ConnectivityEvent>
    implements $ConnectivityEventCopyWith<$Res> {
  _$ConnectivityEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ConnectivityEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? isConnected = null}) {
    return _then(
      _value.copyWith(
            isConnected:
                null == isConnected
                    ? _value.isConnected
                    : isConnected // ignore: cast_nullable_to_non_nullable
                        as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ConnectivityChangedImplCopyWith<$Res>
    implements $ConnectivityEventCopyWith<$Res> {
  factory _$$ConnectivityChangedImplCopyWith(
    _$ConnectivityChangedImpl value,
    $Res Function(_$ConnectivityChangedImpl) then,
  ) = __$$ConnectivityChangedImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool isConnected});
}

/// @nodoc
class __$$ConnectivityChangedImplCopyWithImpl<$Res>
    extends _$ConnectivityEventCopyWithImpl<$Res, _$ConnectivityChangedImpl>
    implements _$$ConnectivityChangedImplCopyWith<$Res> {
  __$$ConnectivityChangedImplCopyWithImpl(
    _$ConnectivityChangedImpl _value,
    $Res Function(_$ConnectivityChangedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ConnectivityEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? isConnected = null}) {
    return _then(
      _$ConnectivityChangedImpl(
        isConnected:
            null == isConnected
                ? _value.isConnected
                : isConnected // ignore: cast_nullable_to_non_nullable
                    as bool,
      ),
    );
  }
}

/// @nodoc

class _$ConnectivityChangedImpl implements ConnectivityChanged {
  const _$ConnectivityChangedImpl({required this.isConnected});

  @override
  final bool isConnected;

  @override
  String toString() {
    return 'ConnectivityEvent.connectivityChanged(isConnected: $isConnected)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ConnectivityChangedImpl &&
            (identical(other.isConnected, isConnected) ||
                other.isConnected == isConnected));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isConnected);

  /// Create a copy of ConnectivityEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ConnectivityChangedImplCopyWith<_$ConnectivityChangedImpl> get copyWith =>
      __$$ConnectivityChangedImplCopyWithImpl<_$ConnectivityChangedImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(bool isConnected) connectivityChanged,
  }) {
    return connectivityChanged(isConnected);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(bool isConnected)? connectivityChanged,
  }) {
    return connectivityChanged?.call(isConnected);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(bool isConnected)? connectivityChanged,
    required TResult orElse(),
  }) {
    if (connectivityChanged != null) {
      return connectivityChanged(isConnected);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ConnectivityChanged value) connectivityChanged,
  }) {
    return connectivityChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ConnectivityChanged value)? connectivityChanged,
  }) {
    return connectivityChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ConnectivityChanged value)? connectivityChanged,
    required TResult orElse(),
  }) {
    if (connectivityChanged != null) {
      return connectivityChanged(this);
    }
    return orElse();
  }
}

abstract class ConnectivityChanged implements ConnectivityEvent {
  const factory ConnectivityChanged({required final bool isConnected}) =
      _$ConnectivityChangedImpl;

  @override
  bool get isConnected;

  /// Create a copy of ConnectivityEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ConnectivityChangedImplCopyWith<_$ConnectivityChangedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
