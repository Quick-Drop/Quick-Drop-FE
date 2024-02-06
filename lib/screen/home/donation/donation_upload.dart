import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'image_input.dart';
// import 'donation_ai_upload.dart';
import '../search.dart';
import 'package:http/http.dart' as http;

class DonationUpload extends StatefulWidget {
  const DonationUpload({super.key});

  @override
  State<DonationUpload> createState() => _DonationUploadState();
}

class _DonationUploadState extends State<DonationUpload> {
  final formKey = GlobalKey<FormState>();
  File? _pickedImage;
  bool _isEditingAll = false;
  final brandNameController = TextEditingController();
  final dateOfManufactureController = TextEditingController();
  final colorController = TextEditingController();
  final categoryController = TextEditingController();

  Map<String, dynamic> productInfo = {
    'Product Title': {
      'controller': TextEditingController(),
      'isEditing': true,
    },
    'Product description': {
      'controller': TextEditingController(),
      'isEditing': true,
    },
  };

  void sendPostRequest() async {
    final response = await http.post(
      Uri.parse(
          'https://c0d37d40-3638-49a9-942b-3fb838191686.mock.pstmn.io/upload'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'Product_Title': productInfo['Product Title']['controller'].text,
        'Product_description':
            productInfo['Product description']['controller'].text,
        'brandName': brandNameController.text,
        'dateOfManufacture': dateOfManufactureController.text,
        'color': colorController.text,
        'category': categoryController.text,
      }),
    );

