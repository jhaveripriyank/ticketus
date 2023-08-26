import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class PaymentPage extends StatelessWidget {
  final int selectedPasses;
  final String eventTitle;

  PaymentPage({required this.selectedPasses, required this.eventTitle});

  Future<void> processPayment(BuildContext context) async {
    // Simulating payment processing delay
    await Future.delayed(Duration(seconds: 2));

    // Simulating payment success
    bool paymentSuccess = true;

    if (paymentSuccess) {
      // Generate receipt data
      String bookingId = generateBookingId();
      String qrCodeData = generateQRCodeData(bookingId);

      // Navigate to the success page
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PaymentSuccessPage(
            bookingId: bookingId,
            qrCodeData: qrCodeData,
          ),
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Payment Failed'),
            content: Text('Sorry, your payment failed.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  String generateBookingId() {
    // Generate a dummy booking ID
    return 'BOOKING-${DateTime.now().millisecondsSinceEpoch}';
  }

  String generateQRCodeData(String bookingId) {
    // Include additional data in the QR code if needed
    return 'Booking ID: $bookingId\nEvent: $eventTitle\nPasses: $selectedPasses';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment'),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.blueGrey,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'You have booked $selectedPasses passes for $eventTitle',
              style: TextStyle(fontSize: 24),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                processPayment(context);
              },
              child: Text('Make Payment'),
            ),
          ],
        ),
      ),
    );
  }
}

class PaymentSuccessPage extends StatelessWidget {
  final String bookingId;
  final String qrCodeData;

  PaymentSuccessPage({required this.bookingId, required this.qrCodeData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment Successful'),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.blueGrey,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Your payment was successfully processed.',
              style: TextStyle(fontSize: 24),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16),
            Text('Booking ID: $bookingId'),
            SizedBox(height: 16),
            QrImageView(
              data: qrCodeData,
              version: QrVersions.auto,
              size: 200.0,
            ),
          ],
        ),
      ),
    );
  }
}
