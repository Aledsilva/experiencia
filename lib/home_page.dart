import 'package:flutter/material.dart';
import 'package:scrolling_day_calendar/scrolling_day_calendar.dart';
import 'package:http/http.dart' as agatetepe;
import 'dart:async';
import 'dart:convert';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  String itemEscolhido;
  String inicial = "";

  void _recuperar() async {
    String url = "https://api.adviceslip.com/advice";
    agatetepe.Response response = await agatetepe.get(url);

    Map<String, dynamic> retorno = json.decode(response.body);
    dynamic id = retorno ["id"];
    String advice = retorno ["advice"];


  }

  List listaDeItens = [
    "Item 1",
    "Item 2",
    "Item 3",
    "Item 4",
    "Item 5",
    "Item 6",
    "Item 7",
    "Item 8",
    "Item 9",
    "Item 10",
  ];

  @override
  Widget build(BuildContext context) {

    DateTime selectedDate = DateTime.now();
    DateTime startDate = DateTime.now().subtract(Duration(days: 10));
    DateTime endDate = DateTime.now().add(Duration(days: 10));
    Map<String, Widget> widgets = Map();
    String widgetKeyFormat = "yyyy-MM-dd";


    return Scaffold(
      appBar: AppBar(
        title: Text("Opa, eai?"),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              padding: EdgeInsets.only(left: 30, right: 30),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 1),
                borderRadius: BorderRadius.circular(15),
              ),
              child: DropdownButton(
                hint: Text("Quero morrer de catapora"),
                dropdownColor: Colors.white60,
                icon: Icon(Icons.arrow_drop_down_circle_outlined,
                    color: Colors.green),
                iconSize: 36,
                isExpanded: true,
                style: TextStyle(color: Colors.blue, fontSize: 22),
                value: itemEscolhido,
                onChanged: (novoItem) {
                  setState(() {
                    itemEscolhido = novoItem;
                    inicial = itemEscolhido;
                  });
                },
                items: listaDeItens.map((umValorNovoNesseCampo) {
                  return
                    DropdownMenuItem(
                    value: umValorNovoNesseCampo,
                    child: Text(umValorNovoNesseCampo),
                  );
                }).toList(),
              ),
            ),
          ),
          Expanded(
              child: ScrollingDayCalendar(
                startDate: startDate,
                endDate: endDate,
                selectedDate: selectedDate,
                dateStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                displayDateFormat: "dd, MMM yyyy",
                dateBackgroundColor: Colors.blue,
                forwardIcon: Icons.arrow_forward,
                backwardIcon: Icons.arrow_back,
                pageChangeDuration: Duration(
                  milliseconds: 700,
                ),
                widgets: widgets,
                widgetKeyFormat: widgetKeyFormat,
                noItemsWidget: Expanded(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(16, 8, 16, 2),
                    child: Text(inicial.toString(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,),),
                  ), // add buttons etc here to add new items for date
                ),
              ),
          ),
        ],
      ),
    );
  }
}
