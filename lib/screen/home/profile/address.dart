import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart' as http;
import 'package:quick_drop/services/api_constants.dart';
import '../../../userState.dart';

class Address extends StatefulWidget {
  const Address({Key? key}) : super(key: key);

  @override
  State<Address> createState() => _AddressState();
}

class _AddressState extends State<Address> {
  late GoogleMapController mapController;
  String _formattedAddress = '';
  final TextEditingController _additionalAddressController =
      TextEditingController();

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  bool isHome = true;
  bool isOffice = false;

  // 위치 선택 시 주소 가져오기(Geocoding API를 호출 -> 주소 정보 get
  void _onTap(LatLng position) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    if (placemarks.isNotEmpty) {
      Placemark place = placemarks.first;
      String formattedAddress =
          '${place.street}, ${place.locality}, ${place.postalCode}, ${place.country}';
      setState(() {
        _formattedAddress = formattedAddress; // 예시로 street 값을 사용
      });
    }
  }

// 서버에 주소 정보 전달
  Future<void> _saveAddressToServer() async {
    var userId = UserState.getCurrentUserId();
    String fullAddress =
        '$_formattedAddress, ${_additionalAddressController.text}';

    var response = await http.put(
      Uri.parse('${ApiConstants.BASE_URL}/user/$userId/location'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'address': fullAddress}),
    );
    if (response.statusCode == 200) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Success'),
            content: const Text('Your changes just got saved well :)'),
            actions: <Widget>[
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop(); // Dismiss the alert dialog
                },
              ),
            ],
          );
        },
      );
    } else {
      // 실패 처리
    }
  }

  // 저장된 주소 가져오기
  Future<void> fetchAddressData() async {
    var userId = UserState.getCurrentUserId();
    final response = await http
        .get(Uri.parse('${ApiConstants.BASE_URL}/user/$userId/location'));
    if (response.statusCode == 200) {
      final String decodedBody = utf8.decode(response.bodyBytes);
      final data = jsonDecode(decodedBody);
      final fullAddress = data['address'];
      final addressParts = fullAddress.split(',');

      setState(() {
        if (addressParts.length > 4) {
          _formattedAddress = addressParts.sublist(0, 4).join(', ');
          _additionalAddressController.text =
              addressParts.sublist(4).join(', ');
        } else {
          _formattedAddress = fullAddress;
          _additionalAddressController.text = '';
        }
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchAddressData();
  }

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
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
            width: 327,
            height: 223,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: GoogleMap(
                onMapCreated: _onMapCreated,
                onTap: _onTap,
                initialCameraPosition: const CameraPosition(
                  target: LatLng(37.5972565, 127.0581605),
                  zoom: 15.0,
                ),
              ),
            ),
          ),
          const SizedBox(height: 53),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Detail Address',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    Icon(Icons.my_location_rounded)
                  ],
                ),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 24),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(Icons.location_on_rounded),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _formattedAddress,
                                softWrap: true,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              TextFormField(
                                controller: _additionalAddressController,
                                decoration: const InputDecoration(
                                  hintText:
                                      'Enter additional address info here',
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
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
                    onPressed: _saveAddressToServer,
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
