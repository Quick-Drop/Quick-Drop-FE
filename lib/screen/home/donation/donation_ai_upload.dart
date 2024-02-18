import 'package:flutter/material.dart';
import '../../../services/upload_post_api.dart';
import 'dart:io';

class AiUploadScreen extends StatefulWidget {
  final String productTitle;
  final String productDescription;
  final String brandName;
  final DateTime dateOfManufacture;
  final String color;
  final String category;
  final File image;
  final Function(String) onSave;

  const AiUploadScreen({
    Key? key,
    required this.productTitle,
    required this.productDescription,
    required this.brandName,
    required this.dateOfManufacture,
    required this.color,
    required this.category,
    required this.image,
    required this.onSave,
  }) : super(key: key);

  @override
  State<AiUploadScreen> createState() => _AiUploadScreenState();
}

class _AiUploadScreenState extends State<AiUploadScreen> {
  String categoryText = '';
  bool isLoading = false;

  Future<void> _uploadImageAndSetCategory() async {
    setState(() {
      isLoading = true; // Show loading indicator
    });
    try {
      String categoryText =
          await UploadApi.uploadImageAndGetCategory(widget.image);
      // Extract 'Utensil' from the result string
      if (categoryText.contains(':')) {
        categoryText = categoryText.split(':')[1].trim();
      }

      categoryText = categoryText.replaceAll(
          RegExp(r'[^\w\s]'), ''); // Remove non-word characters
      categoryText =
          categoryText.trim(); // Remove leading and trailing whitespace
      setState(() {
        this.categoryText = categoryText; // Update category text field
        isLoading = false; // Hide loading indicator
      });
    } catch (e) {
      setState(() {
        isLoading = false; // Hide loading indicator
      });
      print('Error uploading image and getting category: $e');
      // Handle error here, such as displaying an error message to the user
    }
  }

  @override
  void initState() {
    super.initState();
    _uploadImageAndSetCategory();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _uploadImageAndSetCategory();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 36,
            ),
            Container(
              width: 305,
              height: 305,
              decoration: BoxDecoration(
                color: Colors.transparent,
                border: Border.all(color: Colors.black, width: 2),
              ),
              child: Image.file(
                widget.image,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Container(
              width: 327,
              height: 232,
              decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xFFE8E8E8), width: 1),
                  borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.productTitle,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          Container(
                            width: 80,
                            height: 36,
                            decoration: BoxDecoration(
                              color: const Color(0xFFFAF9FD),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Center(
                              child: isLoading
                                  ? const Text(
                                      "Ai is working!",
                                      style: TextStyle(
                                          color: Color(0xFF54408C),
                                          fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.center,
                                    )
                                  : Text(
                                      categoryText,
                                      style: const TextStyle(
                                        color: Color(0xFF54408C),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                      ),
                                    ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Category'),
                          isLoading
                              ? const Text("Will be updated by AI")
                              : Text(categoryText)
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [const Text('Color'), Text(widget.color)],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Date of Manufacture'),
                          Text(
                            "${widget.dateOfManufacture.year.toString()}.${widget.dateOfManufacture.month.toString().padLeft(2, '0')}.${widget.dateOfManufacture.day.toString().padLeft(2, '0')}",
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Name of Brand'),
                          Text(widget.brandName),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const Flexible(
                            child: Text(
                              'If the auto-description doesn’t work enough,you can edit it by yourself',
                              style: TextStyle(fontSize: 11),
                            ),
                          ),
                          IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.mode_edit))
                        ],
                      )
                    ]),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Container(
              padding: const EdgeInsets.all(16),
              width: 327,
              height: 96,
              decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xFFE8E8E8), width: 1),
                  borderRadius: BorderRadius.circular(12)),
              child: Row(
                children: [
                  const Flexible(
                    child: Text(
                      'Write down here by your selft and explain in detail as much as you want the product to be uploaded.',
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                  IconButton(
                      onPressed: () {}, icon: const Icon(Icons.mode_edit))
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        minimumSize: const Size(150, 44),
                        backgroundColor: Colors.grey),
                    onPressed: () {
                      // chat으로 이동
                    },
                    child: const Text('Cancel'),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        minimumSize: const Size(150, 44)),
                    onPressed: () {
                      widget.onSave(categoryText);
                    },
                    child: const Text('Save'),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
