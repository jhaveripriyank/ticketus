import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String username = "John Doe"; // Replace with user's actual username
  List<Event> upcomingEvents = [
    Event(eventName: 'Event 1', date: DateTime(2023, 6, 15)),
    Event(eventName: 'Event 2', date: DateTime(2023, 6, 20)),
    Event(eventName: 'Event 3', date: DateTime(2023, 6, 25)),
  ];
  List<Event> previousEvents = [];
  bool showEventList = false;
  bool showPreviousEventList = false;

  List<String> cities = [
    'Bangalore',
    'Mumbai',
    'Chennai',
    'Delhi',
  ];

  String selectedCity = 'Mumbai';
  String selectedArtist = '';
  DateTime? selectedDate;
  String? selectedImage; // New variable for selected image

  void addEvent() {
    if (selectedArtist.isNotEmpty && selectedDate != null && selectedImage != null) {
      Event newEvent = Event(
        eventName: selectedArtist,
        date: selectedDate!,
        image: selectedImage!, // Pass selected image to the event
      );
      upcomingEvents.add(newEvent);

      setState(() {
        selectedArtist = '';
        selectedDate = null;
        selectedImage = null; // Clear selected image
      });
    }
  }

  void deleteEvent(Event event) {
    setState(() {
      upcomingEvents.remove(event);
    });
  }

  void checkPastEvents() {
    DateTime currentDate = DateTime.now();
    List<Event> pastEvents = [];

    upcomingEvents.removeWhere((event) {
      if (event.date.isBefore(currentDate)) {
        pastEvents.add(event);
        return true;
      }
      return false;
    });

    previousEvents.addAll(pastEvents);
  }

  @override
  void initState() {
    super.initState();
    checkPastEvents();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Container(
        color: Colors.black, // Set background color to black
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Welcome, $username!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white, // Set text color to white
                ),
              ),
              SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  setState(() {
                    showEventList = !showEventList;
                  });
                },
                child: Text(
                  'Upcoming Events: ${upcomingEvents.length}',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white, // Set text color to white
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              if (showEventList) ...[
                SizedBox(height: 10),
                Container(
                  height: 100,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: upcomingEvents.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EventDetailsPage(
                                event: upcomingEvents[index],
                              ),
                            ),
                          );
                        },
                        child: Container(
                          width: 150,
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                upcomingEvents[index].eventName,
                                style: TextStyle(
                                  color: Colors.white, // Set text color to white
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                upcomingEvents[index].date.toString(),
                                style: TextStyle(
                                  color: Colors.white, // Set text color to white
                                ),
                              ),
                              SizedBox(height: 5),
                              GestureDetector(
                                onTap: () {
                                  deleteEvent(upcomingEvents[index]);
                                },
                                child: Icon(
                                  Icons.delete,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
              SizedBox(height: 10),
              GestureDetector(
                onTap: () {
                  setState(() {
                    showPreviousEventList = !showPreviousEventList;
                  });
                },
                child: Text(
                  'Previous Events: ${previousEvents.length}',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white, // Set text color to white
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              if (showPreviousEventList) ...[
                SizedBox(height: 10),
                Container(
                  height: 100,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: previousEvents.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EventDetailsPage(
                                event: previousEvents[index],
                              ),
                            ),
                          );
                        },
                        child: Container(
                          width: 150,
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                previousEvents[index].eventName,
                                style: TextStyle(
                                  color: Colors.white, // Set text color to white
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                previousEvents[index].date.toString(),
                                style: TextStyle(
                                  color: Colors.white, // Set text color to white
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Add Event'),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            DropdownButton<String>(
                              value: selectedCity,
                              items: cities.map((String city) {
                                return DropdownMenuItem<String>(
                                  value: city,
                                  child: Text(city),
                                );
                              }).toList(),
                              onChanged: (String? value) {
                                setState(() {
                                  selectedCity = value!;
                                });
                              },
                            ),
                            TextField(
                              onChanged: (value) {
                                setState(() {
                                  selectedArtist = value;
                                });
                              },
                              decoration: InputDecoration(
                                labelText: 'Artist',
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime(2024),
                                ).then((DateTime? date) {
                                  setState(() {
                                    selectedDate = date;
                                  });
                                });
                              },
                              child: Text('Select Date'),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                // Add logic to upload image here
                              },
                              child: Text('Upload Image'),
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
                              addEvent();
                              Navigator.of(context).pop();
                            },
                            child: Text('Add'),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: Text('Add Event'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Event {
  String eventName;
  DateTime date;
  String? image; // New property for image

  Event({required this.eventName, required this.date, this.image});
}

class EventDetailsPage extends StatelessWidget {
  final Event event;

  EventDetailsPage({required this.event});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Event Details'),
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                event.eventName,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                event.date.toString(),
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              SizedBox(height: 10),
              if (event.image != null)
                Image.network(
                  event.image!,
                  width: 150,
                  height: 150,
                  fit: BoxFit.cover,
                ),
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: ProfilePage(),
  ));
}
