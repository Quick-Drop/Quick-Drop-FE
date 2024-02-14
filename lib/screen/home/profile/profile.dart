// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:quick_drop/services/api_constants.dart';
import '../../../userState.dart';
import 'myAccount.dart';
import 'address.dart';
import 'donationHistory.dart';
import 'helpCenter.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.only(left: 24, right: 24),
        children: <Widget>[
          const ProfileHeader(),
          ProfileListItem(
            title: 'My Account',
            iconData: Icons.person_outline,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const MyAccount()),
              );
            },
          ),
          ProfileListItem(
            title: 'Address',
            iconData: Icons.location_on_outlined,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Address()),
              );
            },
          ),
          ProfileListItem(
            title: 'Donation History',
            iconData: Icons.favorite_outline,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const DonationHistory()),
              );
            },
          ),
          ProfileListItem(
            title: 'Help Center',
            iconData: Icons.help_outline,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HelpCenter()),
              );
            },
          ),
        ],
      ),
    );
  }
}

class ProfileListItem extends StatelessWidget {
  final String title;
  final IconData iconData;
  final VoidCallback onTap;

  const ProfileListItem({
    required this.title,
    required this.iconData,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.only(top: 16, bottom: 16),
      leading: Icon(iconData),
      title: Text(title),
      trailing: const Icon(Icons.arrow_forward_ios),
      onTap: onTap,
    );
  }
}

class ProfileHeader extends StatefulWidget {
  const ProfileHeader({super.key});

  @override
  State<ProfileHeader> createState() => _ProfileHeaderState();
}

class _ProfileHeaderState extends State<ProfileHeader> {
  String username = '';
  String phoneNumber = '';

  bool get isUserLoggedIn => UserState.getCurrentUserId() != 0;

  @override
  void initState() {
    super.initState();
    fetchUserProfile();
  }

  Future<void> fetchUserProfile() async {
    var userId = UserState.getCurrentUserId(); // Get current user id
    var response = await http
        .get(Uri.parse('${ApiConstants.BASE_URL}/user/$userId/profile'));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      setState(() {
        username = data['name'] ?? 'Not Loginned';
        phoneNumber = phoneNumber = data['phone_number'] ?? ' ';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Replace with your actual header implementation
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        children: [
          const CircleAvatar(
            backgroundColor: Color(0xffE7E1F8),
            backgroundImage: AssetImage('assets/images/user_default.png'),
            radius: 40,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  username,
                  style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff54408C)),
                ),
                Text(
                  phoneNumber,
                  style: const TextStyle(color: Colors.black),
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: isUserLoggedIn
                ? () => showLogoutDialog(context)
                : () => navigateToSignIn(context),
            style: TextButton.styleFrom(
              foregroundColor: const Color(0xffEF5A56),
            ),
            child: Text(isUserLoggedIn ? 'Logout' : 'Login'),
          ),
        ],
      ),
    );
  }

  void showLogoutDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(32),
          topRight: Radius.circular(32),
        ),
      ),
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(30),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Logout',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 16),
                  Text('Are you sure you want to log out?',
                      style: TextStyle(fontSize: 16)),
                ],
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                child: const Text('Logout'),
                onPressed: () => performLogout(context),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xffFAF9FD),
                ),
                child: const Text(
                  'Cancel',
                  style: TextStyle(
                    color: Color(0xff54408C),
                  ),
                ),
              ),
              const SizedBox(height: 42)
            ],
          ),
        );
      },
    );
  }

  void navigateToSignIn(BuildContext context) {
    Navigator.pushReplacementNamed(context, '/signIn');
  }

  void performLogout(BuildContext context) async {
    UserState.setCurrentUserId(0);
    // const storage = FlutterSecureStorage();
    // await storage.delete(key: 'token');

    Navigator.pop(context);
    Navigator.pushReplacementNamed(context, '/signIn');
  }
}
