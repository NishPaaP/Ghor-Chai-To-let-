import 'package:flutter/material.dart';

class CheckOutScreen extends StatefulWidget {
  const CheckOutScreen({Key? key}) : super(key: key);

  @override
  _CheckOutScreenState createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String accountNumber = '';
  String accountName = '';
  double amount = 0.0;
  String? selectedCard;
  bool isPaymentSuccessful = false;

  List<String> paymentCards = [
    'https://cdn.icon-icons.com/icons2/1259/PNG/512/1495815261-jd08_84586.png',
    'https://cdn.icon-icons.com/icons2/1259/PNG/512/1495815236-jd07_84584.png',
    'https://cdn.icon-icons.com/icons2/1259/PNG/512/1495815276-jd05_84594.png',
    'https://cdn.icon-icons.com/icons2/1259/PNG/512/1495815234-jd03_84587.png',
  ];

  void makePayment() {
    if (_formKey.currentState!.validate()) {
      // Perform payment processing logic here
      // For the sake of example, we will simulate a successful payment after a delay
      Future.delayed(Duration(seconds: 2), () {
        setState(() {
          isPaymentSuccessful = true;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment Gateway'),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: isPaymentSuccessful
              ? Align(
                child: Center(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 180,
                      ),
                      CircleAvatar(
                        radius: 50,
                          backgroundColor: Colors.blue,
                          child: CircleAvatar(
                              radius: 48,
                              backgroundColor: Colors.white,
                              child: Icon(Icons.done,color: Colors.green,size: 60,))),
                      SizedBox(
                        height: 50,
                      ),
                      Text(
            'Payment Successful',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
                    ],
                  ),
                ),
              )
              : Column(
            children: [
              Container(
                width: 700,
                height: 60,

                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: paymentCards.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    final cardImageUrl = paymentCards[index];
                    final isSelected = selectedCard == cardImageUrl;

                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedCard = cardImageUrl;
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: 80,
                          height: 50,

                          decoration: BoxDecoration(
                            color: isSelected ? Colors.blue.withOpacity(0.8) : Colors.transparent,

                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(color: Colors.blue)

                            
                          ),
                          child: Image.network(cardImageUrl),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter the  account number';
                            }
                            return null;
                          },
                          onChanged: (value) {
                            setState(() {
                              accountNumber = value;
                            });
                          },
                          decoration: InputDecoration(
                            labelText: 'Account Number',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        SizedBox(height: 16.0),
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter the account name';
                            }
                            return null;
                          },
                          onChanged: (value) {
                            setState(() {
                              accountName = value;
                            });
                          },
                          decoration: InputDecoration(
                            labelText: 'Account Name',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        SizedBox(height: 16.0),
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter the amount';
                            }
                            if (double.tryParse(value) == null) {
                              return 'Please enter a valid amount';
                            }
                            return null;
                          },
                          onChanged: (value) {
                            setState(() {
                              amount = double.tryParse(value) ?? 0.0;
                            });
                          },
                          decoration: InputDecoration(
                            labelText: 'Amount',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        SizedBox(height: 16.0),


                        SizedBox(height: 16.0),
                        ElevatedButton(
                          onPressed: makePayment,
                          style: ElevatedButton.styleFrom(
                            primary: Colors.blue,
                            padding: EdgeInsets.symmetric(
                              horizontal: 32,
                              vertical: 16,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Text(
                            'Make Payment',
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
