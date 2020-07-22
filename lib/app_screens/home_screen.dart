import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rasthiyaduwa_app/providers/destinations.dart';
import 'package:rasthiyaduwa_app/widgets/destination_item.dart';
import 'package:rasthiyaduwa_app/widgets/filter_modal.dart';
import './side_drawer.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var _isLoading = false;
  String searchTerm;

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

  void showFilterModal(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (bctx) {
          return FilterModal();
        });
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
          onChanged: (value) {
            setState(() {
              searchTerm = value;
            });
          },
          decoration: InputDecoration(
              hintText: "Search Destination",
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none),
              filled: true,
              fillColor: Colors.black12,
              isDense: true,
              contentPadding: EdgeInsets.all(8)),
        ),
        iconTheme: new IconThemeData(color: Colors.purple),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              Provider.of<Destinations>(context).setSearchTerm(searchTerm);
            },
            color: Colors.purple,
          ),
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {
              showFilterModal(context);
            },
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
                    destinationsList[index].id,
                    destinationsList[index].title,
                    destinationsList[index].imageUrls[0],
                    destinationsList[index].city,
                    destinationsList[index].likedUsers.length),
                itemCount: destinationsList.length,
              ),
            ),
      drawer: SideDrawer(),
    );
  }
}
