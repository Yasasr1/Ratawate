import 'package:flutter/material.dart';
import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:provider/provider.dart';

import 'package:rasthiyaduwa_app/providers/destinations.dart';

class FilterModal extends StatefulWidget {
  @override
  _FilterModalState createState() => _FilterModalState();
}

class _FilterModalState extends State<FilterModal> {
  String type;
  String district;

  void setDestinationFilters(String district, String type) {
    Provider.of<Destinations>(context, listen: false)
        .setFilters(type, district);
    Navigator.of(context).pop();
  }

  @override
  void initState() {
    Future.delayed(Duration.zero).then((_) {
      type = Provider.of<Destinations>(context).getType();
      district = Provider.of<Destinations>(context).getDistrict();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.7,
      height: 330,
      padding: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            "Filter Destinations",
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.grey),
          ),
          Divider(),
          Text("By district"),
          Padding(
            padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
            child: DropDownFormField(
              titleText: 'District',
              hintText: 'Please choose one',
              value: district,
              onSaved: (value) {
                setState(() {
                  district = value;
                });
              },
              onChanged: (value) {
                setState(() {
                  district = value;
                });
              },
              dataSource: [
                {
                  "display": "All",
                  "value": "All",
                },
                {
                  "display": "Ampara",
                  "value": "Ampara",
                },
                {
                  "display": "Anuradhapura",
                  "value": "Anuradhapura",
                },
                {
                  "display": "Badulla",
                  "value": "Badulla",
                },
                {
                  "display": "Batticaloa",
                  "value": "Batticaloa",
                },
                {
                  "display": "Colombo",
                  "value": "Colombo",
                },
                {
                  "display": "Galle",
                  "value": "Galle",
                },
                {
                  "display": "Gampaha",
                  "value": "Gampaha",
                },
                {
                  "display": "Hambantota",
                  "value": "Hambantota",
                },
                {
                  "display": "Jaffna",
                  "value": "Jaffna",
                },
                {
                  "display": "Kalutara",
                  "value": "Kalutara",
                },
                {
                  "display": "Kandy",
                  "value": "Kandy",
                },
                {
                  "display": "Kegalle",
                  "value": "Kegalle",
                },
                {
                  "display": "Kilinochchi",
                  "value": "Kilinochchi",
                },
                {
                  "display": "Kurunegala",
                  "value": "Kurunegala",
                },
                {
                  "display": "Mannar",
                  "value": "Mannar",
                },
                {
                  "display": "Matale",
                  "value": "Matale",
                },
                {
                  "display": "Matara",
                  "value": "Matara",
                },
                {
                  "display": "Monaragala",
                  "value": "Monaragala",
                },
                {
                  "display": "Mullaitivu",
                  "value": "Mullaitivu",
                },
                {
                  "display": "NuwaraEliya",
                  "value": "NuwaraEliya",
                },
                {
                  "display": "Polonnaruwa",
                  "value": "Polonnaruwa",
                },
                {
                  "display": "Puttalam",
                  "value": "Puttalam",
                },
                {
                  "display": "Ratnapura",
                  "value": "Ratnapura",
                },
                {
                  "display": "Trincomalee",
                  "value": "Trincomalee",
                },
                {
                  "display": "Vavuniya",
                  "value": "Vavuniya",
                },
              ],
              textField: 'display',
              valueField: 'value',
            ),
          ),
          Text("By Destination Type"),
          Container(
            padding: EdgeInsets.only(bottom: 5, top: 5),
            child: DropDownFormField(
              titleText: 'Type',
              value: type,
              onSaved: (value) {
                setState(() {
                  type = value;
                });
              },
              onChanged: (value) {
                setState(() {
                  type = value;
                });
              },
              dataSource: [
                {
                  "display": "All",
                  "value": "All",
                },
                {
                  "display": "Beach",
                  "value": "Beach",
                },
                {
                  "display": "Hiking",
                  "value": "Hiking",
                },
                {
                  "display": "Historical",
                  "value": "Historical",
                },
                {
                  "display": "Nature",
                  "value": "Nature",
                },
                {
                  "display": "Park",
                  "value": "Park",
                },
                {
                  "display": "Religious",
                  "value": "Religious",
                },
                {
                  "display": "Water",
                  "value": "Water",
                },
                {
                  "display": "Waterfall",
                  "value": "Waterfall",
                },
              ],
              textField: 'display',
              valueField: 'value',
            ),
          ),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: RaisedButton(
              child: Text(
                "Set Filters",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                setDestinationFilters(district, type);
              },
              color: Colors.purple,
            ),
          )
        ],
      ),
    );
  }
}
