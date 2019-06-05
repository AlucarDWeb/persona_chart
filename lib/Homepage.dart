
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:persona_chart/PersonasListView.dart';
import 'package:persona_chart/model.dart';

class HomePage extends StatefulWidget {

  final Future<Map<String, dynamic>> datasource;

  const HomePage({Key key, this.datasource}) : super(key: key);

  @override
  State<StatefulWidget> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {

  Icon _searchIcon =  Icon(Icons.search);
  List<Persona> _filteredDataset;
  List<Persona> _completeDataset;
  final _textEditingController = TextEditingController();
  bool _isSearchPressed = false;
  Widget _appBarTitle; 
  Widget _body;

  @override
  void initState() {
    super.initState();
    _textEditingController.addListener(_filterClosure);
  }

  @override
  void dispose() {

    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return prepareHomePageScaffold();
  }

  StatefulWidget prepareHomePageScaffold() {
    _appBarTitle = !_isSearchPressed ? Text("Personas list", style: Theme.of(context).textTheme.subtitle) 
    : TextField(
      controller: _textEditingController,
      decoration: new InputDecoration(
          prefixIcon: new Icon(Icons.search),
          hintText: 'Search Persona'
        ),
    );

    _body = !_isSearchPressed ? FutureBuilder<List<Persona>>(
        future: Persona.preparePersonas(widget.datasource),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          _completeDataset = snapshot.data;
          _filteredDataset = snapshot.data;
          return PersonasListView(datasource: snapshot.data);
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        return Center(child: CircularProgressIndicator());
      },
      ) 
      : PersonasListView(datasource: _filteredDataset);
      
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: _searchIcon,
            onPressed: () {
              _searchButtonPressed();
            },
          )
        ],
        title: _appBarTitle
      ),
      body: _body
    );
  }

  void _searchButtonPressed() {
    setState(() {
      _isSearchPressed = !_isSearchPressed;
    });
  }

  _filterClosure() {
    setState(() {
      final searchText =_textEditingController.text;
      _filteredDataset = filterPersonasBy(searchText);
    });
  }

  List<Persona>filterPersonasBy(String searchText) {
    return _completeDataset.where((persona) => persona.name.toLowerCase().contains(searchText.toLowerCase()) 
                                            || persona.arcana.toLowerCase().contains(searchText.toLowerCase())).toList();
  } 
}