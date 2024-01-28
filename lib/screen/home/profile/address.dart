import 'package:flutter/material.dart';

class Address extends StatefulWidget {
  const Address({Key? key}) : super(key: key);

  @override
  State<Address> createState() => _AddressState();
}

class _AddressState extends State<Address> {
  // Initial state for the toggle buttons
  bool isHome = true;
  bool isOffice = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        shadowColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Address',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        leading: const BackButton(color: Colors.black),
      ),
      body: ListView(
        children: [
          Container(
              margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
              width: 327, //얘 왜 적용안됨 하...
              height: 223,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  'assets/images/address_map.png',
                  fit: BoxFit.cover, //얘가 있어야 ClipRRect에 borderradius 적용됨
                ),
              )),
          const SizedBox(height: 53),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Detail Address section
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Detail Address',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Icon(Icons.my_location_rounded)
                  ],
                ),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 24),
                      child: const Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.location_on_rounded),
                          SizedBox(width: 16),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Utama Street No.20',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                'state Street No.15, New York 10001, United States',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xffA6A6A6),
                                ),
                              ),
                            ],
                          )
                        ],
                      )),
                ),
                const Divider(color: Colors.grey),
                const SizedBox(height: 16),
                const Text('Save Address As',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    )),
                const SizedBox(height: 16),
                Row(
                  children: [
                    CustomToggleButton(
                      isSelected: isHome,
                      text: 'Home',
                      onToggle: () {
                        setState(() {
                          isHome = true;
                          isOffice = false;
                        });
                      },
                    ),
                    const SizedBox(width: 8),
                    CustomToggleButton(
                      isSelected: isOffice,
                      text: 'Office',
                      onToggle: () {
                        setState(() {
                          isHome = false;
                          isOffice = true;
                        });
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 92),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: const Text('Confirmation'),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CustomToggleButton extends StatelessWidget {
  final bool isSelected;
  final String text;
  final VoidCallback onToggle;

  const CustomToggleButton({
    Key? key,
    required this.isSelected,
    required this.text,
    required this.onToggle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onToggle,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xffFAF9FD) : Colors.transparent,
          borderRadius: BorderRadius.circular(25),
          border: Border.all(
            color:
                isSelected ? const Color(0xffFAF9FD) : const Color(0xffE8E8E8),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            color:
                isSelected ? const Color(0xff54408C) : const Color(0xffA6A6A6),
          ),
        ),
      ),
    );
  }
}
