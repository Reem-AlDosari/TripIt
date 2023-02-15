// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trip_record.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<TripRecord> _$tripRecordSerializer = new _$TripRecordSerializer();

class _$TripRecordSerializer implements StructuredSerializer<TripRecord> {
  @override
  final Iterable<Type> types = const [TripRecord, _$TripRecord];
  @override
  final String wireName = 'TripRecord';

  @override
  Iterable<Object> serialize(Serializers serializers, TripRecord object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[];
    Object value;
    value = object.line;
    if (value != null) {
      result
        ..add('Line')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.price;
    if (value != null) {
      result
        ..add('Price')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.reference;
    if (value != null) {
      result
        ..add('Document__Reference__Field')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(
                DocumentReference, const [const FullType(Object)])));
    }
    return result;
  }

  @override
  TripRecord deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new TripRecordBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object value = iterator.current;
      switch (key) {
        case 'Line':
          result.line = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'Price':
          result.price = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'Document__Reference__Field':
          result.reference = serializers.deserialize(value,
                  specifiedType: const FullType(
                      DocumentReference, const [const FullType(Object)]))
              as DocumentReference<Object>;
          break;
      }
    }

    return result.build();
  }
}

class _$TripRecord extends TripRecord {
  @override
  final String line;
  @override
  final String price;
  @override
  final DocumentReference<Object> reference;

  factory _$TripRecord([void Function(TripRecordBuilder) updates]) =>
      (new TripRecordBuilder()..update(updates)).build();

  _$TripRecord._({this.line, this.price, this.reference}) : super._();

  @override
  TripRecord rebuild(void Function(TripRecordBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  TripRecordBuilder toBuilder() => new TripRecordBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TripRecord &&
        line == other.line &&
        price == other.price &&
        reference == other.reference;
  }

  @override
  int get hashCode {
    return $jf(
        $jc($jc($jc(0, line.hashCode), price.hashCode), reference.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('TripRecord')
          ..add('line', line)
          ..add('price', price)
          ..add('reference', reference))
        .toString();
  }
}

class TripRecordBuilder implements Builder<TripRecord, TripRecordBuilder> {
  _$TripRecord _$v;

  String _line;
  String get line => _$this._line;
  set line(String line) => _$this._line = line;

  String _price;
  String get price => _$this._price;
  set price(String price) => _$this._price = price;

  DocumentReference<Object> _reference;
  DocumentReference<Object> get reference => _$this._reference;
  set reference(DocumentReference<Object> reference) =>
      _$this._reference = reference;

  TripRecordBuilder() {
    TripRecord._initializeBuilder(this);
  }

  TripRecordBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _line = $v.line;
      _price = $v.price;
      _reference = $v.reference;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TripRecord other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$TripRecord;
  }

  @override
  void update(void Function(TripRecordBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$TripRecord build() {
    final _$result = _$v ??
        new _$TripRecord._(line: line, price: price, reference: reference);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
