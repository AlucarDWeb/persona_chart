import 'package:flutter/material.dart';
import 'package:persona_chart/PersonaDetailPage.dart';
import 'package:persona_chart/PersonasListCard.dart';
import 'package:persona_chart/model.dart';

class PersonasListView extends StatefulWidget {
  final List <Persona> datasource;

  const PersonasListView({Key key, this.datasource}) : super(key: key);

  @override
  State<StatefulWidget> createState() => PersonasListViewState();
}

class PersonasListViewState extends State<PersonasListView> {

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.datasource.length,
      itemBuilder: (context, position) {
        final Persona persona = widget.datasource[position];
        return GestureDetector(
          onTap: () {
            Navigator.push(context, ToDetailRoute(persona));
          },
          child: PersonasListCard(persona: persona),
        );
      }
    );
  }
}

class ToDetailRoute extends MaterialPageRoute {
  final Persona persona;

  ToDetailRoute(this.persona) : super(builder: (context) => PersonaDetailPage(persona: persona));

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
    return FadeTransition(opacity: animation, child: child);
  }
}