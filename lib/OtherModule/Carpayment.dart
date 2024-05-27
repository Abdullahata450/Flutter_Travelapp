import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ticket_widget/ticket_widget.dart';

import '../theams/Sendbookingmsg.dart';

class PaymentForm extends StatefulWidget {
  final Map<String, dynamic> car;

  PaymentForm({required this.car});

  @override
  _PaymentFormState createState() => _PaymentFormState();
}

class _PaymentFormState extends State<PaymentForm> {
  int days = 1;
  late User _currentUser;
  late Stream<QuerySnapshot<Map<String, dynamic>>> _userDataStream;
  String _userName = '';

  @override
  void initState() {
    super.initState();
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
    int price = widget.car["price"];
    int totalPrice = price * days;

    return Scaffold(
      appBar: AppBar(
        title: Text("Details"),
        backgroundColor: Colors.amber.shade100,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.car["name"],
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text("Price per day: Rs${price.toString()}"),
            SizedBox(height: 10),
            Row(
              children: [
                Text(
                  "Number of days: ",
                  style: TextStyle(fontSize: 16),
                ),
                DropdownButton<int>(
                  value: days,
                  items: List.generate(30, (index) => index + 1)
                      .map((e) => DropdownMenuItem<int>(
                    value: e,
                    child: Text(e.toString()),
                  ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      days = value!;
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 10),
            Text(
              "Total Price: Rs${totalPrice.toString()}.",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black,
                  backgroundColor: Colors.amber.shade200,
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  elevation: 3,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CardForm(
                        car: widget.car,
                        userName: _userName,
                        days: days,
                      ),
                    ),
                  );
                },
                child: Text(
                  "Make Payment Now",
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CardForm extends StatefulWidget {               // In this Where User can Enter his or her Card Details to make Purchase
  final Map<String, dynamic> car;
  final String userName;
  final int days;

  CardForm({required this.car, required this.userName,required this.days});

  @override
  _CardFormState createState() => _CardFormState();
}

class _CardFormState extends State<CardForm> {
  TextEditingController cardNumberController = TextEditingController();
  TextEditingController expiryDateController = TextEditingController();
  TextEditingController cvvController = TextEditingController();
  List<String> paymentMethods = ["Credit Card", "Debit Card", "Net Banking"];

  late String selectedPaymentMethod;

  @override
  void initState() {
    super.initState();
    selectedPaymentMethod = paymentMethods.isNotEmpty ? paymentMethods.first : '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment'),
        backgroundColor: Colors.amber.shade100,
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
                      selectedPaymentMethod = newValue!;
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
                  String msg="Hello ${widget.userName} 👋\n🌟 Congratulations on booking your car! 🌟 \n Thank you for choosing our service. We're thrilled to have you on board and look forward to making your journey comfortable and enjoyable \n 🚗 Car Details:\n ${widget.car['name']} \n For any Qurries Contact abdullahbinata450@gmail.com ";
                  sendbookMessage(msg);
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => Ticket(
                        car: widget.car,
                        userName: widget.userName, days: widget.days,
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black,
                  backgroundColor: Colors.amber.shade200,
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  elevation: 3,
                ),
                child: Text('Make Payment'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Ticket extends StatelessWidget {        // after Payament Ticket will genrated
  final Map<String, dynamic> car;
  final String userName;
  final int days;

  Ticket({required this.car, required this.userName, required this.days});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ticket'),
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
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
                "Thank you for renting a car\nSave your ticket below",
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
                  height: 500,
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
                        Icon(Icons.car_rental, color: Colors.black, size: 50),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(width: 5),
                            Text(
                              "${car['name']}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        ),
                        ticketDetails('Ticket Holder Name', userName),
                        ticketDetails('Valid For', '$days days'), // Display days
                        ticketDetails('Total Price', 'Rs${car['price'] * days}'), // Calculate total price based on days
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Save or perform other actions
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black,
                  backgroundColor: Colors.amber.shade200,
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  elevation: 3,
                ),
                child: Text('Save Ticket'),
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
