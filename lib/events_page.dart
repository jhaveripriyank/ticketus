import 'package:flutter/material.dart';
import 'payment_page.dart';

class EventsPage extends StatelessWidget {
  final String club;
  final List<Event> events = [
    Event(
      name: 'Event A',
      date: 'May 5th, 2023',
      time: '8:00 PM',
      location: 'Club XYZ',
      image: 'assets/images/event_a_image.jpg',
    ),
    Event(
      name: 'Event B',
      date: 'June 10th, 2023',
      time: '9:30 PM',
      location: 'Club ABC',
      image: 'assets/images/event_a_image.jpg',
    ),
    Event(
      name: 'Event C',
      date: 'July 15th, 2023',
      time: '7:00 PM',
      location: 'Club PQR',
      image: 'assets/images/event_a_image.jpg',
    ),
    Event(
      name: 'Event D',
      date: 'August 20th, 2023',
      time: '10:00 PM',
      location: 'Club DEF',
      image: 'assets/images/event_a_image.jpg',
    ),
    Event(
      name: 'Event E',
      date: 'September 25th, 2023',
      time: '8:30 PM',
      location: 'Club GHI',
      image: 'assets/images/event_a_image.jpg',
    ),
  ];

  EventsPage(this.club);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Image.asset('assets/images/title.jpg', fit: BoxFit.contain),
        centerTitle: true,
      ),
      body: Container(
        color: Colors.black,
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: ListView.separated(
            separatorBuilder: (BuildContext context, int index) => Divider(),
            itemCount: events.length,
            itemBuilder: (BuildContext context, int index) {
              final event = events[index];
              return Card(
                color: Colors.black,
                child: ListTile(
                  leading: Image.asset(
                    event.image,
                    width: 60,
                    height: 60,
                  ),
                  title: Text(
                    event.name,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Date: ${event.date}',
                        style: TextStyle(
                          color: Colors.grey[600],
                        ),
                      ),
                      Text(
                        'Time: ${event.time}',
                        style: TextStyle(
                          color: Colors.grey[600],
                        ),
                      ),
                      Text(
                        'Location: ${event.location}',
                        style: TextStyle(
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: Colors.white,
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EventDetailsPage(event),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class EventDetailsPage extends StatefulWidget {
  final Event event;

  EventDetailsPage(this.event);

  @override
  _EventDetailsPageState createState() => _EventDetailsPageState();
}

class _EventDetailsPageState extends State<EventDetailsPage> {
  int _selectedPasses = 1;
  bool _isGroupBooking = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.event.name} Details'),
        backgroundColor: Colors.black87,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                ),
              ),
              child: Image.asset(widget.event.image),
            ),
            SizedBox(height: 16.0),
            Container(
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                ),
              ),
              child: Text(
                'Join us on ${widget.event.date} at ${widget.event.time} for a night of music and dancing at our exclusive club event! Get ready to move to the beats of top DJs and enjoy a variety of drinks at our fully stocked bar. Do not miss out on the fun - get your tickets now! For more information or to book your tickets, Organised By: John Doe; Contact: +91 1234567890',
              ),
            ),
            SizedBox(height: 16.0),
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                ),
              ),
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Number of Passes: '),
                  DropdownButton<int>(
                    value: _selectedPasses,
                    items: List.generate(25, (index) {
                      return DropdownMenuItem<int>(
                        value: index + 1,
                        child: Text('${index + 1}'),
                      );
                    }),
                    onChanged: (value) {
                      setState(() {
                        _selectedPasses = value ?? 1;
                      });
                    },
                  ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                ),
              ),
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Group Booking: '),
                  Switch(
                    value: _isGroupBooking,
                    onChanged: (value) {
                      setState(() {
                        _isGroupBooking = value;
                      });
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PaymentPage(
                      selectedPasses: _selectedPasses,
                      eventTitle: widget.event.name,
                    ),
                  ),
                );
              },
              child: Text('Book Tickets'),
            ),
          ],
        ),
      ),
    );
  }
}

class Event {
  final String name;
  final String date;
  final String time;
  final String location;
  final String image;

  Event({
    required this.name,
    required this.date,
    required this.time,
    required this.location,
    required this.image,
  });
}
