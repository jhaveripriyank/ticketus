import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:ticketus/authentication.dart';
import 'package:ticketus/clubs_page.dart';
import 'package:ticketus/profile_page.dart';
import 'package:ticketus/bouncer_page.dart';
import 'admin_page.dart';

class Event {
  final String imagePath;
  bool isLiked;
  bool isReminderSet;

  Event({
    required this.imagePath,
    this.isLiked = false,
    this.isReminderSet = false,
  });
}
final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

void onQRViewCreated(QRViewController controller) {
  controller.scannedDataStream.listen((scanData) {
    // Handle the scanned QR code data here
    print(scanData);
    controller.dispose(); // Dispose the controller after scanning
  });
}


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final List<String> cities = ['Mumbai', 'Delhi', 'Bangalore', 'Chennai'];
  String? selectedCity;
  String? selectedArtist;
  bool isArtistSelected = false;

  List<String> artists = [
    'Artist 1',
    'Artist 2',
    'Artist 3',
    'Artist 4',
  ];

  List<Event> events = List.generate(
    5,
        (index) => Event(
      imagePath: 'assets/images/gallery_$index.jpg',
    ),
  );

  Widget buildDropdownMenu() {
    return DropdownButton<String>(
      value: selectedCity,
      hint: Text(
        'Select a city',
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      onChanged: (String? value) {
        setState(() {
          selectedCity = value;
        });
      },
      style: TextStyle(
        color: Colors.black,
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
      ),
      icon: Icon(
        Icons.arrow_drop_down,
        color: Colors.white,
      ),
      dropdownColor: Colors.grey[800],
      elevation: 0,
      underline: Container(
        height: 2,
        color: Colors.white,
      ),
      items: cities.map((city) {
        return DropdownMenuItem<String>(
          value: city,
          child: Text(
            city,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget buildArtistWidget(String artist) {
    bool isSelected = selectedArtist == artist;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedArtist = artist;
          isArtistSelected = true;
        });
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        margin: EdgeInsets.only(right: 8.0),
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? Colors.white : Colors.transparent,
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(100),
        ),
        child: Column(
          children: [
            CircleAvatar(
              backgroundImage: AssetImage('assets/images/Selena.jpg'),
              radius: 40.0,
            ),
            SizedBox(height: 8.0),
            Text(
              artist,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void scanQRCode() {
    // Implement the QR code scanning functionality
    // You can use any QR code scanning library or implement it manually
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer();
          },
        ),
        title: Image.asset(
          'assets/images/title.jpg',
          fit: BoxFit.contain,
          height: 30.0, // Adjust the height as needed
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
        elevation: 0.0,
      ),
      drawer: Drawer(
        child: Container(
          color: Colors.black, // Set the background color of the drawer
          child: ListView(
            children: [
              ListTile(
                leading: Icon(Icons.home, color: Colors.white), // Add home icon
                title: Text(
                  'HOME',
                  style: TextStyle(
                    color: Colors.white, // Set the text color of the option
                  ),
                ),
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => HomePage()),
                  );
                  // Handle home navigation
                },
              ),
              ListTile(
                leading: Icon(Icons.info, color: Colors.white), // Add about icon
                title: Text(
                  'ABOUT',
                  style: TextStyle(
                    color: Colors.white, // Set the text color of the option
                  ),
                ),
                onTap: () {
                  // Handle about navigation
                },
              ),
              ListTile(
                leading: Icon(Icons.search, color: Colors.white), // Add search icon
                title: Text(
                  'SEARCH',
                  style: TextStyle(
                    color: Colors.white, // Set the text color of the option
                  ),
                ),
                onTap: () {
                  // Handle search navigation
                },
              ),
              ListTile(
                leading: Icon(Icons.login, color: Colors.white), // Add login icon
                title: Text(
                  'LOGIN',
                  style: TextStyle(
                    color: Colors.white, // Set the text color of the option
                  ),
                ),
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => AuthenticationPage()),
                  );
                  // Handle login navigation
                },
              ),
              ListTile(
                leading: Icon(Icons.man_2_rounded, color: Colors.white), // Add login icon
                title: Text(
                  'PROFILE',
                  style: TextStyle(
                    color: Colors.white, // Set the text color of the option
                  ),
                ),
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => ProfilePage()),
                  );
                  // Handle login navigation
                },
              ),
              ListTile(
                leading: Icon(Icons.qr_code, color: Colors.white), // Add QR code icon
                title: Text(
                  'Bouncer',
                  style: TextStyle(
                    color: Colors.white, // Set the text color of the option
                  ),
                ),
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => QRCodeScannerPage()),
                  );

                },
              ),
              ListTile(
                leading: Icon(Icons.admin_panel_settings_rounded, color: Colors.white), // Add QR code icon
                title: Text(
                  'Admin',
                  style: TextStyle(
                    color: Colors.white, // Set the text color of the option
                  ),
                ),
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => AdminPage()),
                  );

                },
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome!',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: buildDropdownMenu(),
                ),
                SizedBox(width: 16.0),
                Expanded(
                  flex: 1,
                  child: ElevatedButton(
                    onPressed: () {
                      if (selectedCity != null || selectedArtist != null) { // Check if at least one is selected
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ClubsPage(
                              selectedCity,
                              City: selectedCity,
                              Artist: selectedArtist,
                            ),
                          ),
                        );
                      } else {
                        // Optional: show an error message if you'd like.
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Please select either a city or an artist.')),
                        );
                      }
                    },
                    child: Text('Explore Clubs'),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.grey[800]),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.0),
            Text(
              'Popular Artists',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: artists.map((artist) {
                  return buildArtistWidget(artist);
                }).toList(),
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'Upcoming Events',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: events.map((event) {
                  return Container(
                    margin: EdgeInsets.only(right: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            Container(
                              width: 200.0,
                              height: 300.0,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                                border: Border.all(
                                  color: Colors.white,
                                  width: 2.0,
                                ),
                              ),
                              child: GestureDetector(
                                onTap: () {
                                  // Handle image tap
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: Image.asset(
                                    event.imagePath,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 16.0,
                              left: 16.0,
                              child: IconButton(
                                icon: Icon(
                                  event.isLiked
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color: Colors.red,
                                  size: 32.0, // Increase the icon size
                                ),
                                onPressed: () {
                                  setState(() {
                                    event.isLiked = !event.isLiked;
                                  });
                                },
                              ),
                            ),
                            Positioned(
                              bottom: 16.0,
                              right: 16.0,
                              child: IconButton(
                                icon: Icon(
                                  event.isReminderSet
                                      ? Icons.notifications
                                      : Icons.notifications_none,
                                  color: Colors.blue,
                                  size: 32.0, // Increase the icon size
                                ),
                                onPressed: () {
                                  setState(() {
                                    event.isReminderSet =
                                    !event.isReminderSet;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8.0),
                        Text(
                          'Event Name',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4.0),
                        Text(
                          'Event Date',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.0,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}