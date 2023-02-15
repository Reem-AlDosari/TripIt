// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'membership_record.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<MembershipRecord> _$membershipRecordSerializer =
    new _$MembershipRecordSerializer();

class _$MembershipRecordSerializer
    implements StructuredSerializer<MembershipRecord> {
  @override
  final Iterable<Type> types = const [MembershipRecord, _$MembershipRecord];
  @override
  final String wireName = 'MembershipRecord';

  @override
  Iterable<Object> serialize(Serializers serializers, MembershipRecord object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[];
    Object value;
    value = object.email;
    if (value != null) {
      result
        ..add('email')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.pay;
    if (value != null) {
      result
        ..add('pay')
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
    value = object.startdate;
    if (value != null) {
      result
        ..add('Startdate')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(DateTime)));
    }
    value = object.type;
    if (value != null) {
      result
        ..add('type')
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
  MembershipRecord deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new MembershipRecordBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object value = iterator.current;
      switch (key) {
        case 'Price':
          result.price = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'email':
          result.email = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'Startdate':
          result.startdate = serializers.deserialize(value,
              specifiedType: const FullType(DateTime)) as DateTime;
          break;
        case 'endDate':
          result.endDate = serializers.deserialize(value,
              specifiedType: const FullType(DateTime)) as DateTime;
          break;
        case 'type':
          result.type = serializers.deserialize(value,
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

class _$MembershipRecord extends MembershipRecord {
  @override
  final String price;
  @override
  final String pay;
  @override
  final String email;
  @override
  final DateTime startdate;
  @override
  final DateTime endDate;
  @override
  final String type;
  @override
  final DocumentReference<Object> reference;

  factory _$MembershipRecord(
          [void Function(MembershipRecordBuilder) updates]) =>
      (new MembershipRecordBuilder()..update(updates)).build();

  _$MembershipRecord._(
      {this.price,
      this.pay,
      this.startdate,
      this.endDate,
      this.type,
      this.reference,
      this.email})
      : super._();

  @override
  MembershipRecord rebuild(void Function(MembershipRecordBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  MembershipRecordBuilder toBuilder() =>
      new MembershipRecordBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is MembershipRecord &&
        price == other.price &&
        email == other.email &&
        pay == other.pay &&
        startdate == other.startdate &&
        endDate == other.endDate &&
        type == other.type &&
        reference == other.reference;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc($jc($jc(0, price.hashCode), startdate.hashCode),
                endDate.hashCode),
            type.hashCode),
        reference.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('MembershipRecord')
          ..add('price', price)
          ..add('pay', pay)
          ..add('email', email)
          ..add('startdate', startdate)
          ..add('endDate', endDate)
          ..add('type', type)
          ..add('reference', reference))
        .toString();
  }
}

class MembershipRecordBuilder
    implements Builder<MembershipRecord, MembershipRecordBuilder> {
  _$MembershipRecord _$v;

  String _price;
  String get price => _$this._price;
  set price(String price) => _$this._price = price;

  String _pay;
  String get pay => _$this._pay;
  set pay(String pay) => _$this._pay = pay;

  DateTime _startdate;
  DateTime get startdate => _$this._startdate;
  set startdate(DateTime startdate) => _$this._startdate = startdate;

  DateTime _endDate;
  DateTime get endDate => _$this._endDate;
  set endDate(DateTime endDate) => _$this._endDate = endDate;

  String _type;
  String get type => _$this._type;
  set type(String type) => _$this._type = type;

  String _email;
  String get email => _$this._email;
  set email(String email) => _$this._email = email;

  DocumentReference<Object> _reference;
  DocumentReference<Object> get reference => _$this._reference;
  set reference(DocumentReference<Object> reference) =>
      _$this._reference = reference;

  MembershipRecordBuilder() {
    MembershipRecord._initializeBuilder(this);
  }

  MembershipRecordBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _price = $v.price;
      _pay = $v.pay;
      _startdate = $v.startdate;
      _endDate = $v.endDate;
      _type = $v.type;
      _email = $v.email;
      _reference = $v.reference;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(MembershipRecord other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$MembershipRecord;
  }

  @override
  void update(void Function(MembershipRecordBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$MembershipRecord build() {
    final _$result = _$v ??
        new _$MembershipRecord._(
            price: price,
            pay: pay,
            email: email,
            startdate: startdate,
            endDate: endDate,
            type: type,
            reference: reference);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
