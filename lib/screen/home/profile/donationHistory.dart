import 'package:flutter/material.dart';

class DonationHistory extends StatefulWidget {
  const DonationHistory({Key? key}) : super(key: key);

  @override
  State<DonationHistory> createState() => _DonationHistoryState();
}

class _DonationHistoryState extends State<DonationHistory>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
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
      body: TabBarView(
        controller: _tabController,
        children: const [
          //Placeholder widget
          DonationListWidget(status: 'In progress'),
          DonationListWidget(status: 'Complete'),
        ],
      ),
    );
  }
}

class DonationListWidget extends StatelessWidget {
  final String status;

  const DonationListWidget({
    Key? key,
    required this.status,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 임시 데이터 for donation list
    final donations = <Map>[
      {
        'title': 'Refrigerator (Samsung)',
        'status': 'In progress',
        'image': 'assets/images/samsung_refri.jpg',
      },
      {
        'title': 'HairDryer (Dyson)',
        'status': 'In progress',
        'image': 'assets/images/dyson.jpeg',
      },
      {
        'title': 'toy train (Tayo)',
        'status': 'Complete',
        'image': 'assets/images/dyson.jpeg',
      },
    ]
        .where((item) => item['status'] == status)
        .toList(); //status로 필터링된 list 보여주기

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: List.generate(donations.length, (index) {
            var donation = donations[index];
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
                            image: AssetImage(donation['image'] as String),
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
                              donation['status'] == 'In progress'
                                  ? '-'
                                  : 'Donated to ~~', //피기부자 이름 api 사용?
                            ),
                          ],
                        ),
                      ),
                      Icon(
                        donation['status'] == 'In progress'
                            ? Icons.favorite_border
                            : Icons.favorite,
                        color: const Color(0xff54408C),
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
