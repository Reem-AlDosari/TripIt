import 'dart:async';

import 'index.dart';
import 'serializers.dart';
import 'package:built_value/built_value.dart';

part 'passenger_record.g.dart';

abstract class PassengerRecord
    implements Built<PassengerRecord, PassengerRecordBuilder> {
  static Serializer<PassengerRecord> get serializer =>
      _$passengerRecordSerializer;

  @nullable
  String get email;

  @nullable
  String get password;

  @nullable
  int get phone;

  @nullable
  String get username;

  @nullable
  @BuiltValueField(wireName: 'display_name')
  String get displayName;

  @nullable
  String get uid;

  @nullable
  @BuiltValueField(wireName: 'created_time')
  DateTime get createdTime;

  @nullable
  @BuiltValueField(wireName: 'photo_url')
  String get photoUrl;

  @nullable
  @BuiltValueField(wireName: 'phone_number')
  String get phoneNumber;

  @nullable
  @BuiltValueField(wireName: 'Gender')
  String get gender;

  @nullable
  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference get reference;

  static void _initializeBuilder(PassengerRecordBuilder builder) => builder
    ..email = ''
    ..password = ''
    ..phone = 0
    ..username = ''
    ..displayName = ''
    ..uid = ''
    ..photoUrl = ''
    ..phoneNumber = ''
    ..gender = '';

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('Passenger');

  static Stream<PassengerRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s)));

  PassengerRecord._();
  factory PassengerRecord([void Function(PassengerRecordBuilder) updates]) =
      _$PassengerRecord;

  static PassengerRecord getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(
          serializer, {...data, kDocumentReferenceField: reference});
}

Map<String, dynamic> createPassengerRecordData({
  String email,
  String password,
  int phone,
  String username,
  String displayName,
  String uid,
  DateTime createdTime,
  String photoUrl,
  String phoneNumber,
  String gender,
}) =>
    serializers.toFirestore(
        PassengerRecord.serializer,
        PassengerRecord((p) => p
          ..email = email
          ..password = password
          ..phone = phone
          ..username = username
          ..displayName = displayName
          ..uid = uid
          ..createdTime = createdTime
          ..photoUrl = photoUrl
          ..phoneNumber = phoneNumber
          ..gender = gender));
