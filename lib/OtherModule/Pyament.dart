    import 'dart:io';
    import 'package:cloud_firestore/cloud_firestore.dart';
    import 'package:firebase_auth/firebase_auth.dart';
    import 'package:flutter/material.dart';
    import 'package:path_provider/path_provider.dart';
    import 'package:pdf/widgets.dart' as pw;
    import 'package:printing/printing.dart';
    import 'package:ticket_widget/ticket_widget.dart';

    class PaymentForm extends StatefulWidget {
      final Map<String, dynamic> flight;

      PaymentForm({required this.flight});

      @override
      _PaymentFormState createState() => _PaymentFormState();
    }

    class _PaymentFormState extends State<PaymentForm> {
      TextEditingController cardNumberController = TextEditingController();
      TextEditingController expiryDateController = TextEditingController();
      TextEditingController cvvController = TextEditingController();
      String selectedPaymentMethod = '';
      late User _currentUser;
      late Stream<QuerySnapshot<Map<String, dynamic>>> _userDataStream;
      String _userName = ''; // Variable to store the user name

      List<String> paymentMethods = [
        'Credit Card',
        'Debit Card',
        'PayPal',
        'Google Pay',
        'Apple Pay'
      ];

      @override
      void initState() {
        super.initState();
        if (paymentMethods.isNotEmpty) {
          selectedPaymentMethod = paymentMethods[0];
        }
        _getCurrentUser();
      }

      Future<void> _getCurrentUser() async {
        try {
          _currentUser = FirebaseAuth.instance.currentUser!;
          _userDataStream = FirebaseFirestore.instance
              .collection('users')
              .where('Email', isEqualTo: _currentUser.email)
              .snapshots();

          var userSnapshot = await FirebaseFirestore.instance
              .collection('users')
              .where('Email', isEqualTo: _currentUser.email)
              .get();

          if (userSnapshot.docs.isNotEmpty) {
            setState(() {
              _userName = userSnapshot.docs.first[
                  'Name']; // Assuming 'Name' is the field for the user's name
            });
          }
        } catch (e) {
          print('Error getting current user: $e');
        }
      }

      @override
      Widget build(BuildContext context) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Payment'),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Select Payment Method:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: DropdownButton<String>(
                      value: selectedPaymentMethod,
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedPaymentMethod = newValue ?? '';
                        });
                      },
                      items: paymentMethods.map((method) {
                        return DropdownMenuItem<String>(
                          value: method,
                          child: Text(method),
                        );
                      }).toList(),
                    ),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: cardNumberController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Card Number',
                      border: OutlineInputBorder(),
                    ),
                    enabled: selectedPaymentMethod.isNotEmpty,
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: expiryDateController,
                          keyboardType: TextInputType.datetime,
                          decoration: InputDecoration(
                            labelText: 'Expiry Date',
                            border: OutlineInputBorder(),
                          ),
                          enabled: selectedPaymentMethod.isNotEmpty,
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: TextFormField(
                          controller: cvvController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: 'CVV',
                            border: OutlineInputBorder(),
                          ),
                          enabled: selectedPaymentMethod.isNotEmpty,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      _showPaymentSuccessDialog();
                    },
                    child: Text('Make Payment'),
                  ),
                ],
              ),
            ),
          ),
        );
      }

      void _showPaymentSuccessDialog() async {
        try {
          var userSnapshot = await FirebaseFirestore.instance
              .collection('users')
              .where('Email', isEqualTo: _currentUser.email)
              .get();

          if (userSnapshot.docs.isNotEmpty) {
            setState(() {
              _userName = userSnapshot.docs.first[
                  'Name']; // Assuming 'Name' is the field for the user's name
            });
          }
        } catch (e) {
          print('Error fetching user data: $e');
        }

        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => Scaffold(
              appBar: AppBar(
                title: const Text('Payment Successful'),
              ),
              body: Ticket(flight: widget.flight, userName: _userName),
            ),
          ),
        );
      }
    }

    class Ticket extends StatelessWidget {
      final Map<String, dynamic> flight;
      final String userName;

      Ticket({required this.flight, required this.userName});

      @override
      Widget build(BuildContext context) {
        return Scaffold(
          backgroundColor: Colors.blueGrey,
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(18.0),
              child: Column(
                children: [
                  Text(
                    "YOUR TICKET",
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  Text(
                    "Thank you for buying a ticket\nSave your ticket below",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20),
                  Center(
                    child: TicketWidget(
                      color: Colors.green.shade200,
                      width: 450,
                      height: 600,
                      isCornerRounded: true,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.black,
                              radius: 55,
                              child: CircleAvatar(
                                backgroundColor: Colors.indigo,
                                radius: 50,
                              ),
                            ),
                            SizedBox(height: 20),
                            Text(
                              "Airline :  ${flight['airline']['name']}",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.location_on,
                                    color: Colors.grey, size: 18),
                                SizedBox(width: 5),
                                Text(
                                    "${flight['departure']['city']} - ${flight['arrival']['city']}"),
                              ],
                            ),
                            SizedBox(height: 20),
                            ticketDetails('Ticket Holder name', userName),
                            ticketDetails(
                                'Flight Number', '${flight['flight']['number']}'),
                            ticketDetails('Departure time',
                                "${flight['departure']['scheduled']}"),
                            ticketDetails('Arrival Time',
                                '${flight['arrival']['scheduled']}'),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.black,
                      backgroundColor: Colors.amber.shade200,
                      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      elevation: 3,
                    ),
                    child: Text("Save",
                        style:
                            TextStyle(fontSize: 15, fontWeight: FontWeight.w900)),
                  ),
                ],
              ),
            ),
          ),
        );
      }

      Widget ticketDetails(String title, dynamic details) => Column(
            children: [
              Text(
                title,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w900,
                  fontSize: 18,
                ),
              ),
              SizedBox(height: 5),
              Container(
                height: 30,
                width: 120,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Text(
                  details,
                  style: TextStyle(
                    fontSize: 15,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w600,
                    color: Colors.red,
                  ),
                ),
              ),
            ],
          );
    }
