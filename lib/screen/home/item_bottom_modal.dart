import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildImageSection(productInfo.product_image_data),
        _buildDetailSection(),
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
          Text(
            productInfo.category,
            style: const TextStyle(
              color: Color(0xFFA5A5A5),
              fontSize: 14,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 30),
          _buildDonatorInfo(),
        ],
      ),
    );
  }

  Widget _buildDonatorInfo() {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Padding(
          padding: EdgeInsets.all(16.0),
          child: SizedBox(
            height: 75,
            width: 75,
            child: DecoratedBox(
              decoration: BoxDecoration(color: Colors.black),
            ),
          ),
        ),
        SizedBox(
          width: 180,
          child:
              Text("Information or Introduction of the donator or contributor"),
        )
      ],
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
