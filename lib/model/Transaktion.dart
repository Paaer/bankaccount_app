import 'package:cloud_firestore/cloud_firestore.dart';

class Transaktion {
  double belob;
  DateTime overforselsdato = DateTime.now();
  String beskrivelse;

  Transaktion({
    this.belob,
    this.beskrivelse,
    String id,
  });

  factory Transaktion.fromMap(Map<String, dynamic> data) {
    Timestamp t = data['overforselsdato'];
    num nummer = data['belob'];
    Transaktion _transaktion = Transaktion(
      beskrivelse: data['beskrivelse'],
      id: data['id'],
    );
    _transaktion.overforselsdato = t.toDate();
    _transaktion.belob = nummer.toDouble();
    return _transaktion;
  }

  toMap() {
    return {
      'belob': this.belob,
      'overforselsdato': this.overforselsdato.toUtc(),
      'beskrivelse': this.beskrivelse,
    };
  }
}
