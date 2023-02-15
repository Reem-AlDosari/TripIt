import 'package:built_value/standard_json_plugin.dart';

import 'Rating_record.dart';

import 'index.dart';

export 'index.dart';

part 'serializers.g3.dart';

const kDocumentReferenceField3 = 'Document__Reference__Field';

@SerializersFor(const [
  RatingRecord,
])
final Serializers serializers3= (_$serializers.toBuilder()
      ..add(DocumentReferenceSerializer3())
      ..add(DateTimeSerializer3())
      ..add(LatLngSerializer3())
      ..addPlugin(StandardJsonPlugin()))
    .build();

extension SerializerExtensions3 on Serializers {
  Map<String, dynamic> toFirestore3<T>(Serializer<T> serializer, T object) =>
      mapToFirestore3(serializeWith(serializer, object));
}

class DocumentReferenceSerializer3
    implements PrimitiveSerializer<DocumentReference> {
  final bool structured = false;
  @override
  final Iterable<Type> types = new BuiltList<Type>([DocumentReference]);
  @override
  final String wireName = 'DocumentReference';

  @override
  Object serialize(Serializers serializers, DocumentReference reference,
      {FullType specifiedType: FullType.unspecified}) {
    return reference;
  }

  @override
  DocumentReference deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType: FullType.unspecified}) =>
      serialized as DocumentReference;
}

class DateTimeSerializer3 implements PrimitiveSerializer<DateTime> {
  @override
  final Iterable<Type> types = new BuiltList<Type>([DateTime]);
  @override
  final String wireName = 'DateTime';

  @override
  Object serialize(Serializers serializers, DateTime dateTime,
      {FullType specifiedType: FullType.unspecified}) {
    return dateTime;
  }

  @override
  DateTime deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType: FullType.unspecified}) =>
      serialized as DateTime;
}

class LatLngSerializer3 implements PrimitiveSerializer<LatLng> {
  final bool structured = false;
  @override
  final Iterable<Type> types = new BuiltList<Type>([LatLng]);
  @override
  final String wireName = 'LatLng';

  @override
  Object serialize(Serializers serializers, LatLng location,
      {FullType specifiedType: FullType.unspecified}) {
    return location;
  }

  @override
  LatLng deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType: FullType.unspecified}) =>
      serialized as LatLng;
}

Map<String, dynamic> serializedData3(DocumentSnapshot doc) =>
    {...mapFromFirestore3(doc.data()), kDocumentReferenceField3: doc.reference};

Map<String, dynamic> mapFromFirestore3(Map<String, dynamic> data) =>
    data.map((key, value) {
      if (value is Timestamp) {
        value = (value as Timestamp).toDate();
      }
      if (value is GeoPoint) {
        value = (value as GeoPoint).toLatLng();
      }
      return MapEntry(key, value);
    });

Map<String, dynamic> mapToFirestore3(Map<String, dynamic> data) =>
    data.map((key, value) {
      if (value is LatLng) {
        value = (value as LatLng).toGeoPoint();
      }
      return MapEntry(key, value);
    });

extension GeoPointExtension3 on LatLng {
  GeoPoint toGeoPoint() => GeoPoint(latitude, longitude);
}

extension LatLngExtension3 on GeoPoint {
  LatLng toLatLng() => LatLng(latitude, longitude);
}

DocumentReference toRef3(String ref) => FirebaseFirestore.instance.doc(ref);

T safeGet3<T>(T Function() func, [Function(dynamic) reportError]) {
  try {
    return func();
  } catch (e) {
    reportError?.call(e);
  }
  return null;
}
