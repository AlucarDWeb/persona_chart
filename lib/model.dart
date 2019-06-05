
import 'dart:convert';
import 'package:flutter/services.dart';

enum StatType {
  Strength, Magic, Endurance, Agility, Luck
}

enum ElementsType {
  Physical, Gun, Fire, Ice, Electric, Wind, Psychic, Nuclear, Bless, Curse
}

class Persona {
  final String name;
  final String arcana;
  final int level;
  final Map<StatType, dynamic> stats;
  final Map<ElementsType, dynamic> elements;
  final Map<String,dynamic> skills;

  Persona({this.name, this.arcana, this.level, this.stats, this.elements, this.skills});

  factory Persona.fromJson(Map<String, dynamic> json, String key) {
    return Persona(
      arcana: json['arcana'],
      name: key,
      stats: prepareStats(json['stats']),
      elements: prepareElements(json['elems']),
      skills: json['skills'],
      level: json['level'],
    );
  }

  static Map<StatType, dynamic> prepareStats(List<dynamic> statList) {
    final output = Map <StatType, dynamic>();

    for(int i = 0; i < statList.length; i++) {
      final value = statList[i];
      output.putIfAbsent(StatType.values[i], () => value);
    }

    return output;
  }

  static Map<ElementsType, dynamic> prepareElements(List<dynamic> statList) {
    final output = Map <ElementsType, dynamic>();

    for(int i = 0; i < statList.length; i++) {
      final value = statList[i];
      output.putIfAbsent(ElementsType.values[i], () => value);
    }

    return output;
  }

  static Future<Map<String, dynamic>> readJsonData() async {
    final encoded = await rootBundle.loadString("lib/assets/personas.json");
    return json.decode(encoded);
  }

  static Future<List<Persona>> preparePersonas(Future<Map<String, dynamic>> inputData) async {
    List<Persona> output = List();
    final data = await inputData;
    
    data.forEach((final String key, final value) {
      final persona = Persona.fromJson(value, key);
      output.add(persona);
    });

    output.sort((final elementA, final elementB) => elementA.level.compareTo(elementB.level));
    //output.sort((final elementA, final elementB) => elementA.arcana.compareTo(elementB.arcana));
    return output;
  }
}