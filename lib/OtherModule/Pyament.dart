import 'package:flutter/material.dart';

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
  String selectedPaymentMethod = ''; // Initialize with an empty string

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
    // Set selectedPaymentMethod to the first item in paymentMethods list
    if (paymentMethods.isNotEmpty) {
      selectedPaymentMethod = paymentMethods[0];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment'),
      ),
      body: Center(
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
                enabled: selectedPaymentMethod
                    .isNotEmpty, // Enable only if payment method is selected
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
                      enabled: selectedPaymentMethod
                          .isNotEmpty, // Enable only if payment method is selected
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
                      enabled: selectedPaymentMethod
                          .isNotEmpty, // Enable only if payment method is selected
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

  void _showPaymentSuccessDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Payment Successful'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Thank you for your payment!'),
            SizedBox(height: 10),
            Text('Airline: ${widget.flight['airline']['name']}'),
            Text('Flight Number: ${widget.flight['flight']['number']}'),
            Text('Departure Time: ${widget.flight['departure']['scheduled']}'),
            Text('Arrival Time: ${widget.flight['arrival']['scheduled']}'),
            Text('Price: \$16500'),
          ],
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
