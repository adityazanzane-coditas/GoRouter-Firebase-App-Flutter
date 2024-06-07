import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:navigate_app/features/dashboard/data/models/author_model.dart';
import 'package:navigate_app/features/dashboard/data/models/book_model.dart';

class FirebaseDatasource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<AuthorModel>> getAuthors() {
    return _firestore.collection('Authors').snapshots().map(
          (snapshot) => snapshot.docs
              .map((doc) => AuthorModel.fromMap(doc.data()))
              .toList(),
        );
  }

  Stream<List<BookModel>> getBooks() {
    return _firestore.collection('Books').snapshots().map(
          (snapshot) => snapshot.docs
              .map((doc) => BookModel.fromMap(doc.data()))
              .toList(),
        );
  }
}