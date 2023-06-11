import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:wazzup/core/typedefs/failure.dart';
import 'package:wazzup/core/typedefs/typedefs.dart';

import 'firebase_provider.dart';

final storageRepositoryProvider = Provider(
  (ref) => StorageRepository(
    firebaseStorage: ref.watch(storageProvider),
  ),
);

class StorageRepository {
  final FirebaseStorage _firebaseStorage;

  StorageRepository({required FirebaseStorage firebaseStorage})
      : _firebaseStorage = firebaseStorage;

  FutureEither<String> storeFile({
    required String path,
    required String id,
    required File? file,
    required Uint8List? webFile,
  }) async {
    try {
      final reference = _firebaseStorage.ref().child(path).child(id);
      UploadTask uploadTask;

      if (kIsWeb) {
        uploadTask = reference.putData(webFile!);
      } else {
        uploadTask = reference.putFile(file!);
      }

      final snapshot = await uploadTask;

      return right(await snapshot.ref.getDownloadURL());
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
