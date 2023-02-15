import 'dart:async';

import 'index.dart';
import 'serializers3.dart';
import 'package:built_value/built_value.dart';

part 'Rating_record.g.dart';

abstract class RatingRecord implements Built<RatingRecord,RatingRecordBuilder> {
  static Serializer<RatingRecord> get serializer => _$ratingRecordSerializer;

  @nullable
  @BuiltValueField(wireName: 'Commnet')
  String get commnet;

  @nullable
  @BuiltValueField(wireName: kDocumentReferenceField3)
  DocumentReference get reference;




  static void _initializeBuilder(RatingRecordBuilder builder) => builder
    ..commnet = '';


  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('Rating');

  static Stream<RatingRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers3.deserializeWith(serializer, serializedData3(s)));

RatingRecord._();
  factory RatingRecord([void Function(RatingRecordBuilder) updates]) = _$RatingRecord;
 static RatingRecord getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers3.deserializeWith(serializer,
          {...mapFromFirestore3(data), kDocumentReferenceField3: reference});
  
}

Map<String, dynamic> createTripRecordData({
  String commnet,

}) =>
    serializers3.toFirestore3(
         RatingRecord.serializer, RatingRecord((r) => r..commnet = commnet));