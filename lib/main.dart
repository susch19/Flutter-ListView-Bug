import 'package:flutter/material.dart';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Listview Bug',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: 'Listview Bug'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> shoppingItems = new List<String>();

  @override
  void initState() {
    super.initState();
    initList();
  }

  void initList() {
    shoppingItems.clear();
    for (int i = 0; i < 30; i++) shoppingItems.add(i.toString());
    setState(() => {});
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: new Builder(builder: buildBody),
      floatingActionButton: new FloatingActionButton(
        onPressed: () => {},
        child: new IconButton(
          icon: new Icon(Icons.restore),
          onPressed: () => initList(),
        ),
      ),
    );
  }

  Widget buildBody(BuildContext context) {
    var mainList = shoppingItems.map((x) {
      var lt = new ListTile(
        title: new Row(children: [
          new Expanded(
            child: new Text(x),
          ),
        ]),
      );

      return new Dismissible(
        key: new ObjectKey(lt),
        child: lt,
        onDismissed: (DismissDirection d) =>
            setState(() => shoppingItems.remove(x)),
        direction: DismissDirection.startToEnd,
        background: new Container(
            decoration:
                new BoxDecoration(color: Theme.of(context).primaryColor),
            child: new ListTile(
                leading: new Icon(Icons.delete,
                    color: Theme.of(context).accentIconTheme.color,
                    size: 36.0))),
      );
    }).toList(growable: true);

    return new ListView(
      children: mainList,
    );
  }
}
