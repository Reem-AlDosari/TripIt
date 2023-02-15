// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Rating_record.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<RatingRecord> _$ratingRecordSerializer = new _$RatingRecordSerializer();

class _$RatingRecordSerializer implements StructuredSerializer<RatingRecord> {
  @override
  final Iterable<Type> types = const [RatingRecord, _$RatingRecord];
  @override
  final String wireName = 'RatingRecord';

  @override
  Iterable<Object> serialize(Serializers serializers, RatingRecord object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[];
    Object value;
    value = object.commnet;
    if (value != null) {
      result
        ..add('Commnet')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.reference;
    if (value != null) {
      result
        ..add('Document_Reference_Field')
        ..add(serializers3.serialize(value,
            specifiedType: const FullType(
                DocumentReference, const [const FullType(Object)])));
    }
    return result;
  }

  @override
 RatingRecord deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new RatingRecordBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object value = iterator.current;
         switch (key) {
        case 'Commnet':
          result.commnet = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'Document_Reference_Field':
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
class _$RatingRecord extends RatingRecord {
   @override
  final String commnet;
  @override
  final DocumentReference<Object> reference;
  

  factory _$RatingRecord([void Function(RatingRecordBuilder) updates]) =>
      (new RatingRecordBuilder()..update(updates)).build();

   _$RatingRecord._({this.commnet, this.reference}) : super._();

  @override
 RatingRecord rebuild(void Function(RatingRecordBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  RatingRecordBuilder toBuilder() => new RatingRecordBuilder()..replace(this);
 @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is RatingRecord &&
        commnet == other.commnet &&
        reference == other.reference;
  }

 @override
  int get hashCode {
    return $jf($jc($jc(0, commnet.hashCode), reference.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('RatingRecord')
          ..add('commnet', commnet)
          ..add('reference', reference))
        .toString();
  }
}

class RatingRecordBuilder
    implements Builder<RatingRecord, RatingRecordBuilder> {
  _$RatingRecord _$v;

  String _commnet;
  String get commnet => _$this._commnet;
  set commnet(String commnet) => _$this._commnet = commnet;

  DocumentReference<Object> _reference;
  DocumentReference<Object> get reference => _$this._reference;
  set reference(DocumentReference<Object> reference) =>
      _$this._reference = reference;

  RatingRecordBuilder() {
    RatingRecord._initializeBuilder(this);
  }

  RatingRecordBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _commnet = $v.commnet;
      _reference = $v.reference;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(RatingRecord other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$RatingRecord;
  }

  @override
  void update(void Function(RatingRecordBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$RatingRecord build() {
    final _$result =
        _$v ?? new _$RatingRecord._(commnet: commnet, reference: reference);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new