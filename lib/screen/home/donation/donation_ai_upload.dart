import 'package:flutter/material.dart';

import 'dart:io';

class AiUploadScreen extends StatelessWidget {
  final String productTitle;
  final String productDescription;
  final String brandName;
  final String dateOfManufacture;
  final String color;
  final String category;
  final File image;

  const AiUploadScreen(
      {Key? key,
      required this.productTitle,
      required this.productDescription,
      required this.brandName,
      required this.dateOfManufacture,
      required this.color,
      required this.category,
      required this.image})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
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
            child:
                //  Row(
                //   children: [
                //     IconButton(
                //       icon: const Icon(Icons.camera),
                //       onPressed: () {},
                //     ),
                //     const Flexible(
                //       child: Text(
                //         'If the auto-description doesn’t work enough,you can edit it by yourself',
                //         style: TextStyle(fontSize: 12, color: Colors.grey),
                //       ),
                //     ),
                //   ],
                // )
                Image.file(
              image,
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
                          productTitle,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        Container(
                          width: 100,
                          height: 36,
                          decoration: BoxDecoration(
                            color: const Color(0xFFFAF9FD),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Center(
                            child: Text(
                              category,
                              style: const TextStyle(
                                  color: Color(0xFF54408C),
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [const Text('Category'), Text(category)],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [const Text('Color'), Text(color)],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Date of Manufacture'),
                        Text(dateOfManufacture)
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Name of Brand'),
                        Text(brandName),
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
                            onPressed: () {}, icon: const Icon(Icons.mode_edit))
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
                IconButton(onPressed: () {}, icon: const Icon(Icons.mode_edit))
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
                    // chat으로 이동
                  },
                  child: const Text('Save'),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
