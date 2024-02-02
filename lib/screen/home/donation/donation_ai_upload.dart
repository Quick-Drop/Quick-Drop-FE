import 'package:flutter/material.dart';

class AiUploadScreen extends StatelessWidget {
  const AiUploadScreen({super.key});

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
            child: const Row(
              children: [
                Icon(Icons.camera),
                Flexible(
                  child: Text(
                    'If the auto-description doesn’t work enough,you can edit it by yourself',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ),
              ],
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
                        const Text(
                          'Book stand Book',
                          style: TextStyle(
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
                          child: const Center(
                            child: Text(
                              'Funiture',
                              style: TextStyle(
                                  color: Color(0xFF54408C),
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [Text('Category'), Text('Furniture')],
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [Text('Color'), Text('black')],
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Date of Manufacture'),
                        Text('2023.11.11')
                      ],
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Name of Brand'),
                        Text('Han-ssam'),
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
