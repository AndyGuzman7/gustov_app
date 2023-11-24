import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_gustov/data/data_sources/remote/dao.database_firestore/firebase_service.dart';

abstract class BaseFirestoreRepository<T> {
  Future<bool> insert(T t);
  Future<bool> insertWithGeneratedId(T t);
  Future<T?> getById(String id);
  Future<T?> getByType(String field, String type);
  Future<T?> getByTypeDuo(
    String fieldFirst,
    String typeFirst,
    String fieldSecond,
    String typeSecond,
  );
  Future<List<T>> getAll();
  Future<List<T>> getAllByType(String field, String type);

  Future<bool> update(String field, dynamic data, String id);

  Map<String, dynamic>? fromSnapshot(DocumentSnapshot snapshot);

  Map<String, dynamic> toJson(T t);
  T fromJson(Map<String, dynamic> map);
}

class BaseFirestoreRepositoryImpl<T> implements BaseFirestoreRepository<T> {
  BaseFirestoreRepositoryImpl(this.collectionPath) {
    collection = firebaseInstance.firestore.collection(collectionPath);
  }
  final FirebaseInstance firebaseInstance = FirebaseInstance();
  final String collectionPath;
  late final CollectionReference collection;

  @override
  Future<bool> insert(T t) async {
    try {
      final documentReference = collection.doc();
      final data = toJson(t);
      await documentReference.set(data);
      final snapshot = await documentReference.get();
      return snapshot.exists;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> insertWithGeneratedId(T t) async {
    try {
      final documentReference = collection.doc();
      final id = documentReference.id;

      final data = toJson(t);
      data['id'] = id;

      await documentReference.set(data);
      final snapshot = await documentReference.get();
      return snapshot.exists;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> update(String field, dynamic data, String id) async {
    try {
      final documentReference = collection.doc(id);

      await documentReference.update({field: data});
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<T?> getById(String id) async {
    try {
      final snapshot = await collection.doc(id).get();
      if (snapshot.exists) {
        return fromJson(fromSnapshot(snapshot)!);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  @override
  Future<T?> getByType(String field, String type) async {
    try {
      final querySnapshot =
          await collection.where(field, isEqualTo: type).limit(1).get();

      if (querySnapshot.size > 0) {
        final DocumentSnapshot documentSnapshot = querySnapshot.docs[0];
        final response = fromJson(fromSnapshot(documentSnapshot)!);

        return response;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  @override
  Future<List<T>> getAll() async {
    try {
      final response = await collection.get();

      return response.docs.map((doc) => fromJson(fromSnapshot(doc)!)).toList();
    } catch (e) {
      return [];
    }
  }

  @override
  Future<List<T>> getAllByType(String field, String type) async {
    try {
      final querySnapshot =
          await collection.where(field, isEqualTo: type).get();

      return querySnapshot.docs
          .map((doc) => fromJson(fromSnapshot(doc)!))
          .toList();
    } catch (e) {
      return [];
    }
  }

  @override
  Future<T?> getByTypeDuo(
    String fieldFirst,
    String typeFirst,
    String fieldSecond,
    String typeSecond,
  ) async {
    try {
      final querySnapshot = await collection
          .where(fieldFirst, isEqualTo: typeFirst)
          .where(fieldSecond, isEqualTo: typeSecond)
          .limit(1)
          .get();

      if (querySnapshot.size > 0) {
        final DocumentSnapshot documentSnapshot = querySnapshot.docs[0];
        final map = fromSnapshot(documentSnapshot);
        final response = fromJson(map!);

        return response;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  @override
  Map<String, dynamic>? fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>?;
    return data;
  }

  @override
  Map<String, dynamic> toJson(T t) {
    // TODO: implement toJson
    throw UnimplementedError();
  }

  @override
  T fromJson(Map<String, dynamic> map) {
    // TODO: implement fromJson
    throw UnimplementedError();
  }
}
