import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import 'Data/DataBase.dart';
import 'Data/DataModel.dart'; // for date formatting

class HistoryScreen extends StatefulWidget {
  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  List<LocationPoint> _locations = [];

  @override
  void initState() {
    super.initState();
    _fetchHistory();
  }

  Future<void> _fetchHistory() async {
    _locations = await LocationDbHelper.getAllLocations();
    setState(() {});
  }

  void _onHistoryItemTap(int index) {
    final location = _locations[index];
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Location Details'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Date: ${DateFormat.yMMMd().format(location.timestamp)}'),
            Text('Time: ${DateFormat.Hm().format(location.timestamp)}'),
            Text('Latitude: ${location.latitude.toStringAsFixed(6)}'),
            Text('Longitude: ${location.longitude.toStringAsFixed(6)}'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
          TextButton(
            onPressed: () {
              // Handle delete confirmation and delete entry from DB
              _deleteLocation(index);
              Navigator.pop(context);
            },
            child: const Text(
              'Delete',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
  void _openLocationInExternalMap(double latitude, double longitude) async {
    final url = 'geo:$latitude,$longitude'; // Generic map URL format
      await launchUrl(Uri.parse(url));
  }
  Future<void> _deleteLocation(int index) async {
    setState(() {
      _locations.removeAt(index);
    });

    final int? deletedId = await LocationDbHelper.deleteLocation(index);
    if (deletedId != null) {
      print('Deleted location with ID: $deletedId');
    } else {
      print('Error deleting location from database');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('History'),
      ),
      body: _locations.isEmpty
          ? Center(child: Text('No location history found.'))
          : ListView.builder(
        itemCount: _locations.length,
        itemBuilder: (context, index) {
          final location = _locations[index];
          return ListTile(
            title: Text('${DateFormat.yMMMd().format(location.timestamp)} - ${DateFormat.Hm().format(location.timestamp)}'),
            subtitle: Text('Lat: ${location.latitude.toStringAsFixed(6)}, Lng: ${location.longitude.toStringAsFixed(6)}'),
            trailing: IconButton(
              icon: Icon(Icons.more_vert),
              onPressed: () => _onHistoryItemTap(index),
            ),
            onTap: () {
              _openLocationInExternalMap( location.latitude, location.longitude);
            },
          );
        },
      ),
    );
  }
}
