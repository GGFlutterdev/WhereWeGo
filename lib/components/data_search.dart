import 'dart:io';
import 'package:flutter/material.dart';
import 'package:uni_events/functions.dart';
import 'package:uni_events/models/city.dart';

class DataSearch extends SearchDelegate<String>{
  List<City> cities;

  DataSearch({
    required this.cities,
  });

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () => query = '',
        icon: const Icon(
          Icons.clear,
        ),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () => close(context, ''),
      icon: Icon(
        Platform.isAndroid ? Icons.arrow_back : Icons.arrow_back_ios_new,
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return const SizedBox();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final List<City> suggestions = [];

    for(final city in cities){
      if(city.name.startsWith(query) || containsIgnoreCase(city.name, query)){
        suggestions.add(city);
      }
    }

    return ListView.builder(
      itemBuilder: (context, index) => InkResponse(
        onTap: (){
          close(context, suggestions[index].name);
        },
        child: ListTile(
          leading: Text(
            suggestions[index].country,
            style: Theme.of(context).textTheme.bodyText2,
          ),
          title: Text(
            suggestions[index].name,
            style: Theme.of(context).textTheme.bodyText2,
          ),
        ),
      ),
      itemCount: suggestions.length,
    );
  }
  
}
