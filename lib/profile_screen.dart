import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:login_test/providers/auth.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});
  static const routeName = '/profile';

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _hideEmail = false;
  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  void _loadSettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _hideEmail = prefs.getBool('hideEmail') ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final profileData = Provider.of<Auth>(context).profile;
    const double avatarRadius = 70.0;
    if (_hideEmail) {}
    final List<Map<String, dynamic>> data = [
      {
        'title': 'name',
        'value': '${profileData.firstName} ${profileData.lastName}'
      },
      {'title': 'gender', 'value': profileData.gender},
      {'title': 'email', 'value': _hideEmail ? '' : profileData.email},
    ];
    return Container(
      height: MediaQuery.of(context).size.height,
      color: Theme.of(context).colorScheme.secondary,
      child: Padding(
        padding:
            EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.02),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.15,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30)),
            color: Theme.of(context).colorScheme.primary,
          ),
          child: Padding(
            padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.035),
            child: Column(children: [
              const SizedBox(height: 20),
              Expanded(
                child: SingleChildScrollView(
                  child: Stack(children: [
                    Padding(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.07),
                      child: Container(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height * 0.9,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30)),
                          color: Colors.white,
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.12,
                              left: 20,
                              right: 20),
                          child: ListView.builder(
                            physics: const AlwaysScrollableScrollPhysics(),
                            itemCount: data.length,
                            itemBuilder: (context, index) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    data[index]['title'] as String,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16,
                                        color: Theme.of(context).primaryColor),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    data[index]['value'] as String,
                                    style: const TextStyle(
                                        fontSize: 16, color: Colors.black),
                                  ),
                                  const Divider(
                                    color: Color.fromRGBO(179, 179, 179, 1),
                                  ),
                                  const SizedBox(height: 10),
                                ],
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: (MediaQuery.of(context).size.width / 2) -
                          avatarRadius,
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: avatarRadius,
                        child: CircleAvatar(
                          radius: avatarRadius - 10,
                          backgroundImage: NetworkImage(profileData.image),
                        ),
                      ),
                    ),
                  ]),
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
