import 'package:bankaccount_app/model/Konto.dart';
import 'package:bankaccount_app/model/Transaktion.dart';
import 'package:cloud_firestore/cloud_firestore.dart' as fire;

class DatabaseService {
  final fire.FirebaseFirestore _db = fire.FirebaseFirestore.instance;

  Stream<fire.QuerySnapshot> kontoStream() {
    return _db.collection('konti').snapshots();
  }

  Stream<fire.QuerySnapshot> transaktionStream() {
    return _db
        .collection('transaktioner')
        .orderBy('date', descending: true)
        .snapshots();
  }

  addTransaktion({Konto konto, Transaktion transaktion}) {
    List<dynamic> transaktioner = [transaktion.toMap()];
    fire.DocumentReference instans = _db.collection('konti').doc(konto.id);
    instans
        .update({'transaktioner': fire.FieldValue.arrayUnion(transaktioner)});
  }

  addKonto({Konto konto}) async {
    await _db.collection('konti').add(konto.toMap());
  }
}
