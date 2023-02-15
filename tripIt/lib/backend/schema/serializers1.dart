import 'package:built_value/standard_json_plugin.dart';

import 'trip_record.dart';

import 'index.dart';

export 'index.dart';

part 'serializers1.g.dart';

const kDocumentReferenceField1 = 'Document__Reference__Field';

@SerializersFor(const [
  TripRecord,
])
final Serializers serializers1 = (_$serializers.toBuilder()
      ..add(DocumentReferenceSerializer1())
      ..add(DateTimeSerializer1())
      ..add(LatLngSerializer1())
      ..addPlugin(StandardJsonPlugin()))
    .build();

extension SerializerExtensions1 on Serializers {
  Map<String, dynamic> toFirestore1<T>(Serializer<T> serializer, T object) =>
      mapToFirestore1(serializeWith(serializer, object));
}

class DocumentReferenceSerializer1
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

class DateTimeSerializer1 implements PrimitiveSerializer<DateTime> {
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

class LatLngSerializer1 implements PrimitiveSerializer<LatLng> {
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

Map<String, dynamic> serializedData1(DocumentSnapshot doc) =>
    {...mapFromFirestore1(doc.data()), kDocumentReferenceField1: doc.reference};

Map<String, dynamic> mapFromFirestore1(Map<String, dynamic> data) =>
    data.map((key, value) {
      if (value is Timestamp) {
        value = (value as Timestamp).toDate();
      }
      if (value is GeoPoint) {
        value = (value as GeoPoint).toLatLng();
      }
      return MapEntry(key, value);
    });

Map<String, dynamic> mapToFirestore1(Map<String, dynamic> data) =>
    data.map((key, value) {
      if (value is LatLng) {
        value = (value as LatLng).toGeoPoint();
      }
      return MapEntry(key, value);
    });

extension GeoPointExtension1 on LatLng {
  GeoPoint toGeoPoint() => GeoPoint(latitude, longitude);
}

extension LatLngExtension1 on GeoPoint {
  LatLng toLatLng() => LatLng(latitude, longitude);
}

DocumentReference toRef1(String ref) => FirebaseFirestore.instance.doc(ref);

T safeGet1<T>(T Function() func, [Function(dynamic) reportError]) {
  try {
    return func();
  } catch (e) {
    reportError?.call(e);
  }
  return null;
}
