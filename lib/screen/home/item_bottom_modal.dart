import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../services/api_constants.dart';
import '../../services/product_list_api.dart';

class ItemBottomModal extends StatefulWidget {
  final ProductInfo productInfo;

  const ItemBottomModal({Key? key, required this.productInfo})
      : super(key: key);

  @override
  _ItemBottomModalState createState() => _ItemBottomModalState(productInfo);
}

class _ItemBottomModalState extends State<ItemBottomModal> {
  final ProductInfo productInfo;
  _ItemBottomModalState(this.productInfo);

  Future<Map<String, dynamic>> fetchUserInfo(int userId) async {
    final response = await http.get(
      Uri.parse('${ApiConstants.BASE_URL}/user/$userId/profile'),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load user info');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildImageSection(productInfo.product_image_data),
        _buildDetailSection(),
        const SizedBox(
          height: 30,
        ),
        _buildButtonSection(),
      ],
    );
  }

  Widget _buildImageSection(String base64String) {
    List<int> bytes = base64.decode(base64String);
    Uint8List uint8List = Uint8List.fromList(bytes);
    Image image = Image.memory(uint8List);

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: SizedBox(
          height: 300,
          width: 300,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: Colors.black,
              image: DecorationImage(
                image: image.image,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDetailSection() {
    return SizedBox(
      width: 311,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            productInfo.title,
            style: const TextStyle(
              color: Color(0xFF121212),
              fontSize: 20,
              fontFamily: 'Open Sans',
              fontWeight: FontWeight.w700,
              height: 0.07,
              letterSpacing: -0.60,
            ),
          ),
          const SizedBox(height: 30),
          Text(
            productInfo.description,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w300,
              height: 0.09,
            ),
          ),
          const SizedBox(height: 30),
          FutureBuilder<Map<String, dynamic>>(
            future: fetchUserInfo(productInfo.user_id),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasData) {
                final address = snapshot.data!['address']
                    .split(',')
                    .sublist(0, 4)
                    .join(', ');
                return Text(
                  address,
                  style: const TextStyle(
                    color: Color(0xFFA5A5A5),
                    fontSize: 14,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w400,
                  ),
                );
              } else if (snapshot.hasError) {
                return const Center(child: Text('Error loading donor info'));
              }
              return Container();
            },
          ),
          const SizedBox(height: 30),
          _buildDonatorInfo(),
        ],
      ),
    );
  }

  Widget _buildDonatorInfo() {
    return FutureBuilder<Map<String, dynamic>>(
      future: fetchUserInfo(productInfo.user_id),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                height: 70,
                width: 70,
                child: Image.asset(
                  'assets/images/user_default.png',
                  fit: BoxFit.cover,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${snapshot.data!['name']}'),
                ],
              ),
            ],
          ); // 예제로 사용자의 이름을 표시합니다.
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        return const CircularProgressIndicator(); // 데이터를 기다리는 동안 로딩 표시
      },
    );
  }

  Widget _buildButtonSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildButton('Ask to Chat'),
        _buildButton('Ask to donate'),
      ],
    );
  }

  Widget _buildButton(String text) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(minimumSize: const Size(150, 44)),
      onPressed: () {
        // chat으로 이동
      },
      child: Text(text),
    );
  }
}
