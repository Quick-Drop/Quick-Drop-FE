import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:quick_drop/services/api_constants.dart';
import '../../../userState.dart';

class DonationHistory extends StatefulWidget {
  const DonationHistory({Key? key}) : super(key: key);

  @override
  State<DonationHistory> createState() => _DonationHistoryState();
}

class _DonationHistoryState extends State<DonationHistory>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late Future<List<Map<String, dynamic>>> donationsFuture;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    donationsFuture = fetchDonations();
  }

  Future<List<Map<String, dynamic>>> fetchDonations() async {
    final int userId = UserState.getCurrentUserId();
    final response = await http
        .get(Uri.parse('${ApiConstants.BASE_URL}/user/$userId/donations'));

    if (response.statusCode == 200) {
      List<dynamic> products = jsonDecode(response.body);
      return products.map<Map<String, dynamic>>((product) {
        return {
          'title': product['description'],
          'donated': product['donated'] ? 'Complete' : 'In progress',
          'image': product['product_image_data'],
          'id': product['id'],
          'status': product['donated'],
        };
      }).toList();
    } else {
      throw Exception('Failed to load donations');
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        shadowColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Donation History',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        leading: const BackButton(color: Colors.black),
        bottom: TabBar(
          controller: _tabController,
          indicator: const BoxDecoration(color: Color(0xff54408C)),
          unselectedLabelColor: Colors.grey,
          tabs: const [
            Tab(text: 'In progress'),
            Tab(text: 'Complete'),
          ],
          // Customize the tab bar theme
          labelStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          unselectedLabelStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: donationsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return TabBarView(
              controller: _tabController,
              children: [
                DonationListWidget(
                    donated: 'In progress', donations: snapshot.data!),
                DonationListWidget(
                    donated: 'Complete', donations: snapshot.data!),
              ],
            );
          }
        },
      ),
    );
  }
}

class DonationListWidget extends StatefulWidget {
  final String donated;
  final List<Map<String, dynamic>> donations;

  const DonationListWidget({
    Key? key,
    required this.donated,
    required this.donations,
  }) : super(key: key);

  @override
  State<DonationListWidget> createState() => _DonationListWidgetState();
}

class _DonationListWidgetState extends State<DonationListWidget> {
  void _toggleFavorite(Map<String, dynamic> donation) async {
    final int userId = UserState.getCurrentUserId();
    final String newStatus =
        donation['donated'] == 'In progress' ? 'Complete' : 'In progress';

    await http.put(
      Uri.parse(
          '${ApiConstants.BASE_URL}/user/$userId/product/${donation['id']}/donated'),
      // body: {'donated': !donation['status']}
    );
    setState(() {
      donation['donated'] = newStatus;
    });
  }

  @override
  Widget build(BuildContext context) {
    // filtered 데이터 for donation list
    final filteredDonations = widget.donations
        .where((item) => item['donated'] == widget.donated)
        .toList();

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: List.generate(filteredDonations.length, (index) {
            var donation = filteredDonations[index];

            //image base64decode 잘 되는 지 test
            String base64Image = donation['image'];
            Uint8List bytes;
            try {
              bytes = base64Decode(base64Image);
            } catch (e) {
              bytes = Uint8List.fromList([]);
            }

            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 16), // Space between items
                  child: Row(
                    children: [
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          image: DecorationImage(
                            image: MemoryImage(bytes),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16.0),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              donation['title'],
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              donation['donated'] == 'In progress'
                                  ? '-'
                                  : 'Donated to ~~', //피기부자 이름 api 사용?
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () => _toggleFavorite(donation),
                        child: Icon(
                          donation['donated'] == 'In progress'
                              ? Icons.favorite_border
                              : Icons.favorite,
                          color: const Color(0xff54408C),
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(
                  height: 1,
                  thickness: 1,
                  color: Color(0xffE8E8E8),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
