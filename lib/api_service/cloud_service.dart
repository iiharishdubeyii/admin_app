import 'package:cloud_firestore/cloud_firestore.dart';


class CloudService{

static Future<List<T>> fetchDataByField<T>({
  required String collectionName,
  required String fieldName,
  required dynamic value,
  required T Function(Map<String, dynamic> data) fromJson,
}) async {
  try {
    final querySnapshot = await FirebaseFirestore.instance
        .collection(collectionName)
        .where(fieldName, isEqualTo: value)
        .get();

    return querySnapshot.docs
        .map((doc) => fromJson({'id': doc.id, ...doc.data() as Map<String, dynamic>}))
        .toList();
  } catch (e) {
    print('Error fetching data: $e');
    return [];
  }
}

}
