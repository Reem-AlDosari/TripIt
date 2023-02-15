import 'dart:async';

import 'index.dart';
import 'serializers1.dart';
import 'package:built_value/built_value.dart';

part 'trip_record.g.dart';

abstract class TripRecord implements Built<TripRecord, TripRecordBuilder> {
  static Serializer<TripRecord> get serializer => _$tripRecordSerializer;

  @nullable
  @BuiltValueField(wireName: 'Line')
  String get line;

  @nullable
  @BuiltValueField(wireName: 'Price')
  String get price;

  @nullable
  @BuiltValueField(wireName: kDocumentReferenceField1)
  DocumentReference get reference;

  static void _initializeBuilder(TripRecordBuilder builder) => builder
    ..line = ''
    ..price = '';

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('Trip');

  static Stream<TripRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers1.deserializeWith(serializer, serializedData1(s)));

  TripRecord._();
  factory TripRecord([void Function(TripRecordBuilder) updates]) = _$TripRecord;

  static TripRecord getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers1.deserializeWith(serializer,
          {...mapFromFirestore1(data), kDocumentReferenceField1: reference});
}

Map<String, dynamic> createTripRecordData({
  String line,
  String price,
}) =>
    serializers1.toFirestore1(
        TripRecord.serializer,
        TripRecord((t) => t
          ..line = line
          ..price = price));
