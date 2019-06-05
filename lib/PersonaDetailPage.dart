import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:persona_chart/model.dart';

class PersonaDetailPage extends StatelessWidget {
  final Persona persona;

  const PersonaDetailPage({Key key, this.persona}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new DetailPageWidget(persona: persona);
  }
}

class DetailPageWidget extends StatelessWidget {
  const DetailPageWidget({
    Key key,
    @required this.persona,
  }) : super(key: key);

  final Persona persona;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            persona.name,
            style: Theme.of(context).textTheme.title,
          ),
        ),
        body: Column(
          children: <Widget>[new DetailFlexibleCard(persona: persona)],
        ));
  }
}

class DetailFlexibleCard extends StatelessWidget {
  const DetailFlexibleCard({
    Key key,
    @required this.persona,
  }) : super(key: key);

  final Persona persona;

  @override
  Widget build(BuildContext context) {
    
    final sortedmap = Map.fromEntries(persona.skills.entries.toList()..sort((el1, el2) => el1.value.compareTo(el2.value)));
    final skills = sortedmap.keys.map((final key) => key).toList();
    
    return Flexible(
      child: Hero(
        tag: persona.name,
        child: Card(
          color: Colors.black,
          child: Container(
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
                      child: Text(persona.arcana,
                          style: Theme.of(context).textTheme.subtitle)),
                  Container(
                    margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
                    child: Text(persona.name,
                        style: Theme.of(context).textTheme.title),
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    margin:
                        EdgeInsets.only(top: 10.0, bottom: 10.0, right: 10.0),
                    child: Text("Level " + persona.level.toString(),
                        style: Theme.of(context).textTheme.subtitle),
                  ),
                  Container(
                    height: 100,
                    margin:EdgeInsets.only(top: 50.0, bottom: 10.0, right: 10.0),
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: skills.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          width: 100.0,
                          height: 100.0,
                          child: Text(skills[index],
                              style: Theme.of(context).textTheme.body1),
                        );
                      },
                    ),
                  )
                ],
              )),
        ),
      ),
    );
  }
}

class BottomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0.0, size.height - 20); 
    path.lineTo(size.width, size.height - 40);
    path.lineTo(size.width, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
