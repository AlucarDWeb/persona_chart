import 'package:flutter/material.dart';
import 'package:persona_chart/model.dart';

class PersonasListCard extends StatefulWidget {
  final Persona persona;

  const PersonasListCard({Key key, this.persona}) : super(key: key);

  @override
  State<StatefulWidget> createState() => PersonasListState();
}

class PersonasListState extends State<PersonasListCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Hero(
      tag: widget.persona.name,
      child: new Card(
        color: Colors.black,
        child: new Container(
            decoration: BoxDecoration(
                border: Border.all(color: Colors.red, width: 5.0)),
            alignment: Alignment.center,
            margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
            child: Column(
              children: <Widget>[
                Container(
                    alignment: Alignment.centerLeft,
                    margin:
                        EdgeInsets.only(top: 10.0, bottom: 10.0, left: 10.0),
                    child: Text(widget.persona.arcana,
                        style: Theme.of(context).textTheme.subtitle)),
                Container(
                  margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: Text(widget.persona.name,
                      style: Theme.of(context).textTheme.title),
                ),
                Container(
                  alignment: Alignment.centerRight,
                  margin: EdgeInsets.only(top: 10.0, bottom: 10.0, right: 10.0),
                  child: Text("Level " + widget.persona.level.toString(),
                      style: Theme.of(context).textTheme.subtitle),
                ),
              ],
            )),
      ),
    ));
  }
}
