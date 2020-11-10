import 'package:flutter/material.dart';
//import 'package:search_app_bar/search_app_bar.dart';
import 'package:dockmate/pages/posting.dart';
import 'package:dockmate/pages/posting_form.dart';
import 'package:dockmate/model/listing.dart';
import 'package:dockmate/utils/bottombar.dart';
import 'package:dockmate/utils/util.dart';

class Listings extends StatefulWidget {
  final String title;

  Listings({Key key, this.title}) : super(key: key);

  @override
  _ListingState createState() => _ListingState();
}

class _ListingState extends State<Listings> {
  int _selectedIndex;
  List<Listing> _listings;
  Listing _listing = new Listing();

  @override
  void initState() {
    super.initState();
    reload();
  }

  void reload() {
    _listing.getAllListings().then((grades) {
      setState(() {
        _listings = grades;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    //inal Filter filter;
    return Scaffold(
      appBar: AppBar(
        title: Text('Listings'),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                _addListing(context);
              })
        ],
      ) /*SearchAppBar<String>(
        title: Text('Listings'),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                _addListing(context);
              })
        ],
        searcher: Filter([]),
      )*/
      ,
      body: ListView.builder(
        itemCount: _listings != null ? _listings.length : 0,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedIndex = index;
                _openListing(context);
              });
            },
            child: Container(
                decoration: BoxDecoration(
                  color: index == _selectedIndex ? Colors.blue : Colors.white,
                ),
                child: ListTile(title: buildListRow(_listings[index], true))),
          );
        },
      ),
      bottomNavigationBar: BottomBar(bottomIndex: 0),
    );
  }

  Future<void> _addListing(BuildContext context) async {
    var list = await Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => PostingForm(title: 'Add Listing')));

    await _listing.insert(list);
    reload();
  }

  Future<void> _openListing(BuildContext context) async {
    await Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => Posting(title: '')));
    _selectedIndex = -1;
    reload();
  }
}