    if (response.statusCode == 200) {
      // If the server returns a 200 OK response,
      // then parse the JSON.
      print('Success!');
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to create data.');
    }
  }

  void _navigateToScreen(Widget screen) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => screen),
    );
    if (result != null && result is File) {
      setState(() {
        _pickedImage = result;
      });
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    brandNameController.dispose();
    dateOfManufactureController.dispose();
    colorController.dispose();
    categoryController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          shadowColor: Colors.transparent,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: const Text(
            'Quick Drop',
            style: TextStyle(color: Colors.black),
          ),
          actions: [
            IconButton(
              icon: const Icon(
                Icons.search,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const SearchScreen();
                    },
                  ),
                );
              },
            ),
          ]),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 20),
              buildProductInfoContainer(),
              const SizedBox(height: 16),
              buildProductDetailsContainer(),
              const SizedBox(height: 16),
              buildWayAndDateToDonateContainer(),
              const SizedBox(height: 16),
              buildUploadButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildProductInfoContainer() {
    return Container(
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: const BorderSide(width: 1, color: Color(0xFFE8E8E8)),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      padding: const EdgeInsets.all(8),
      width: 327,
      height: 161,
      child: Column(
        children: [
          SizedBox(
            width: 295,
            height: 31,
            child: Row(
              children: [
                const Text(
                  'Prodcut Title',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                IconButton(
                  icon: const Icon(
                    Icons.mode,
                    size: 16,
                    color: Color(0xFF54408C),
                  ),
                  constraints: const BoxConstraints(),
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    setState(() {
                      _isEditingAll = !_isEditingAll;
                      productInfo.forEach((key, value) {
                        value['isEditing'] = _isEditingAll;
                      });
                    });
                  },
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                child: SizedBox(
                  height: 80,
                  width: 80,
                  // need to show image
                  child: _pickedImage == null
                      ? IconButton(
                          onPressed: () => _navigateToScreen(
                            ImageInput(
                              onSelectImage: (File pickedImage) {
                                Navigator.pop(
                                    context, pickedImage); // 선택한 사진을 결과로 반환
                              },
                            ),
                          ),
                          icon: const Icon(Icons.camera),
                        )
                      : Image.file(_pickedImage!),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 181,
                        height: 24,
                        child: productInfo['Product Title']['isEditing']
                            ? TextFormField(
                                key: const ValueKey(1),
                                controller: productInfo['Product Title']
                                    ['controller'],
                                decoration: const InputDecoration(
                                  hintText: "Ex.AirPod 2th Gen",
                                  hintStyle:
                                      TextStyle(fontWeight: FontWeight.bold),
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.zero,
                                ),
                              )
                            : Text(
                                productInfo['Product Title']['controller'].text,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                      ),
                      SizedBox(
                        width: 212,
                        height: 80,
                        child: productInfo['Product description']['isEditing']
                            ? TextFormField(
                                key: const ValueKey(2),
                                maxLines: null,
                                controller: productInfo['Product description']
                                    ['controller'],
                                decoration: const InputDecoration(
                                  hintText:
                                      "This is small book stand blah made in Republic of Korea blah",
                                  hintStyle: TextStyle(
                                      fontSize: 14,
                                      overflow: TextOverflow.visible),
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.zero,
                                ),
                              )
                            : Text(
                                productInfo['Product description']['controller']
                                    .text,
                                style: const TextStyle(
                                    fontSize: 14,
                                    overflow: TextOverflow.visible),
                              ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget buildRow(String text, String hintText, controller) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(text),
        SizedBox(
          width: 70,
          height: 20,
          child: buildTextFormField(hintText, controller),
        ),
      ],
    );
  }

  TextFormField buildTextFormField(String hintText, controller) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(fontSize: 14),
        isDense: true,
        border: InputBorder.none,
        contentPadding: EdgeInsets.zero,
      ),
    );
  }

  Widget buildProductDetailsContainer() {
    return SizedBox(
      width: 327,
      height: 224,
      child: Container(
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            side: const BorderSide(width: 1, color: Color(0xFFE8E8E8)),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Product Info',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontFamily: 'Open Sans',
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.54,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        // edit upload description
                      },
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      icon: const Icon(
                        Icons.mode,
                        color: Color(0xff54408C),
                        size: 18,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              buildRow('Name of Brand', "Ex.Apple", brandNameController),
              buildRow('Date of Manufacture', "2023.11.11",
                  dateOfManufactureController),
              buildRow('color', "Ex.black", colorController),
              buildRow('category', "Ex.Electronics", categoryController),
              Container(
                height: 64,
                alignment: Alignment.bottomLeft,
                child: TextButton.icon(
                  onPressed: () {
                    // See more Details
                  },
                  label: const Text('See more Details'),
                  icon: const Icon(Icons.chevron_right),
                ),
              ),
            ]),
      ),
    );
  }

  Widget buildWayAndDateToDonateContainer() {
    return SizedBox(
      width: 327,
      height: 176,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            side: const BorderSide(width: 1, color: Color(0xFFE8E8E8)),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Column(children: [
          const SizedBox(height: 16),
          const Align(
            alignment: Alignment.topLeft,
            child: Text(
              'Way and Date to Donate',
              style: TextStyle(
                color: Color(0xFF121212),
                fontSize: 18,
                fontFamily: 'Open Sans',
                fontWeight: FontWeight.w700,
                height: 0.08,
                letterSpacing: -0.54,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Icon(
                Icons.inventory,
                color: Color(0xff54408C),
              ),
              const SizedBox(
                width: 195,
                height: 44,
                child: SizedBox(
                  width: 195,
                  height: 44,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'How to Donate',
                        style: TextStyle(
                          color: Color(0xFF121212),
                          fontSize: 14,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'prefer the way in person',
                        style: TextStyle(
                          color: Color(0xFF7A7A7A),
                          fontSize: 14,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.chevron_right),
                onPressed: () {},
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Icon(
                Icons.date_range,
                color: Color(0xff54408C),
              ),
              const SizedBox(
                width: 195,
                height: 44,
                child: SizedBox(
                  width: 195,
                  height: 44,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Date & Time',
                        style: TextStyle(
                          color: Color(0xFF121212),
                          fontSize: 14,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        "let's arrange in a chat",
                        style: TextStyle(
                          color: Color(0xFF7A7A7A),
                          fontSize: 14,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.chevron_right),
                onPressed: () {},
              ),
            ],
          ),
        ]),
      ),
    );
  }

  Widget buildUploadButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        // showModalBottomSheet<void>(
        //   context: context,
        //   isScrollControlled: true,
        //   backgroundColor: Colors.transparent,
        //   builder: (context) {
        //     return Container(
        //       decoration: const BoxDecoration(
        //         color: Colors.white,
        //         borderRadius: BorderRadius.only(
        //           topLeft: Radius.circular(25.0),
        //           topRight: Radius.circular(25.0),
        //         ),
        //       ),
        //       height: MediaQuery.of(context).size.height * 0.88,
        //       child: const AiUploadScreen(),
        //     );
        //   },
        // );
        sendPostRequest();
      },
      child: const Text('Upload'),
    );
  }
}
