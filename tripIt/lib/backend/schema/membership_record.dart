import 'dart:async';

import 'package:built_value/built_value.dart';

import 'index.dart';
import 'serializers2.dart';

part 'membership_record.g.dart';

abstract class MembershipRecord
    implements Built<MembershipRecord, MembershipRecordBuilder> {
  static Serializer<MembershipRecord> get serializer =>
      _$membershipRecordSerializer;

  String get email;
  String get pay;
  @nullable
  @BuiltValueField(wireName: 'Price')
  String get price;

  @nullable
  @BuiltValueField(wireName: 'Startdate')
  DateTime get startdate;
  @nullable
  @BuiltValueField(wireName: 'endDate')
  DateTime get endDate;

  @nullable
  String get type;

  @nullable
  @BuiltValueField(wireName: kDocumentReferenceField2)
  DocumentReference get reference;

  static void _initializeBuilder(MembershipRecordBuilder builder) => builder
    ..price = ''
    ..type = '';

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('Membership');

  static Stream<MembershipRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers2.deserializeWith(serializer, serializedData2(s)));

  MembershipRecord._();
  factory MembershipRecord([void Function(MembershipRecordBuilder) updates]) =
      _$MembershipRecord;

  static MembershipRecord getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers2.deserializeWith(serializer,
          {...mapFromFirestore2(data), kDocumentReferenceField2: reference});
}

Map<String, dynamic> createMembershipRecordData({
  String price,
  String pay,
  DateTime startdate,
  DateTime endDate,
  String type,
  String email,
}) =>
    serializers2.toFirestore2(
        MembershipRecord.serializer,
        MembershipRecord((m) => m
          ..price = price
          ..pay = pay
          ..startdate = startdate
          ..endDate = endDate
          ..email = email
          ..type = type));
