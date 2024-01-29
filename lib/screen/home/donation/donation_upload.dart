import 'package:flutter/material.dart';
import '../search.dart';

class DonationUpload extends StatelessWidget {
  const DonationUpload({super.key});

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
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Container(
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                  side: const BorderSide(width: 1, color: Color(0xFFE8E8E8)),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              padding: const EdgeInsets.all(16),
              width: 327,
              height: 161,
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Product Title',
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
                              //edit upload description
                            },
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                            icon: const Icon(
                              Icons.mode,
                              color: Color(0xff54408C),
                              size: 18,
                            ))
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Align(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          color: Colors.black,
                          child: const SizedBox(
                            // instead of Image, ImagePicker will be here
                            width: 70,
                            height: 68,
                          ),
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 40,
                              child: Text(
                                'book shelves stand black',
                                style: TextStyle(
                                  color: Color(0xFF121212),
                                  fontSize: 16,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w600,
                                  height: 0.09,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 200,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Flexible(
                                      child: RichText(
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                          text: const TextSpan(
                                            text: 'This is small book stand',
                                            style: TextStyle(
                                              color: Color(0xFFA5A5A5),
                                              fontSize: 14,
                                              fontFamily: 'Roboto',
                                              fontWeight: FontWeight.w400,
                                              height: 0.10,
                                            ),
                                          )))
                                ],
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
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
                child: Column(children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Product Title',
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
                            //edit upload description
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
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [Text('Name of Brand'), Text('Han-ssem')],
                  ),
                  const SizedBox(height: 8),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [Text('Date of Manufacture'), Text('2023-11-11')],
                  ),
                  const SizedBox(height: 8),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [Text('Color'), Text('black')],
                  ),
                  const SizedBox(height: 8),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [Text('category'), Text('Funiture')],
                  ),
                  Container(
                    height: 64,
                    alignment: Alignment.bottomLeft,
                    child: TextButton.icon(
                      onPressed: () {
                        //See more Details
                      },
                      label: const Text('See more Details'),
                      icon: const Icon(Icons.chevron_right),
                    ),
                  ),
                ]),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
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
                ]),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                //Upload Modal sheet
              },
              child: const Text('Upload'),
            )
          ],
        ),
      ),
    );
  }
}
