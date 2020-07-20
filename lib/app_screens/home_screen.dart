import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rasthiyaduwa_app/providers/destinations.dart';
import 'package:rasthiyaduwa_app/widgets/destination_item.dart';
import './side_drawer.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var _isLoading = false;

  @override
  void initState() {
    setState(() {
      _isLoading = true;
    });
    Future.delayed(Duration.zero).then((_) {
      Provider.of<Destinations>(context).fetchDestinations().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var destinations = Provider.of<Destinations>(context);
    var destinationsList = destinations.getDestinations;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: TextField(
          decoration: InputDecoration(
              hintText: "Search Destination",
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.purpleAccent),
                borderRadius: BorderRadius.all(
                  Radius.circular(40),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.purple),
                borderRadius: BorderRadius.all(
                  Radius.circular(40),
                ),
              ),
              isDense: true,
              contentPadding: EdgeInsets.all(8)),
        ),
        iconTheme: new IconThemeData(color: Colors.purple),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
            color: Colors.purple,
          ),
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {},
            color: Colors.purple,
          ),
        ],
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.purple,
              ),
            )
          : Container(
              child: ListView.builder(
                itemBuilder: (ctx, index) => DestinationItem(
                    destinationsList[index].title,
                    destinationsList[index].imageUrls[0]['url'],
                    destinationsList[index].city,
                    destinationsList[index].likedUsers.length),
                itemCount: destinationsList.length,
              ),
            ),
      drawer: SideDrawer(),
    );
  }
}
