import 'package:bankaccount_app/controller/databaseController.dart';
import 'package:bankaccount_app/model/Konto.dart';
import 'package:bankaccount_app/model/Transaktion.dart';
import 'package:flutter/cupertino.dart';

class ModelController extends ChangeNotifier {
  List<Transaktion> _transaktioner = [];
  List<Konto> _konti = [];
  final DatabaseService _dbService = DatabaseService();

  ModelController() {
    _dbService.kontoStream().listen((snapshot) {
      _konti.clear();
      snapshot.docs.forEach((konto) {
        _konti.add(Konto.fromFirestore(konto));
      });
      notifyListeners();
    });
  }

  int get numberOfTransaktioner {
    return _transaktioner.length;
  }

  int get numberOfKonti {
    return _konti.length;
  }

  Transaktion getTransaktion(Konto konto, int index) {
    return konto.transaktioner.elementAt(index);
  }

  Konto getKonto(int index) {
    return _konti[index];
  }

  addKonto({Konto konto}) async {
    _konti.add(konto);
    _dbService.addKonto(konto: konto);
    notifyListeners();
  }

  addTransaktion({Transaktion transaktion, Konto konto}) async {
    _dbService.addTransaktion(transaktion: transaktion, konto: konto);
    _transaktioner.add(transaktion);
    notifyListeners();
  }
}
