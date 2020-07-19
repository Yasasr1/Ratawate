import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rasthiyaduwa_app/providers/destinations.dart';

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
    var destinationsList = destinations.destinations;

    return Scaffold(
      appBar: AppBar(
        title: Text("Destinations"),
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.purple,
              ),
            )
          : Container(
              child: ListView.builder(
                itemBuilder: (ctx, index) =>
                    Text(destinationsList[index].title),
                itemCount: destinationsList.length,
              ),
            ),
    );
  }
}
