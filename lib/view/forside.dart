import 'package:bankaccount_app/controller/modelController.dart';
import 'package:bankaccount_app/model/Konto.dart';
import 'package:bankaccount_app/view/kontoDetail.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Forside extends StatefulWidget {
  Forside({Key key}) : super(key: key);

  @override
  _ForsideState createState() => _ForsideState();
}

final myControllerKontoNavn = TextEditingController();
final myControllerKontotype = TextEditingController();

class _ForsideState extends State<Forside> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ModelController>(
        builder: (context, _modelController, widgets) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Konti'),
        ),
        body: ListView.builder(
            itemCount: _modelController.numberOfKonti,
            itemBuilder: (context, index) {
              Konto konto = _modelController.getKonto(index);
              return Container(
                  decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(color: Colors.black)),
                  ),
                  child: ListTile(
                    title: Text(konto.navn),
                    subtitle: Text(konto.kontotype),
                    trailing: Text("Kr. " + konto.beregnSaldo().toString()),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => KontoDetail(konto: konto)));
                    },
                  ));
            }),
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
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
                                labelText: 'Konto navn',
                              ),
                              controller: myControllerKontoNavn,
                            ),
                            new DropdownButton<String>(
                              items: <String>[
                                'Opsparing',
                                'Forbrug',
                                'Regninger',
                              ].map((String value) {
                                return new DropdownMenuItem<String>(
                                  value: value,
                                  child: new Text(value),
                                );
                              }).toList(),
                              onChanged: (String newValue) {
                                myControllerKontotype.text = newValue;
                              },
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Konto konto = Konto(
                                    navn: myControllerKontoNavn.text,
                                    kontotype: myControllerKontotype.text);
                                _modelController.addKonto(konto: konto);
                                Navigator.of(context).pop();
                              },
                              child: Text('opret'),
                            )
                          ],
                        ),
                      ),
                    );
                  });
            }),
      );
    });
  }
}
