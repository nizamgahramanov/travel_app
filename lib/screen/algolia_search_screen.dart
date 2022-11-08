import 'package:algolia/algolia.dart';
import 'package:flutter/material.dart';

import '../widgets/search_result_view.dart';

class AlgoliaSearchScreen extends StatefulWidget {
  const AlgoliaSearchScreen({Key? key}) : super(key: key);

  @override
  State<AlgoliaSearchScreen> createState() => _AlgoliaSearchScreenState();
}

class _AlgoliaSearchScreenState extends State<AlgoliaSearchScreen> {
  TextEditingController _searchText = TextEditingController(text: "");
  List<AlgoliaObjectSnapshot> _results = [];
  bool _searching = false;

  void _search() async {
    setState(() {
      _searching = true;
    });
    Algolia algolia = const Algolia.init(
      applicationId: 'MIXLQ70OML',
      apiKey: '110626843589be72cf0163bf9c36b01b',
    );

    AlgoliaQuery query = algolia.instance.index('destinations');
    query = query.query(_searchText.text);

    _results = (await query.getObjects()).hits;
    print("RESULT");
    print(_results);
    setState(() {
      _searching = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("Search"),
          TextField(
            controller: _searchText,
            decoration: InputDecoration(hintText: "Search query here..."),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              ElevatedButton(
                child: Text(
                  "Search",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: _search,
              ),
            ],
          ),
          Expanded(
            child: _searching == true
                ? Center(
                    child: Text("Searching, please wait..."),
                  )
                : _results.length == 0
                    ? Center(
                        child: Text("No results found."),
                      )
                    : ListView.builder(
                        itemCount: _results.length,
                        itemBuilder: (BuildContext ctx, int index) {
                          AlgoliaObjectSnapshot snap = _results[index];
                          return ListTile(
                            leading: CircleAvatar(
                              child: Text(
                                (index + 1).toString(),
                              ),
                            ),
                            title: Text(snap.data["name"]),
                            subtitle: Text(snap.data["region"]),
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }
}
