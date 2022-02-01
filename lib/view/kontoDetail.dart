import 'package:bankaccount_app/controller/modelController.dart';
import 'package:bankaccount_app/model/Konto.dart';
import 'package:bankaccount_app/model/Transaktion.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class KontoDetail extends StatefulWidget {
  KontoDetail({Key key, this.konto}) : super(key: key);
  final Konto konto;
  @override
  _KontoDetailState createState() => _KontoDetailState(konto);
}

final myControllerbelob = TextEditingController();
final myControllerbeskrivelse = TextEditingController();

class _KontoDetailState extends State<KontoDetail> {
  _KontoDetailState(this.konto);
  final Konto konto;
  @override
  Widget build(BuildContext context) {
    return Consumer<ModelController>(
        builder: (context, _modelController, widgets) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Transaktioner'),
          centerTitle: true,
        ),
        body: Consumer<ModelController>(
          builder: (context, _modelController, widgets) {
            return ListView.builder(
              itemCount:
                  konto.transaktioner != null ? konto.transaktioner.length : 0,
              itemBuilder: (context, index) {
                Transaktion trans =
                    _modelController.getTransaktion(konto, index);
                return Container(
                    decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(color: Colors.black)),
                    ),
                    child: ListTile(
                      isThreeLine: true,
                      title: Text(trans.beskrivelse),
                      subtitle: Text(
                        DateFormat('dd. MMMM yyyy')
                            .format(trans.overforselsdato),
                      ),
                      trailing: Text('Kr.' + trans.belob.toString()),
                    ));
              },
            );
          },
        ),
        floatingActionButton: FloatingActionButton.extended(
          icon: Icon(Icons.add),
          label: Text('opret transaktion'),
          onPressed: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Opret konto'),
                    content: Scaffold(
                      body: ListView(
                        children: <Widget>[
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Beløb',
                            ),
                            controller: myControllerbelob,
                          ),
                          TextFormField(
                            decoration:
                                InputDecoration(labelText: 'Beskrivelse'),
                            controller: myControllerbeskrivelse,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Transaktion trans = Transaktion(
                                belob: double.parse(myControllerbelob.text),
                                beskrivelse: myControllerbeskrivelse.text,
                              );
                              _modelController.addTransaktion(
                                  transaktion: trans, konto: konto);
                              Navigator.of(context).pop();
                            },
                            child: Text('opret'),
                          )
                        ],
                      ),
                    ),
                  );
                });
          },
        ),
      );
    });
  }
}
