import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class AdminPage extends StatefulWidget {
  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  final TextEditingController _clubNameController = TextEditingController();
  final TextEditingController _eventNameController = TextEditingController();
  late File _imageFile;

  // Dummy data lists for clubs and events
  List<String> _clubs = ['Club A', 'Club B', 'Club C'];
  List<Map<String, dynamic>> _events = [
    {
      'name': 'Event 1',
      'imageUrl': 'https://unsplash.com/photos/ZODcBkEohk8',
      'footfall': 50,
      'ticketsBought': 10,
    },
    {
      'name': 'Event 2',
      'imageUrl': 'https://dummy-url.com/event2.jpg',
      'footfall': 100,
      'ticketsBought': 20,
    },
  ];

  void _showAddClubDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add New Club'),
          content: TextField(
            controller: _clubNameController,
            decoration: InputDecoration(labelText: 'Club Name'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                _addClub();
                Navigator.of(context).pop();
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }

  void _addClub() {
    final clubName = _clubNameController.text;
    if (clubName.isNotEmpty) {
      setState(() {
        _clubs.add(clubName);
      });
    }
  }

  void _showAddEventDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add New Event with Image'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _imageFile == null
                  ? ElevatedButton(
                onPressed: () {
                  _getImage();
                },
                child: Text('Select Image'),
              )
                  : Image.file(_imageFile),
              TextField(
                controller: _eventNameController,
                decoration: InputDecoration(labelText: 'Event Name'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                _addEventWithImage();
                Navigator.of(context).pop();
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }

  void _getImage() async {
    final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _imageFile = File(pickedImage.path);
      });
    }
  }

  void _addEventWithImage() {
    final eventName = _eventNameController.text;
    if (eventName.isNotEmpty) {
      setState(() {
        _events.add({
          'name': eventName,
          'imageUrl': 'https://dummy-url.com/event-image.jpg',
          'footfall': 0,
          'ticketsBought': 0,
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Page'),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Clubs',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            Divider(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: _clubs.map((club) {
                return Text(
                  club,
                  style: TextStyle(color: Colors.white),
                );
              }).toList(),
            ),
            SizedBox(height: 16.0),

            Text(
              'Events',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            Divider(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: _events.map((event) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Event: ${event['name']}',
                      style: TextStyle(color: Colors.white),
                    ),
                    Text(
                      'Footfall: ${event['footfall']}',
                      style: TextStyle(color: Colors.white),
                    ),
                    Text(
                      'Tickets Bought: ${event['ticketsBought']}',
                      style: TextStyle(color: Colors.white),
                    ),
                    Divider(),
                  ],
                );
              }).toList(),
            ),
            SizedBox(height: 16.0),

            ElevatedButton(
              onPressed: () {
                _showAddClubDialog();
              },
              child: Text('Add New Club'),
            ),
            SizedBox(height: 16.0),

            ElevatedButton(
              onPressed: () {
                _showAddEventDialog();
              },
              child: Text('Add New Event with Image'),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: AdminPage(),
  ));
}
