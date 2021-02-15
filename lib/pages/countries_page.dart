import 'package:flutter/material.dart';
import 'package:quick_notes/model/get_countries.dart';

class CountriesPage extends StatefulWidget {
  final List<GetCountries> getCountries;

  CountriesPage({Key key, @required this.getCountries}) : super(key: key);

  @override
  _CountriesPageState createState() => _CountriesPageState();
}

class _CountriesPageState extends State<CountriesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Country Details'),
      ),
      body: ListView.builder(
        itemCount: widget.getCountries.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              ListTile(
                title: Text(widget.getCountries[index].name),
                subtitle: Text(widget.getCountries[index].capital),
              ),
              Divider(
                thickness: 5.0,
              )
            ],
          );
        },
      ),
    );
  }
}
