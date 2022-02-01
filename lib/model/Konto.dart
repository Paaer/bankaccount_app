import 'package:bankaccount_app/model/Transaktion.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Konto {
  String navn;
  String kontotype;
  List<Transaktion> transaktioner = [];
  double saldo = 0;
  String id;

  Konto({
    this.navn,
    this.kontotype,
    this.transaktioner,
    this.id,
  });

  factory Konto.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data();
    List<Transaktion> toTransaktionlist() {
      List<Transaktion> transaktioner = [];
      for (int i = 0; i < data['transaktioner'].length; i++) {
        Transaktion _transaction =
            Transaktion.fromMap(data['transaktioner'][i]);
        transaktioner.add(_transaction);
      }
      return transaktioner;
    }

    Konto _account = Konto(
        id: doc.id,
        navn: data['navn'],
        kontotype: data['kontotype'],
        transaktioner: toTransaktionlist());
    return _account;
  }

  toMap() {
    return {
      'navn': this.navn,
      'kontotype': this.kontotype,
      'transaktioner': <Transaktion>[],
    };
  }

  addTransaktion(Transaktion transaktion, Konto konto) {
    konto.transaktioner.add(transaktion);
  }

  beregnSaldo() {
    double result = 0;
    if (this.transaktioner != null) {
      for (int i = 0; i < this.transaktioner.length; i++) {
        result += this.transaktioner.elementAt(i).belob;
      }
      return result;
    } else {
      return 0;
    }
  }
}
