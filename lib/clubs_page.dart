import 'package:flutter/material.dart';
import 'package:ticketus/events_page.dart';


class ClubsPage extends StatelessWidget {
  final String? selectedCity; // made nullable
  final String? City;         // made nullable
  final String? Artist;       // made nullable
  final List<String> clubs = ['Club A', 'Club B', 'Club C', 'Club D', 'Club E', 'Club F', 'Club G', 'Club H', 'Club I', 'Club J'];
  ClubsPage(this.selectedCity, {super.key, this.City, this.Artist});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Clubs in $selectedCity'),
        backgroundColor: Colors.black,
      ),
      body: Container(
        color: Colors.black,
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: ListView.builder(
            itemCount: clubs.length,
            itemBuilder: (BuildContext context, int index) {
              final club = clubs[index];
              final imageAsset = 'assets/images/club${index + 1}.jpg'; // Assuming you have images named club1.jpg, club2.jpg, club3.jpg, etc.

              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => EventsPage(club)),
                  );
                },
                child: Card(
                  color: Colors.black,
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: double.infinity,
                          height: 120.0,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(imageAsset),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(height: 16.0),
                        Text(
                          club,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8.0),
                        Text(
                          'Club description or additional details',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
