// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'passenger_record.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<PassengerRecord> _$passengerRecordSerializer =
    new _$PassengerRecordSerializer();

class _$PassengerRecordSerializer
    implements StructuredSerializer<PassengerRecord> {
  @override
  final Iterable<Type> types = const [PassengerRecord, _$PassengerRecord];
  @override
  final String wireName = 'PassengerRecord';

  @override
  Iterable<Object> serialize(Serializers serializers, PassengerRecord object,
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
    value = object.password;
    if (value != null) {
      result
        ..add('password')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.phone;
    if (value != null) {
      result
        ..add('phone')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.username;
    if (value != null) {
      result
        ..add('username')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.displayName;
    if (value != null) {
      result
        ..add('display_name')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.uid;
    if (value != null) {
      result
        ..add('uid')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.createdTime;
    if (value != null) {
      result
        ..add('created_time')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(DateTime)));
    }
    value = object.photoUrl;
    if (value != null) {
      result
        ..add('photo_url')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.phoneNumber;
    if (value != null) {
      result
        ..add('phone_number')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.gender;
    if (value != null) {
      result
        ..add('Gender')
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
  PassengerRecord deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new PassengerRecordBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object value = iterator.current;
      switch (key) {
        case 'email':
          result.email = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'password':
          result.password = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'phone':
          result.phone = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'username':
          result.username = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'display_name':
          result.displayName = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'uid':
          result.uid = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'created_time':
          result.createdTime = serializers.deserialize(value,
              specifiedType: const FullType(DateTime)) as DateTime;
          break;
        case 'photo_url':
          result.photoUrl = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'phone_number':
          result.phoneNumber = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'Gender':
          result.gender = serializers.deserialize(value,
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

class _$PassengerRecord extends PassengerRecord {
  @override
  final String email;
  @override
  final String password;
  @override
  final int phone;
  @override
  final String username;
  @override
  final String displayName;
  @override
  final String uid;
  @override
  final DateTime createdTime;
  @override
  final String photoUrl;
  @override
  final String phoneNumber;
  @override
  final String gender;
  @override
  final DocumentReference<Object> reference;

  factory _$PassengerRecord([void Function(PassengerRecordBuilder) updates]) =>
      (new PassengerRecordBuilder()..update(updates)).build();

  _$PassengerRecord._(
      {this.email,
      this.password,
      this.phone,
      this.username,
      this.displayName,
      this.uid,
      this.createdTime,
      this.photoUrl,
      this.phoneNumber,
      this.gender,
      this.reference})
      : super._();

  @override
  PassengerRecord rebuild(void Function(PassengerRecordBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  PassengerRecordBuilder toBuilder() =>
      new PassengerRecordBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PassengerRecord &&
        email == other.email &&
        password == other.password &&
        phone == other.phone &&
        username == other.username &&
        displayName == other.displayName &&
        uid == other.uid &&
        createdTime == other.createdTime &&
        photoUrl == other.photoUrl &&
        phoneNumber == other.phoneNumber &&
        gender == other.gender &&
        reference == other.reference;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc(
                        $jc(
                            $jc(
                                $jc(
                                    $jc(
                                        $jc($jc(0, email.hashCode),
                                            password.hashCode),
                                        phone.hashCode),
                                    username.hashCode),
                                displayName.hashCode),
                            uid.hashCode),
                        createdTime.hashCode),
                    photoUrl.hashCode),
                phoneNumber.hashCode),
            gender.hashCode),
        reference.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('PassengerRecord')
          ..add('email', email)
          ..add('password', password)
          ..add('phone', phone)
          ..add('username', username)
          ..add('displayName', displayName)
          ..add('uid', uid)
          ..add('createdTime', createdTime)
          ..add('photoUrl', photoUrl)
          ..add('phoneNumber', phoneNumber)
          ..add('gender', gender)
          ..add('reference', reference))
        .toString();
  }
}

class PassengerRecordBuilder
    implements Builder<PassengerRecord, PassengerRecordBuilder> {
  _$PassengerRecord _$v;

  String _email;
  String get email => _$this._email;
  set email(String email) => _$this._email = email;

  String _password;
  String get password => _$this._password;
  set password(String password) => _$this._password = password;

  int _phone;
  int get phone => _$this._phone;
  set phone(int phone) => _$this._phone = phone;

  String _username;
  String get username => _$this._username;
  set username(String username) => _$this._username = username;

  String _displayName;
  String get displayName => _$this._displayName;
  set displayName(String displayName) => _$this._displayName = displayName;

  String _uid;
  String get uid => _$this._uid;
  set uid(String uid) => _$this._uid = uid;

  DateTime _createdTime;
  DateTime get createdTime => _$this._createdTime;
  set createdTime(DateTime createdTime) => _$this._createdTime = createdTime;

  String _photoUrl;
  String get photoUrl => _$this._photoUrl;
  set photoUrl(String photoUrl) => _$this._photoUrl = photoUrl;

  String _phoneNumber;
  String get phoneNumber => _$this._phoneNumber;
  set phoneNumber(String phoneNumber) => _$this._phoneNumber = phoneNumber;

  String _gender;
  String get gender => _$this._gender;
  set gender(String gender) => _$this._gender = gender;

  DocumentReference<Object> _reference;
  DocumentReference<Object> get reference => _$this._reference;
  set reference(DocumentReference<Object> reference) =>
      _$this._reference = reference;

  PassengerRecordBuilder() {
    PassengerRecord._initializeBuilder(this);
  }

  PassengerRecordBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _email = $v.email;
      _password = $v.password;
      _phone = $v.phone;
      _username = $v.username;
      _displayName = $v.displayName;
      _uid = $v.uid;
      _createdTime = $v.createdTime;
      _photoUrl = $v.photoUrl;
      _phoneNumber = $v.phoneNumber;
      _gender = $v.gender;
      _reference = $v.reference;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(PassengerRecord other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$PassengerRecord;
  }

  @override
  void update(void Function(PassengerRecordBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$PassengerRecord build() {
    final _$result = _$v ??
        new _$PassengerRecord._(
            email: email,
            password: password,
            phone: phone,
            username: username,
            displayName: displayName,
            uid: uid,
            createdTime: createdTime,
            photoUrl: photoUrl,
            phoneNumber: phoneNumber,
            gender: gender,
            reference: reference);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
