// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'loader_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$LoaderEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadingON,
    required TResult Function() loadingOFF,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadingON,
    TResult? Function()? loadingOFF,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadingON,
    TResult Function()? loadingOFF,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadingOpen value) loadingON,
    required TResult Function(LoadingClose value) loadingOFF,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadingOpen value)? loadingON,
    TResult? Function(LoadingClose value)? loadingOFF,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadingOpen value)? loadingON,
    TResult Function(LoadingClose value)? loadingOFF,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LoaderEventCopyWith<$Res> {
  factory $LoaderEventCopyWith(
    LoaderEvent value,
    $Res Function(LoaderEvent) then,
  ) = _$LoaderEventCopyWithImpl<$Res, LoaderEvent>;
}

/// @nodoc
class _$LoaderEventCopyWithImpl<$Res, $Val extends LoaderEvent>
    implements $LoaderEventCopyWith<$Res> {
  _$LoaderEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LoaderEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$LoadingOpenImplCopyWith<$Res> {
  factory _$$LoadingOpenImplCopyWith(
    _$LoadingOpenImpl value,
    $Res Function(_$LoadingOpenImpl) then,
  ) = __$$LoadingOpenImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadingOpenImplCopyWithImpl<$Res>
    extends _$LoaderEventCopyWithImpl<$Res, _$LoadingOpenImpl>
    implements _$$LoadingOpenImplCopyWith<$Res> {
  __$$LoadingOpenImplCopyWithImpl(
    _$LoadingOpenImpl _value,
    $Res Function(_$LoadingOpenImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of LoaderEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadingOpenImpl implements LoadingOpen {
  const _$LoadingOpenImpl();

  @override
  String toString() {
    return 'LoaderEvent.loadingON()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoadingOpenImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadingON,
    required TResult Function() loadingOFF,
  }) {
    return loadingON();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadingON,
    TResult? Function()? loadingOFF,
  }) {
    return loadingON?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadingON,
    TResult Function()? loadingOFF,
    required TResult orElse(),
  }) {
    if (loadingON != null) {
      return loadingON();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadingOpen value) loadingON,
    required TResult Function(LoadingClose value) loadingOFF,
  }) {
    return loadingON(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadingOpen value)? loadingON,
    TResult? Function(LoadingClose value)? loadingOFF,
  }) {
    return loadingON?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadingOpen value)? loadingON,
    TResult Function(LoadingClose value)? loadingOFF,
    required TResult orElse(),
  }) {
    if (loadingON != null) {
      return loadingON(this);
    }
    return orElse();
  }
}

abstract class LoadingOpen implements LoaderEvent {
  const factory LoadingOpen() = _$LoadingOpenImpl;
}

/// @nodoc
abstract class _$$LoadingCloseImplCopyWith<$Res> {
  factory _$$LoadingCloseImplCopyWith(
    _$LoadingCloseImpl value,
    $Res Function(_$LoadingCloseImpl) then,
  ) = __$$LoadingCloseImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadingCloseImplCopyWithImpl<$Res>
    extends _$LoaderEventCopyWithImpl<$Res, _$LoadingCloseImpl>
    implements _$$LoadingCloseImplCopyWith<$Res> {
  __$$LoadingCloseImplCopyWithImpl(
    _$LoadingCloseImpl _value,
    $Res Function(_$LoadingCloseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of LoaderEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadingCloseImpl implements LoadingClose {
  const _$LoadingCloseImpl();

  @override
  String toString() {
    return 'LoaderEvent.loadingOFF()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoadingCloseImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadingON,
    required TResult Function() loadingOFF,
  }) {
    return loadingOFF();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadingON,
    TResult? Function()? loadingOFF,
  }) {
    return loadingOFF?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadingON,
    TResult Function()? loadingOFF,
    required TResult orElse(),
  }) {
    if (loadingOFF != null) {
      return loadingOFF();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadingOpen value) loadingON,
    required TResult Function(LoadingClose value) loadingOFF,
  }) {
    return loadingOFF(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadingOpen value)? loadingON,
    TResult? Function(LoadingClose value)? loadingOFF,
  }) {
    return loadingOFF?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadingOpen value)? loadingON,
    TResult Function(LoadingClose value)? loadingOFF,
    required TResult orElse(),
  }) {
    if (loadingOFF != null) {
      return loadingOFF(this);
    }
    return orElse();
  }
}

abstract class LoadingClose implements LoaderEvent {
  const factory LoadingClose() = _$LoadingCloseImpl;
}

/// @nodoc
mixin _$LoaderState {
  int get count => throw _privateConstructorUsedError;

  /// Create a copy of LoaderState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LoaderStateCopyWith<LoaderState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LoaderStateCopyWith<$Res> {
  factory $LoaderStateCopyWith(
    LoaderState value,
    $Res Function(LoaderState) then,
  ) = _$LoaderStateCopyWithImpl<$Res, LoaderState>;
  @useResult
  $Res call({int count});
}

/// @nodoc
class _$LoaderStateCopyWithImpl<$Res, $Val extends LoaderState>
    implements $LoaderStateCopyWith<$Res> {
  _$LoaderStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LoaderState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? count = null}) {
    return _then(
      _value.copyWith(
            count:
                null == count
                    ? _value.count
                    : count // ignore: cast_nullable_to_non_nullable
                        as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$LoaderStateImplCopyWith<$Res>
    implements $LoaderStateCopyWith<$Res> {
  factory _$$LoaderStateImplCopyWith(
    _$LoaderStateImpl value,
    $Res Function(_$LoaderStateImpl) then,
  ) = __$$LoaderStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int count});
}

/// @nodoc
class __$$LoaderStateImplCopyWithImpl<$Res>
    extends _$LoaderStateCopyWithImpl<$Res, _$LoaderStateImpl>
    implements _$$LoaderStateImplCopyWith<$Res> {
  __$$LoaderStateImplCopyWithImpl(
    _$LoaderStateImpl _value,
    $Res Function(_$LoaderStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of LoaderState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? count = null}) {
    return _then(
      _$LoaderStateImpl(
        count:
            null == count
                ? _value.count
                : count // ignore: cast_nullable_to_non_nullable
                    as int,
      ),
    );
  }
}

/// @nodoc

class _$LoaderStateImpl implements _LoaderState {
  const _$LoaderStateImpl({this.count = 0});

  @override
  @JsonKey()
  final int count;

  @override
  String toString() {
    return 'LoaderState(count: $count)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoaderStateImpl &&
            (identical(other.count, count) || other.count == count));
  }

  @override
  int get hashCode => Object.hash(runtimeType, count);

  /// Create a copy of LoaderState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoaderStateImplCopyWith<_$LoaderStateImpl> get copyWith =>
      __$$LoaderStateImplCopyWithImpl<_$LoaderStateImpl>(this, _$identity);
}

abstract class _LoaderState implements LoaderState {
  const factory _LoaderState({final int count}) = _$LoaderStateImpl;

  @override
  int get count;

  /// Create a copy of LoaderState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoaderStateImplCopyWith<_$LoaderStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
