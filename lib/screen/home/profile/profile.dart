import 'package:flutter/material.dart';
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
              Navigator.pushNamed(context, '/address');
            },
          ),
          ProfileListItem(
            title: 'Donation History',
            iconData: Icons.favorite_outline,
            onTap: () {
              Navigator.pushNamed(context, '/donationHistory');
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

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    // Replace with your actual header implementation
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        children: [
          const CircleAvatar(
            backgroundImage: NetworkImage('https://example.com/avatar.jpg'),
            radius: 40,
          ),
          const SizedBox(width: 16),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Daniel Park'),
                Text('010 - 5543 - 5252'),
              ],
            ),
          ),
          TextButton(
            onPressed: () => showLogoutDialog(context),
            style: TextButton.styleFrom(
              foregroundColor: const Color(0xffEF5A56),
            ),
            child: const Text('Logout'),
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
                onPressed: () => {},
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                child: const Text('Cancel'),
                onPressed: () => Navigator.pop(context),
              ),
              const SizedBox(height: 42)
            ],
          ),
        );
      },
    );
  }
}
