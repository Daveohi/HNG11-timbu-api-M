import 'package:flutter/material.dart';

class CustomerInfoForm extends StatefulWidget {
  const CustomerInfoForm({super.key});

  @override
  State<CustomerInfoForm> createState() => _CustomerInfoFormState();
}

class _CustomerInfoFormState extends State<CustomerInfoForm> {
  final _formKey = GlobalKey<FormState>();
  String paymentOption = 'Card';
  bool isCardPayment = true;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('First Name*', style: TextStyle(color: Colors.black)),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'First Name*',
                border: OutlineInputBorder(),
              ),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your first name';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            const Text('Last Name*', style: TextStyle(color: Colors.black)),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Last Name*',
                border: OutlineInputBorder(),
              ),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your last name';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            const Text('Email Address*', style: TextStyle(color: Colors.black)),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Email Address*',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your email address';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            const Text('Phone number*', style: TextStyle(color: Colors.black)),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Phone number*',
                prefixIcon: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(width: 8),
                    Text(
                      'NG',
                      style: TextStyle(color: Colors.black, fontSize: 15),
                    ),
                    Icon(Icons.arrow_drop_down),
                    Text('+234'),
                    SizedBox(width: 8),
                  ],
                ),
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your phone number';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            const Text(
              'Address Line 1*',
              style: TextStyle(color: Colors.black),
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Address Line 1*',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your address line 1';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            const Text('Address Line 2', style: TextStyle(color: Colors.black)),
            const TextField(
              decoration: InputDecoration(
                labelText: 'Address Line 2',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    decoration: const InputDecoration(
                      labelText: 'Country*',
                      border: OutlineInputBorder(),
                    ),
                    items: ['Country1', 'Country2']
                        .map((country) => DropdownMenuItem(
                              value: country,
                              child: Text(country),
                            ))
                        .toList(),
                    onChanged: (value) {},
                    validator: (value) {
                      if (value == null) {
                        return 'Please select a country';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    decoration: const InputDecoration(
                      labelText: 'State*',
                      border: OutlineInputBorder(),
                    ),
                    items: ['State1', 'State2']
                        .map((state) => DropdownMenuItem(
                              value: state,
                              child: Text(state),
                            ))
                        .toList(),
                    onChanged: (value) {},
                    validator: (value) {
                      if (value == null) {
                        return 'Please select a state';
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Post Code*',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your post code';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'City*',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your city';
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
            const Text(
              'Payment Option',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ToggleButtons(
              isSelected: [isCardPayment, !isCardPayment],
              onPressed: (index) {
                setState(() {
                  isCardPayment = index == 0;
                });
              },
              children: const [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 67),
                  child: Text(
                    'Card',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 50),
                  child: Text(
                    'Bank Transfer',
                    style: TextStyle(color: Colors.black45),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            if (isCardPayment) ...[
              const Text('Name on Card*',
                  style: TextStyle(color: Colors.black)),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Name on Card*',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the name on the card';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              const Text(
                'Card number*',
                style: TextStyle(color: Colors.black),
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Card number*',
                  prefixIcon: Icon(Icons.credit_card),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your card number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Expiry Date*',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the expiry date';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'CVV*',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the CVV';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}
