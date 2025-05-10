import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../widgets/globalLoader/bloc/bloc/loader_bloc.dart'; // wherever your LoaderBloc is

class FirestoreHelper {
  final FirebaseFirestore firestore;
  final LoaderBloc loaderBloc;

  FirestoreHelper({
    required this.firestore,
    required this.loaderBloc,
  });

  Future<DocumentSnapshot<Map<String, dynamic>>> getDocument(
      String path,
      ) async {
    try {
      loaderBloc.add(const LoaderEvent.loadingON());
      final doc = await firestore.doc(path).get();
      return doc;
    } finally {
      loaderBloc.add(const LoaderEvent.loadingOFF());
    }
  }

  Future<void> setDocument(
      String path,
      Map<String, dynamic> data,
      ) async {
    try {
      loaderBloc.add(const LoaderEvent.loadingON());
      await firestore.doc(path).set(data);
    } finally {
      loaderBloc.add(const LoaderEvent.loadingOFF());
    }
  }

// You can add updateDocument, deleteDocument, collectionQuery, etc.
}
