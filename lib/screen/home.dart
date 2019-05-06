import 'package:flutter/material.dart';
import 'package:ivoventek/model/ivo.dart';
import 'package:ivoventek/service/ivo_service.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //aqui apresenta a tela inicial do app
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: <Widget>[
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                child: Text("IB"),
              ),
              accountName: Text("Ivo Baptista"),
              accountEmail: Text("ivo@vodafone.pt"),
              //accountName: Text("Renato Ferraz"),
              //accountEmail: Text("renatoferrazdf@gmail.com"),
            ),
            ListTile(leading: Icon(Icons.home), title: Text("Home") ,),
            ListTile(leading: Icon(Icons.account_circle), title: Text("Conta") ,),
            ListTile(leading: Icon(Icons.notifications), title: Text("Notificações") ,),
            ListTile(leading: Icon(Icons.arrow_back), title: Text("Sair") ,),

          ],
        ),
      ),
      appBar: AppBar(
        title: Text('Vendas Tekkies'),
        backgroundColor: Colors.red,
      ),
      body: FutureBuilder<List<Ivo>>(
        future: IvoService.getIvo(),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);

          return snapshot.hasData
              ? IvoList(
                  ivo: snapshot.data,
                )
              : Center(child: CircularProgressIndicator());
        },
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: () {
          print("button is pressed!!!");
        },
        child: new Icon(Icons.add),
        elevation: 2.0,
      ),
      bottomNavigationBar: BottomAppBar(
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: IconButton(
                icon: Icon(Icons.home),
                onPressed: () {},
              ),
            ),
            Expanded(
              child: IconButton(
                icon: Icon(Icons.signal_wifi_4_bar),
                onPressed: () {},
              ),
            ),
            Expanded(child: new Text('')),
            Expanded(
              child: IconButton(
                icon: Icon(Icons.account_circle),
                onPressed: () {},
              ),
            ),
            Expanded(
              child: IconButton(
                icon: Icon(Icons.settings),
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class IvoList extends StatelessWidget {
  final List<Ivo> ivo;

  IvoList({Key key, this.ivo}) : super(key: key);

  @override
  //Aqui cria a lista com os dados
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: ivo.length,
      itemBuilder: (BuildContext context, int index) {
        //envia os dados da lista para montar o card
        return _cardList(
            context: context,
            reg: ivo[index].reg.toString(),
            tipoVenda: ivo[index].tipoVenda,
            vendaSAP: ivo[index].vendaSAP,
            quantidade: ivo[index].quantidade.toString());
      },
    );
  }

  Widget _cardList(
      {BuildContext context,
      String reg,
      String tipoVenda,
      String vendaSAP,
      String quantidade}) {
    return Container(
        height: 150,
        padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
        child: Container(
          child: Card(
            elevation: 10,
            child: Container(
              padding: EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Registro:',
                        style: TextStyle(
                            color: Colors.deepPurple,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        reg,
                        style: TextStyle(
                            color: Colors.deepPurple,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[Text('Tipo de Venda:'), Text(tipoVenda)],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[Text('Vendas SAP:'), Text(vendaSAP)],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Quantidade:',
                        style: TextStyle(
                            color: Colors.red, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        quantidade,
                        style: TextStyle(
                            color: Colors.red, fontWeight: FontWeight.bold),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
