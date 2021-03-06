import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:covid_19_tracker/datasource.dart';
import 'package:covid_19_tracker/pages/countyPage.dart';
import 'package:covid_19_tracker/Panels/infoPanel.dart';
import 'package:covid_19_tracker/Panels/mostaffectedcountries.dart';
import 'package:covid_19_tracker/Panels/worldwidepanel.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Map worldData;
  fetchWorldWideData() async {
    var url =Uri.parse("https://disease.sh/v3/covid-19/all");
    http.Response response = await http.get(url);
    setState(() {
      worldData = json.decode(response.body);
    });
  }

  List countryData;
  fetchCountryData() async {
    var url =Uri.parse("https://disease.sh/v3/covid-19/countries?sort=cases" );
    http.Response response =
    await http.get(url);
    setState(() {
      countryData = json.decode(response.body);
    });
  }


  Future fetchData() async{
    fetchWorldWideData();
    fetchCountryData();
    print('fetchData called');
  }

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'COVID-19 TRACKER',
        ),
      ),
      body: RefreshIndicator(
        onRefresh: fetchData,
        child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  height: 100,
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(10),
                  color: Colors.orange[100],
                  child: Text(
                    DataSource.quote,
                    style: TextStyle(
                        color: Colors.orange[800],
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Worldwide',
                        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => CountryPage()));
                        },
                        child: Container(
                            decoration: BoxDecoration(
                                color: primaryBlack,
                                borderRadius: BorderRadius.circular(15)),
                            padding: EdgeInsets.all(10),
                            child: Text(
                              'Regional',
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            )),
                      ),
                    ],
                  ),
                ),
                worldData == null
                    ? CircularProgressIndicator()
                    : WorldwidePanel(
                  worldData: worldData,
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Text(
                    'Most affected Countries',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                countryData == null
                    ? Container()
                    : MostAffectedPanel(
                  countryData: countryData,
                ),
                InfoPanel(),
                SizedBox(
                  height: 20,
                ),
                Center(
                    child: Text(
                      'WE ARE TOGETHER IN THE FIGHT',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    )),
                SizedBox(
                  height: 50,
                )
              ],
            )),
      ),
    );
  }
}